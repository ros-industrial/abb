# ABB

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

[![support level: community](https://img.shields.io/badge/support%20level-community-lightgray.svg)](http://rosindustrial.org/news/2016/10/7/better-supporting-a-growing-ros-industrial-software-platform)

[ROS-Industrial][] ABB meta-package.

The [abb_experimental][] repository may contain additional packages.


## Contents

Branch naming follows the ROS distribution they are compatible with. `-devel`
branches may be unstable. Releases are made from the distribution branches
(`noetic` and `ros2`).

Branching is done ***only*** if and when needed (ie: because of breaking changes between distributions), otherwise the most recent distribution branch is expected to be upwards compatible with newer ROS releases.

Older releases may be found in the old ROS-Industrial [subversion repository][].


## Status

The packages in this repository are *community supported*.
This means they do not get support from the OEM, nor from the ROS-Industrial consortia directly (see also the `support level` badge at the top of this page).

Maintenance and development is on a best-effort basis and depends on volunteers.

If you are looking for official support, we suggest contacting your local ABB branch office and letting them know you are trying to use these community supported packages with their product(s).


## Naming Convention

All robot support packages and MoveIt configurations follow the naming conventions as described in [REP-I0007][].


## Building

### On newer (or older) versions of ROS

Building the packages on newer (or older) versions of ROS is in most cases possible and supported.

Only do this if there is no binary release available for the ROS 2 distribution you want to use the packages with.

Building packages will require creating a Colcon workspace, cloning this repository, installing all required dependencies and finally building the workspace.

### Building the packages

The following instructions assume that a [Colcon workspace][] has been created at `$HOME/colcon_ws` and that the *source space* is at `$HOME/colcon_ws/src`.
Update paths appropriately if they are different on the build machine.

These instructions build the `ros2` branch on a ROS Jazzy system (but should work on all supported ROS 2 versions):

```bash
# change to the root of the Colcon workspace
cd $HOME/colcon_ws

# retrieve the latest development version of the abb repository.
# NOTE: the 'ros2' branch is compatible with all supported ROS 2 LTS releases.
# Use the correct branch for the OS + ROS version you're building these
# packages for.
git clone -b ros2 https://github.com/ros-industrial/abb.git src/abb

# check build dependencies. Note: this may install additional packages,
# depending on the software installed on the machine
rosdep update

# be sure to change 'jazzy' to whichever ROS release you are using
rosdep install --from-paths src/ --ignore-src --rosdistro jazzy

# build the workspace
colcon build
```

### Activating the workspace

Finally, activate the workspace to get access to the packages just built:

```bash
source $HOME/colcon_ws/install/local_setup.bash
```

At this point all packages should be usable (ie: `ros2 launch` should be able to auto-complete package names starting with `abb_..`).
In case the workspace contains additional packages (ie: not from this repository), those should also still be available.


## Installation and usage

Even though it was written for ROS 1, the [Working With ROS-Industrial Robot Support Packages][] tutorial has information on the design of the structure of the support packages in this repository which is also relevant to their use in ROS 2 applications.


## Drivers

This repository does not host any drivers for ABB robots.

The community supported ROS 1 `abb_driver` package was migrated from this repository to [ros-industrial/abb_driver][] as part of [ros-industrial/abb#179][]. See that issue for rationale and a description of the process.

ROS 2 has several community supported drivers for ABB robots, and the support packages in this repository are expected to be compatible with those, as long as those drivers are compatible with basic URDFs and/or XACROs.


[ROS-Industrial]: https://rosindustrial.org
[abb_experimental]: https://github.com/ros-industrial/abb_experimental
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse
[REP-I0007]: https://github.com/ros-industrial/rep/blob/master/rep-I0007.rst
[Colcon workspace]: https://docs.ros.org/en/kilted/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html
[Working With ROS-Industrial Robot Support Packages]: http://wiki.ros.org/Industrial/Tutorials/WorkingWithRosIndustrialRobotSupportPackages
[ros-industrial/abb_driver]: https://github.com/ros-industrial/abb_driver
[ros-industrial/abb#179]: https://github.com/ros-industrial/abb/issues/179
