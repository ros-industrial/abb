# ABB

[![Build Status](http://build.ros.org/job/Idev__abb__ubuntu_trusty_amd64/badge/icon)](http://build.ros.org/job/Idev__abb__ubuntu_trusty_amd64)

[![support level: community](https://img.shields.io/badge/support%20level-community-lightgray.png)](http://rosindustrial.org/news/2016/10/7/better-supporting-a-growing-ros-industrial-software-platform)

[ROS-Industrial][] ABB meta-package.  See the [ROS wiki][] page for more information.

The [abb_experimental][] repository contains additional packages.


## Contents

Branch naming follows the ROS distribution they are compatible with. `-devel`
branches may be unstable. Releases are made from the distribution branches
(`hydro`, `indigo`).

Older releases may be found in the old ROS-Industrial [subversion repository][].

## Naming Convention

All robot support packages and MoveIt configurations follow the naming conventions as described in [REP-I0007][].

## Features

This package currently supports the following:

* IRC5 controllers with RobotWare 5.13 and up
 * Single mechanical units (ie: a basic 6 axis robot)
 * Up to 4 integrated external linear axes (in a single mechanical unit)
 * Joint state reporting for all axes (in a single mechanical unit)
 * Trajectory downloading for all axes (in a single mechanical unit)

The driver is largely manipulator agnostic, meaning that it will work with just about any ABB robot an IRC5 controller is compatible with.

## Installation

There are two components that need to be installed in order to use this package: 1) the RAPID Server inside the ABB controller, 2) the ROS package exposing to the ROS environment.

### RAPID Server installation

#### Prerequisites

The ABB ROS Server code is written in RAPID, using a socket interface and multiple parallel tasks. The code was originally tested on an IRC5 controller, with an IRB-2400 robot, but other combinations should also work. The following controller options are required:

 * _623-1: Multitasking_
 * _672-1: Socket Messaging_ (in recent RobotWare versions, this option is included with _616-1: PC Interface_)

RobotWare OS version 5.13 or later is required due to the use of certain socket options. Earlier versions may work, but will require modifications to the RAPID code.

#### Installing Server Code

All files in the `abb_driver/rapid` directory of this repository should be copied to the robot controller. This tutorial assumes the files are copied to a `ROS` subdirectory under the system's `HOME` directory (e.g. `/<system>/HOME/ROS/*`).

See the manufacturer's documentation for file-transfer methods. RobotStudio Online and USB drives are often convenient methods to transfer files to the controller.

#### Configuring Controller Settings

The ROS Server code requires 3 tasks. Some modules are loaded to specific tasks, and others are shared between tasks, as described below:

**File Overview**

* Shared by all tasks
  * `ROS_common.sys`: Global variables and data types shared by all files
  * `ROS_socket.sys`: Socket handling and simple_message implementation
  * `ROS_messages.sys`: Implementation of specific message types
* Specific task modules
  * `ROS_stateServer.mod`: Broadcast joint position and state data
  * `ROS_motionServer.mod`: Receive robot motion commands
  * `ROS_motion.mod`: Issues motion commands to the robot

#### Create Tasks

Browse to `ABB -> Control Panel -> Configuration -> Topics -> Controller -> Task` (in RobotStudio 6, this is found under the `Controller tab -> Configuration Editor -> Controller -> Task`, then right-click `New Task`).

Create 3 tasks as follows:

| Name               | Type          | Trust Level | Entry  | Motion Task |
| ------------------ | ------------- | ----------- | ------ | ----------- | 
| `ROS_StateServer`  | `SEMISTATIC`  | `NoSafety`  | `main` | NO          |
| `ROS_MotionServer` | `SEMISTATIC`  | `SysStop`   | `main` | NO          |
| `T_ROB1`           | `NORMAL`      |             | `main` | YES         |

> It is easiest to wait until all configuration tasks are completed before rebooting the controller.

**NOTES:**

* The `T_ROB1` motion task probably already exists on your controller.
* If `T_ROB1` has existing motion-control modules, you may need to rename the `main()` routine in `ROS_Motion.mod` to `ROS_main()`. In this case, set the `Entry` point for `T_ROB1` task to` ROS_main()`.
* For multi-robot controllers, specify the desired robot (e.g. `rob1`) for each task
* `SEMISTATIC` tasks will auto-start when controller is booted. They are visible, but cannot be easily seen for troubleshooting. For debug or development purposes, it may be desired to set both `ROS_*Server` tasks to `Type=NORMAL`.

#### Load Modules to Tasks

Browse to `ABB -> Control Panel -> Configuration -> Topics -> Controller -> Automatic Loading of Modules` (in RobotStudio 6, this is found under the `Controller tab -> Configuration Editor -> Controller -> Automatic Loading of Modules`, then right-click `New Automatic Loading of Modules`).

Add one entry for each server file as follows:

| File                             | Task               | Installed | All Tasks | Hidden |
| -------------------------------- | ------------------ | --------- | --------- | ------ | 
| `HOME:/ROS/ROS_common.sys`       |                    | NO        | YES       | NO     |
| `HOME:/ROS/ROS_socket.sys`       |                    | NO        | YES       | NO     |
| `HOME:/ROS/ROS_messages.sys`     |                    | NO        | YES       | NO     |
| `HOME:/ROS/ROS_stateServer.mod`  | `ROS_StateServer`  | NO        | NO        | NO     |
| `HOME:/ROS/ROS_motionServer.mod` | `ROS_MotionServer` | NO        | NO        | NO     |
| `HOME:/ROS/ROS_motion.mod`       | `T_ROB1`           | NO        | NO        | NO     |

After the last change, select `YES` to restart the controller and apply the changes.

#### Updating Software

To update robot server files with new versions, use the following procedure to ensure that the changes are actually applied:

* Copy the new/updated files onto the robot controller, as before.
* Restart the controller using a P-Start (`ABB -> Restart -> Advanced -> P-Start -> OK`)

> **NOTE:** This will erase any existing modules that have been loaded to memory. This may cause compilation issues on restart. If this is a concern, try another method: Warm Start, manually reloading modules (may require setting `SEMISTATIC` tasks to `NORMAL` tasks), etc.

* After the controller reboots, the new changes should be active.

### ROS Package installation 

First make sure you have installed the following packages:

```
  sudo apt install ros-kinetic-industrial-core ros-kinetic-moveit
```

Clone this repository into your catkin working directory:

```
  cd ~/catkin_ws/src
  git clone https://github.com/ros-industrial/abb.git
```

And build with catkin build:

```
  cd ~/catkin_ws
  catkin build
```

Or `catkin_make` if that's your build tool of choice:

```
  cd ~/catkin_ws
  catkin_make
```

Finally, source your catkin workspace:

```
  source ~/catkin_ws/devel/setup.bash
```

## Usage

In order to connect the driver to your hardware, you can use one of the various launch files provided, e.g.:

```
  roslaunch abb_irbXXXX_support robot_interface_download_irbXXXXyyyy.launch robot_ip:=ROBOT_IP_ADDRESS
```

where `ROBOT_IP_ADDRESS` is your robot's IP, `XXXX` is the robot model (e.g. `irb4400`), and `XXXXyyyy` is the specific variant of the robot (e.g. `irb4400l_30_243`). Check the support package of your robot for the details about model and variant supported.


[ROS-Industrial]: http://wiki.ros.org/Industrial
[ROS wiki]: http://wiki.ros.org/abb
[abb_experimental]: https://github.com/ros-industrial/abb_experimental
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse
[REP-I0007]: https://github.com/ros-industrial/rep/blob/master/rep-I0007.rst
