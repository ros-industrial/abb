# ABB

[![Build Status: Ubuntu Focal (Actions)](https://github.com/ros-industrial/abb/workflows/CI%20-%20Ubuntu%20Focal/badge.svg?branch=kinetic-devel)](https://github.com/ros-industrial/abb/actions?query=workflow%3A%22CI+-+Ubuntu+Focal%22)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

[![support level: community](https://img.shields.io/badge/support%20level-community-lightgray.svg)](http://rosindustrial.org/news/2016/10/7/better-supporting-a-growing-ros-industrial-software-platform)

[ROS-Industrial][] ABB meta-package.  See the [ROS wiki][] page for more information.

The [abb_experimental][] repository contains additional packages.


## Contents

Branch naming follows the ROS distribution they are compatible with. `-devel`
branches may be unstable. Releases are made from the distribution branches
(`hydro`, `indigo`, `kinetic` and `noetic`).

Branching is done only when needed (ie: because of breaking changes between distributions).

Older releases may be found in the old ROS-Industrial [subversion repository][].


### MoveIt configurations

All provided MoveIt configurations were moved to the [moveit](/moveit) subdirectory in [#214][].
These packages can be used as-if they were still located in the root of the repository.
Catkin will still be able to locate them.


## Status

The packages in this repository are *community supported*.
This means they do not get support from the OEM, nor from the ROS-Industrial consortia directly (see also the `support level` badge at the top of this page).

Maintenance and development is on a best-effort basis and depends on volunteers.

If you are looking for official support, we suggest contacting your local ABB branch office.


## Naming Convention

All robot support packages and MoveIt configurations follow the naming conventions as described in [REP-I0007][].


## Building

### On newer (or older) versions of ROS

Building the packages on newer (or older) versions of ROS is in most cases possible and supported.
For example: building the packages in this repository on Ubuntu Focal/ROS Noetic systems is supported.
This will require creating a Catkin workspace, cloning this repository, installing all required dependencies and finally building the workspace.

### Catkin tools

It is recommended to use [catkin_tools][] instead of the default [catkin][] when building ROS workspaces.
`catkin_tools` provides a number of benefits over regular `catkin_make` and will be used in the instructions below.
All packages can be built using `catkin_make` however: use `catkin_make` in place of `catkin build` where appropriate.

### Building the packages

The following instructions assume that a [Catkin workspace][] has been created at `$HOME/catkin_ws` and that the *source space* is at `$HOME/catkin_ws/src`.
Update paths appropriately if they are different on the build machine.

These instructions build the `noetic-devel` branch on a ROS Noetic system:

```bash
# change to the root of the Catkin workspace
$ cd $HOME/catkin_ws

# retrieve the latest development version of abb. If you'd rather
# use the latest released version, replace 'noetic-devel' with 'noetic'
# NOTE: 'noetic-devel' is compatible with ROS Noetic. Use the correct branch
# for the OS + ROS version you're building these packages for
$ git clone -b noetic-devel https://github.com/ros-industrial/abb.git src/abb

# check build dependencies. Note: this may install additional packages,
# depending on the software installed on the machine
$ rosdep update

# be sure to change 'noetic' to whichever ROS release you are using
$ rosdep install --from-paths src/ --ignore-src --rosdistro noetic

# build the workspace (using catkin_tools)
$ catkin build
```

### Activating the workspace

Finally, activate the workspace to get access to the packages just built:

```bash
$ source $HOME/catkin_ws/devel/setup.bash
```

At this point all packages should be usable (ie: `roslaunch` should be able to auto-complete package names starting with `abb_..`).
In case the workspace contains additional packages (ie: not from this repository), those should also still be available.


## Installation and usage

Refer to [Working With ROS-Industrial Robot Support Packages][] for information on how to use the files provided by the robot support and MoveIt configuration packages.
See also the other pages on the [ROS wiki][].

Refer to the [tutorials][] for information on installation and configuration of the controller-specific software components.


## Migration of abb_driver

The `abb_driver` package was migrated from this repository to [ros-industrial/abb_driver][] as part of [ros-industrial/abb#179][]. See that issue for rationale and a description of the process.

Please file enhancement requests and report issues for `abb_driver` on the issue tracker of `ros-industrial/abb_driver`.


[ROS-Industrial]: http://wiki.ros.org/Industrial
[ROS wiki]: http://wiki.ros.org/abb
[abb_experimental]: https://github.com/ros-industrial/abb_experimental
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse
[#214]: https://github.com/ros-industrial/abb/pull/214
[REP-I0007]: https://github.com/ros-industrial/rep/blob/master/rep-I0007.rst
[Catkin workspace]: http://wiki.ros.org/catkin/Tutorials/create_a_workspace
[catkin]: http://wiki.ros.org/catkin
[catkin_tools]: https://catkin-tools.readthedocs.io/en/latest
[Working With ROS-Industrial Robot Support Packages]: http://wiki.ros.org/Industrial/Tutorials/WorkingWithRosIndustrialRobotSupportPackages
[tutorials]: http://wiki.ros.org/abb/Tutorials
[ros-industrial/abb_driver]: https://github.com/ros-industrial/abb_driver
[ros-industrial/abb#179]: https://github.com/ros-industrial/abb/issues/179
