MODULE ROS_motion

! Software License Agreement (BSD License)
!
! Copyright (c) 2012, Edward Venator, Case Western Reserve University
! Copyright (c) 2012, Jeremy Zoss, Southwest Research Institute
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

LOCAL CONST zonedata DEFAULT_CORNER_DIST := z10;
LOCAL VAR ROS_joint_trajectory_pt trajectory{MAX_TRAJ_LENGTH};
LOCAL VAR num trajectory_size := 0;
LOCAL VAR intnum intr_new_trajectory;

PROC main()
    VAR num current_index;
    VAR jointtarget target;
    VAR speeddata move_speed := v10;  ! default speed
    VAR zonedata stop_mode;
    VAR bool skip_move;
    
    ! Set up interrupt to watch for new trajectory
    IDelete intr_new_trajectory;    ! clear interrupt handler, in case restarted with ExitCycle
    CONNECT intr_new_trajectory WITH new_trajectory_handler;
    IPers ROS_new_trajectory, intr_new_trajectory;

    WHILE true DO
        ! Check for new Trajectory
        IF (ROS_new_trajectory)
            init_trajectory;

        ! execute all points in this trajectory
        IF (trajectory_size > 0) THEN
            FOR current_index FROM 1 TO trajectory_size DO
                target.robax := trajectory{current_index}.joint_pos;
                target.extax := trajectory{current_index}.extax_pos;

                skip_move := (current_index = 1) AND is_near(target, 0.1, 0.1);

                stop_mode := DEFAULT_CORNER_DIST;  ! assume we're smoothing between points
                IF (current_index = trajectory_size) stop_mode := fine;  ! stop at path end

                ! Execute move command
                IF (NOT skip_move)
                    MoveAbsJ target, move_speed, \T:=trajectory{current_index}.duration, stop_mode, tool0;
            ENDFOR

            trajectory_size := 0;  ! trajectory done
        ENDIF
        
        WaitTime 0.05;  ! Throttle loop while waiting for new command
    ENDWHILE
ERROR
    ErrWrite \W, "Motion Error", "Error executing motion.  Aborting trajectory.";
    abort_trajectory;
ENDPROC

LOCAL PROC init_trajectory()
    clear_path;                    ! cancel any active motions

    WaitTestAndSet ROS_trajectory_lock;  ! acquire data-lock
      trajectory := ROS_trajectory;            ! copy to local var
      trajectory_size := ROS_trajectory_size;  ! copy to local var
      ROS_new_trajectory := FALSE;
    ROS_trajectory_lock := FALSE;         ! release data-lock
ENDPROC

LOCAL FUNC bool is_near(jointtarget target, num deg_tol, num mm_tol)
    VAR jointtarget curr_jnt;
    
    curr_jnt := CJointT();
    
    ! either an external axis is unconfigured/not present OR if it is, then it must be close enough
    RETURN ( ABS(curr_jnt.robax.rax_1 - target.robax.rax_1) < deg_tol )
       AND ( ABS(curr_jnt.robax.rax_2 - target.robax.rax_2) < deg_tol )
       AND ( ABS(curr_jnt.robax.rax_3 - target.robax.rax_3) < deg_tol )
       AND ( ABS(curr_jnt.robax.rax_4 - target.robax.rax_4) < deg_tol )
       AND ( ABS(curr_jnt.robax.rax_5 - target.robax.rax_5) < deg_tol )
       AND ( ABS(curr_jnt.robax.rax_6 - target.robax.rax_6) < deg_tol )
       AND ( (curr_jnt.extax.eax_a = 9E9) OR (ABS(curr_jnt.extax.eax_a - target.extax.eax_a) < mm_tol) )
       AND ( (curr_jnt.extax.eax_b = 9E9) OR (ABS(curr_jnt.extax.eax_b - target.extax.eax_b) < mm_tol) )
       AND ( (curr_jnt.extax.eax_c = 9E9) OR (ABS(curr_jnt.extax.eax_c - target.extax.eax_c) < mm_tol) )
       AND ( (curr_jnt.extax.eax_d = 9E9) OR (ABS(curr_jnt.extax.eax_d - target.extax.eax_d) < mm_tol) );
ENDFUNC

LOCAL PROC abort_trajectory()
    trajectory_size := 0;  ! "clear" local trajectory
    clear_path;
    ExitCycle;  ! restart program
ENDPROC

LOCAL PROC clear_path()
    IF ( NOT (IsStopMoveAct(\FromMoveTask) OR IsStopMoveAct(\FromNonMoveTask)) )
        StopMove;          ! stop any active motions
    ClearPath;             ! clear queued motion commands
    StartMove;             ! re-enable motions
ENDPROC

LOCAL TRAP new_trajectory_handler
    IF (NOT ROS_new_trajectory) RETURN;
    
    abort_trajectory;
ENDTRAP

ENDMODULE