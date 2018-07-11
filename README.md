# ABB


## ROS Distro Support

|         | Indigo | Jade | Kinetic |
|:-------:|:------:|:----:|:-------:|
| Branch  | [`indigo-devel`](https://github.com/ros-industrial/abb/tree/indigo-devel) | [`indigo-devel`](https://github.com/ros-industrial/abb/tree/indigo-devel) | [`kinetic-devel`](https://github.com/ros-industrial/abb/tree/kinetic-devel) |
| Status  |  supported | supported |  supported |
| Version | [version](http://repositories.ros.org/status_page/ros_indigo_default.html?q=abb) | [version](http://repositories.ros.org/status_page/ros_jade_default.html?q=abb) | [version](http://repositories.ros.org/status_page/ros_kinetic_default.html?q=abb) |

## Travis - Continuous Integration

Status: [![Build Status](https://travis-ci.org/ros-industrial/abb.svg?branch=kinetic-devel)](https://travis-ci.org/ros-industrial/abb)

## ROS Buildfarm

|         | Indigo Source | Indigo Debian | Jade Source | Jade Debian |  Kinetic Source  |  Kinetic Debian |
|:-------:|:-------------------:|:-------------------:|:-------------------:|:-------------------:|:-------------------:|:-------------------:|
| abb | [![not released](http://build.ros.org/buildStatus/icon?job=Isrc_uT__abb__ubuntu_trusty__source)](http://build.ros.org/view/Isrc_uT/job/Isrc_uT__abb__ubuntu_trusty__source/) | [![not released](http://build.ros.org/buildStatus/icon?job=Ibin_uT64__abb__ubuntu_trusty_amd64__binary)](http://build.ros.org/view/Ibin_uT64/job/Ibin_uT64__abb__ubuntu_trusty_amd64__binary/) | [![not released](http://build.ros.org/buildStatus/icon?job=Jsrc_uT__abb__ubuntu_trusty__source)](http://build.ros.org/view/Jsrc_uT/job/Jsrc_uT__abb__ubuntu_trusty__source/) | [![not released](http://build.ros.org/buildStatus/icon?job=Jbin_uT64__abb__ubuntu_trusty_amd64__binary)](http://build.ros.org/view/Jbin_uT64/job/Jbin_uT64__abb__ubuntu_trusty_amd64__binary/) | [![not released](http://build.ros.org/buildStatus/icon?job=Ksrc_uX__abb__ubuntu_xenial__source)](http://build.ros.org/view/Ksrc_uX/job/Ksrc_uX__abb__ubuntu_xenial__source/) | [![not released](http://build.ros.org/buildStatus/icon?job=Kbin_uX64__abb__ubuntu_xenial_amd64__binary)](http://build.ros.org/view/Kbin_uX64/job/Kbin_uX64__abb__ubuntu_xenial_amd64__binary/) |

[![support level: community](https://img.shields.io/badge/support%20level-community-lightgray.png)](http://rosindustrial.org/news/2016/10/7/better-supporting-a-growing-ros-industrial-software-platform)

[ROS-Industrial][] ABB meta-package.  See the [ROS wiki][] page for more information.

The [abb][] repository contains additional packages.


## Contents

Branch naming follows the ROS distribution they are compatible with. `-devel`
branches may be unstable. Releases are made from the distribution branches
(`hydro`, `indigo`).

Older releases may be found in the old ROS-Industrial [subversion repository][].


## Naming Convention

All robot support packages and MoveIt configurations follow the naming conventions as described in [REP-I0007][].




[ROS-Industrial]: http://wiki.ros.org/Industrial
[ROS wiki]: http://wiki.ros.org/abb
[abb]: https://github.com/ros-industrial/abb
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse
[REP-I0007]: https://github.com/ros-industrial/rep/blob/master/rep-I0007.rst
