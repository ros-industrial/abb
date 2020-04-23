# ABB

[![Build Status](http://build.ros.org/job/Kdev__abb__ubuntu_xenial_amd64/badge/icon)](http://build.ros.org/job/Kdev__abb__ubuntu_xenial_amd64)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

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


## Migration of abb_driver

The `abb_driver` package was migrated from this repository to [ros-industrial/abb_driver][] as part of [ros-industrial/abb#179][]. See that issue for rationale and a description of the process.

Please file enhancement requests and report issues for `abb_driver` on the issue tracker of `ros-industrial/abb_driver`.


[ROS-Industrial]: http://wiki.ros.org/Industrial
[ROS wiki]: http://wiki.ros.org/abb
[abb_experimental]: https://github.com/ros-industrial/abb_experimental
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse
[REP-I0007]: https://github.com/ros-industrial/rep/blob/master/rep-I0007.rst
[ros-industrial/abb_driver]: https://github.com/ros-industrial/abb_driver
[ros-industrial/abb#179]: https://github.com/ros-industrial/abb/issues/179
