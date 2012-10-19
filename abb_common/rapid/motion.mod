MODULE motion_module

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

LOCAL VAR num sequence_ptr := 0;
LOCAL VAR JointTrajectoryPt motion_trajectory{100};
LOCAL VAR jointtarget target := [[0,0,0,0,0,0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9] ];

PROC main()
	!Wait on IRQ for a new trajectory to load
	WaitUntil trajectory_acquireReadLockIfIRQ();
	motion_trajectory := trajectory; !Copy joint trajectory to local var
	trajectory_releaseLock; !Release lock on the joint trajectory
	
	WHILE true DO
		target.robax := motion_trajectory{sequence_ptr+1}.joint_pos;
		IF motion_trajectory{sequence_ptr+1}.stop THEN !Check if stopped
			MOVEABSJ target, v1000, fine, tool0; !Move to next point and stop
		ELSE
			MOVEABSJ target, v1000, z10, tool0; !Move to next point
			sequence_ptr := sequence_ptr + 1; !If not stopped, advance pointer to next in sequence
		ENDIF
		!Check IRQ to see if there's a new trajectory to load
		IF trajectory_acquireReadLockIfIRQ() THEN
			motion_trajectory := trajectory; !Copy joint trajectory to local var
			trajectory_releaseLock; !Release lock on the joint trajectory
			sequence_ptr := 0;
		ENDIF
	ENDWHILE
ENDPROC

ENDMODULE