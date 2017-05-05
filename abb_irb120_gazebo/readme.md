# ABB IRB 120 Gazebo

##Overview

This package contains the files required to simulate the ABB IRB 120  manipulator (and variants) in Gazebo. 

Current version supports ROS Indigo, but can be modified for ROS Hydro as noted below.


## Using Moveit! with Gazebo Simulator

1. Bring the robot model into gazebo and load the ros_control controllers:
   ```roslaunch abb_irb120_gazebo irb120_3_58_gazebo.launch``` 

2. Launch moveit! and ensure that it is configured to run alongside Gazebo:
```roslaunch abb_irb120_moveit_config moveit_planning_execution_gazebo.launch``` 
