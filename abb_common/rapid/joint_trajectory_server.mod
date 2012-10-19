MODULE joint_trajectory_server

! Software License Agreement (BSD License)
!
! Copyright (c) 2012, Edward Venator, Case Western Reserve University
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without modification,
! are permitted provided that the following conditions are met:
!
!   Redistributions of source code must retain the above copyright notice, this
!       list of conditions and the following disclaimer.
!   Redistributions in binary form must reproduce the above copyright notice, this
!       list of conditions and the following disclaimer in the documentation
!       and/or other materials provided with the distribution.
!   Neither the name of the Case Western Reserve University nor the names of its contributors
!       may be used to endorse or promote products derived from this software without
!       specific prior written permission.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
! EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
! OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
! SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
! INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
! TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
! BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
! CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
! WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

LOCAL VAR socketdev server_socket;
LOCAL VAR socketdev client_socket;
LOCAL VAR num server_port := 11000;
LOCAL VAR rawbytes buffer;
LOCAL VAR rawbytes reply_msg;

LOCAL VAR num sequence_ptr;
LOCAL VAR JointTrajectoryPt tmp_trajectory{100};

PROC main()
	VAR string client_ip;
	!Set up reply message (it's always the same)
	PackRawBytes 12, reply_msg, (RawBytesLen(reply_msg)+1), \IntX := DINT; !Packet length
	PackRawBytes 1, reply_msg, (RawBytesLen(reply_msg)+1), \IntX := DINT; !Message type
	PackRawBytes 1, reply_msg, (RawBytesLen(reply_msg)+1), \IntX := DINT; !Comm type
	PackRawBytes 0, reply_msg, (RawBytesLen(reply_msg)+1), \IntX := DINT; !Reply code

	TCP_init;
	WHILE ( true ) DO
		!Recieve Joint Trajectory Pt Message
		SocketReceive client_socket \RawData:=buffer \Time:=WAIT_MAX;
		trajectory_pt_callback;
	ENDWHILE
	SocketClose server_socket;
	SocketClose client_socket;
	ERROR
		IF ERRNO=ERR_SOCK_TIMEOUT THEN
			RETRY;
		ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
			TPWrite "Connection lost. Waiting for client to reconnect.";
			connect_client;
			RETRY;
		ELSE
			! No error recovery handling
		ENDIF
ENDPROC

LOCAL PROC connect_client()
	VAR string client_ip := "";
	WHILE strlen(client_ip) = 0 DO
		SocketAccept server_socket, client_socket, \ClientAddress:=client_ip;
	ENDWHILE
	TPWrite "Client at "+client_ip+" connected.";
	TPWrite "Client connected.";
	ERROR
		IF ERRNO=ERR_SOCK_TIMEOUT THEN
			TRYNEXT;
		ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
			TCP_init;
			RETRY;
		ENDIF
ENDPROC

LOCAL PROC TCP_init()
	VAR string client_ip;
!	SocketClose server_socket;
	SocketCreate server_socket;
	SocketBind server_socket, server_ip, server_port;
	SocketListen server_socket;
	TPWrite "Server socket initializated. Waiting for client connection.";
	connect_client;
	ERROR
		IF ERRNO=ERR_SOCK_CLOSED THEN
			TRYNEXT;
		ELSEIF ERRNO=ERR_SOCK_TIMEOUT THEN
			RETRY;
		ENDIF
ENDPROC

LOCAL PROC trajectory_pt_callback()
	VAR num index :=1;
	VAR num packet_length;
	VAR num type;
	VAR num reply_code;
	VAR num sequence;
	
	VAR num joint_tmp;
	VAR JointTrajectoryPt point;
	VAR jointtarget current_pos;
	
	UnpackRawBytes buffer, index, packet_length, \IntX:=UDINT;
	index := index + 4;
	UnpackRawBytes buffer, index, type, \IntX:=UDINT;
	index := index + 4;
	index := index + 4; !skip comm type because we don't care
	UnpackRawBytes buffer, index, reply_code, \IntX:=UDINT;
	index := index + 4;
	UnpackRawBytes buffer, index, sequence, \IntX:=DINT;
	index := index + 4;
	
	UnpackRawBytes buffer, index, point.joint_pos.rax_1, \Float4; !Get the joint angle in radians
	index := index + 4;
	UnpackRawBytes buffer, index, point.joint_pos.rax_2, \Float4; !Get the joint angle in radians
	index := index + 4;
	UnpackRawBytes buffer, index, point.joint_pos.rax_3, \Float4; !Get the joint angle in radians
	index := index + 4;
	UnpackRawBytes buffer, index, point.joint_pos.rax_4, \Float4; !Get the joint angle in radians
	index := index + 4;
	UnpackRawBytes buffer, index, point.joint_pos.rax_5, \Float4; !Get the joint angle in radians
	index := index + 4;
	UnpackRawBytes buffer, index, point.joint_pos.rax_6, \Float4; !Get the joint angle in radians
	index := index + 20;
	UnpackRawBytes buffer, index, point.velocity, \Float4;
	
	TEST sequence
		CASE -1: !Start of download
			point.stop := false; !Don't stop on this point
			sequence_ptr := 0; !This is the first point in the sequence
			tmp_trajectory{sequence_ptr + 1} := point; !Add this point to the trajectory
		CASE -2: !Start of stream. Handles streams the same as downloads for now.
			point.stop := false; !Don't stop on this point
			sequence_ptr := 0; !This is the first point in the sequence
			tmp_trajectory{sequence_ptr + 1} := point; !Add this point to the trajectory
		CASE -3: !End of stream
			point.stop := true; !Stop on this point
			sequence_ptr := sequence_ptr + 1; !Set sequence number to 1 higher than max
			tmp_trajectory{sequence_ptr + 1} := point; !Add this point to the trajectory
			trajectory_acquireWriteLock; !Wait for access to the trajectory to prevent race conditions
			trajectory := tmp_trajectory; !Write the local trajectory to the shared trajectory
			trajectory_setIRQ; !Set an interrupt so the motion process knows to get the trajectory
		CASE -4: !Stop command
			!Replace the current trajectory with a trajectory to stop at the current position
			current_pos := CJointT(); !Get the current position
			point.joint_pos := current_pos.robax; !Go to the current position
			point.velocity := 0; !Velocity should be 0
			point.stop := true; !Stop on the current position
			trajectory_acquireWriteLock; !Wait for access to the trajectory to prevent race conditions
			trajectory{1} := point; !Write the (single point) trajectory to the shared trajectory
			trajectory_setIRQ; !Set an interrupt so the motion process knows to get the trajectory
		DEFAULT:
			point.stop := false;
			sequence_ptr := sequence; !Increment the max sequence number
			tmp_trajectory{sequence_ptr + 1} := point; !Add this point to the trajectory
	ENDTEST
	
	SocketSend client_socket \RawData := reply_msg;
	
	ERROR
		IF ERRNO=ERR_SOCK_TIMEOUT THEN
			RETRY;
		ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
			TPWrite "Connection lost. Waiting for client to reconnect.";
			connect_client;
			RETRY;
		ELSE
			! No error recovery handling
		ENDIF
ENDPROC
	
ENDMODULE