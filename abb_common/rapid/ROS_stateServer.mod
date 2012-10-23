MODULE ROS_stateServer

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
LOCAL VAR num server_port := 11002;

PROC main()
	TCP_init;
	while ( true ) do
		WaitTime .050;
		!Send Mode to Client
		send_mode;
		!Send Status to Client
		send_status;
		!Send EStop State to Client
		send_estop;
		!Send Joint Angles to Client
		send_joints;
	endwhile
	SocketClose server_socket;
	SocketClose client_socket;
	ERROR
		IF ERRNO=ERR_SOCK_TIMEOUT THEN
			RETRY;
		ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
			TCP_init;
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

LOCAL PROC send_mode()
	VAR num mode;
	VAR rawbytes message;
	
	VAR num data_length := 0;
	VAR num packet_length := 25; ! = 12 + 4 + 4 + 4 + 1
	VAR num message_type :=  30; !Message type 1E=30 is a state message
	VAR num comm_type := 1;
	VAR num reply_code := 0; !No reply
	VAR num state_message_type := 1; !Message type mode
	VAR num alert_level := 0; !Alert level OK
	
	TEST OpMode()
		CASE OP_AUTO:
			mode := 1; !auto
		CASE OP_MAN_PROG:
			mode := 2; !manual
		CASE OP_MAN_TEST:
			mode := 2; !manual
		DEFAULT:
			mode := 8; !undefined
	ENDTEST
	
	!Pack data
	PackRawBytes packet_length, message, (RawBytesLen(message)+1), \IntX := DINT; !Packet length
	PackRawBytes message_type, message, (RawBytesLen(message)+1), \IntX := DINT; !Message type
	PackRawBytes comm_type, message, (RawBytesLen(message)+1), \IntX := DINT; !Comm type
	PackRawBytes reply_code, message, (RawBytesLen(message)+1), \IntX := DINT; !Reply code
	PackRawBytes data_length, message, (RawBytesLen(message)+1), \IntX := DINT; !Data length
	PackRawBytes mode, message, (RawBytesLen(message)+1), \IntX := UDINT; !mode value
	PackRawBytes state_message_type, message, (RawBytesLen(message)+1), \IntX := UDINT; !message type estop
	PackRawBytes alert_level, message, (RawBytesLen(message)+1), \IntX := USINT; !message alert level OK
	!Send data
	SocketSend client_socket \RawData := message;
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

LOCAL PROC send_status()
	VAR num status;
	VAR string err_msg;
	VAR rawbytes message;
	
	VAR num data_length;
	VAR num packet_length;
	VAR num message_type :=  30; !Message type 1E=30 is a state message
	VAR num comm_type := 1;
	VAR num reply_code := 0; !No reply
	VAR num state_message_type := 2; !Message type status
	VAR num alert_level := 0; !Alert level OK
	
	data_length := StrLen(err_msg);
	packet_length := 25 + data_length; ! = 12 + 4 + 4 + 4 + 1
	
	!Get status
	!Currently just sends ok because this is a pain to implement
	status := 0;
	
	!Pack data
	PackRawBytes packet_length, message, (RawBytesLen(message)+1) \IntX := DINT; !Packet length
	PackRawBytes message_type, message, (RawBytesLen(message)+1) \IntX := DINT; !Message type
	PackRawBytes comm_type, message, (RawBytesLen(message)+1) \IntX := DINT; !Comm type
	PackRawBytes reply_code, message, (RawBytesLen(message)+1) \IntX := DINT; !Reply code
	PackRawBytes data_length, message, (RawBytesLen(message)+1) \IntX := DINT; !Data length
	PackRawBytes status, message, (RawBytesLen(message)+1) \IntX := UDINT; !status value
	PackRawBytes state_message_type, message, (RawBytesLen(message)+1) \IntX := UDINT; !message type estop
	PackRawBytes alert_level, message, (RawBytesLen(message)+1) \IntX := USINT; !message alert level OK
	!Send data
	SocketSend client_socket \RawData := message;
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

!Note: Configuration must be set to put estop status on virtual I/O estop_sig
LOCAL PROC send_estop()
	VAR num estop;
	VAR rawbytes message;
	
	VAR num data_length := 0;
	VAR num packet_length := 25; ! = 12 + 4 + 4 + 4 + 1
	VAR num message_type :=  30; !Message type 1E=30 is a state message
	VAR num comm_type := 1;
	VAR num reply_code := 0; !No reply
	VAR num state_message_type := 4; !Message type estop
	VAR num alert_level := 0; !Alert level OK
	
!	IF DOutput(estop_sig) = 1 THEN
!		estop := 1;
!	ELSE
		estop := 0;
!	ENDIF
	
	!Pack data
	PackRawBytes packet_length, message, (RawBytesLen(message)+1) \IntX := DINT; !Packet length
	PackRawBytes message_type, message, (RawBytesLen(message)+1) \IntX := DINT; !Message type
	PackRawBytes comm_type, message, (RawBytesLen(message)+1) \IntX := DINT; !Comm type
	PackRawBytes reply_code, message, (RawBytesLen(message)+1) \IntX := DINT; !Reply code
	PackRawBytes data_length, message, (RawBytesLen(message)+1) \IntX := DINT; !Data length 0
	PackRawBytes estop, message, (RawBytesLen(message)+1) \IntX := UDINT; !estop value
	PackRawBytes state_message_type, message, (RawBytesLen(message)+1) \IntX := UDINT; !message type estop
	PackRawBytes alert_level, message, (RawBytesLen(message)+1) \IntX := USINT; !message alert level OK
	!Send data
	SocketSend client_socket \RawData := message;
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

LOCAL PROC send_joints()
	VAR rawbytes message;
	
	VAR num data_length := 0;
	VAR num packet_length := 56; ! = 12 + 4 + 10 * 4
	VAR num message_type :=  10; !Message type 0A=10 is a joint message
	VAR num comm_type := 1;
	VAR num reply_code := 0; !No reply
	VAR num seq := 0; 
	VAR jointtarget joints;
	
	!Pack data
	PackRawBytes packet_length, message, (RawBytesLen(message)+1), \IntX := DINT; !Packet length
	PackRawBytes message_type, message, (RawBytesLen(message)+1), \IntX := DINT; !Message type
	PackRawBytes comm_type, message, (RawBytesLen(message)+1), \IntX := DINT; !Comm type
	PackRawBytes reply_code, message, (RawBytesLen(message)+1), \IntX := DINT; !Reply code
	PackRawBytes seq, message, (RawBytesLen(message)+1), \IntX := DINT; !Reply code
	
	joints := CJointT();
	FOR jointnum from 1 to 10 DO
		IF jointnum = 1 THEN
			PackRawBytes joints.robax.rax_1, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSEIF jointnum = 2 THEN
			PackRawBytes joints.robax.rax_2, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSEIF jointnum = 3 THEN
			PackRawBytes joints.robax.rax_3, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSEIF jointnum = 4 THEN
			PackRawBytes joints.robax.rax_4, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSEIF jointnum = 5 THEN
			PackRawBytes joints.robax.rax_5, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSEIF jointnum = 6 THEN
			PackRawBytes joints.robax.rax_6, message, (RawBytesLen(message)+1), \Float4; !Send the joint angle in radians
		ELSE
			PackRawBytes 0, message, (RawBytesLen(message)+1), \Float4; !The robot has only 6 joints, but the message requires 10
		ENDIF
	ENDFOR
	!Send data
	SocketSend client_socket \RawData := message;
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