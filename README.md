# ABB

[![Build Status](http://build.ros.org/job/Idev__abb__ubuntu_trusty_amd64/badge/icon)](http://build.ros.org/job/Idev__abb__ubuntu_trusty_amd64)

[ROS-Industrial][] ABB meta-package.  See the [ROS wiki][] page for more information.

The [abb_experimental][] repository contains additional packages.


## Contents

Branch naming follows the ROS distribution they are compatible with. `-devel`
branches may be unstable. Releases are made from the distribution branches
(`hydro`, `indigo`).

Older releases may be found in the old ROS-Industrial [subversion repository][].

[ROS-Industrial]: http://www.ros.org/wiki/Industrial
[ROS wiki]: http://ros.org/wiki/abb
[abb_experimental]: https://github.com/ros-industrial/abb_experimental
[subversion repository]: https://code.google.com/p/swri-ros-pkg/source/browse

## Naming Convention

Variant names for ABB manipulators may include a _modifier_ (indicating support for a particular feature, or a physical characteristic of the variant), a _payload specification_ (one or more digits, indicating maximum supported payload in kg) and finally a specification of the _reach_ of the arm (in meters). Examples: _IRB 1600 - 10 / 1.2_ and _IRB 4400L - 10_.

All ABB support packages shall be named using the following template:

```
  abb_irbMODEL_support
```

Note that this template omits the modifier, payload and reach components included in the actual product name.

Where appropriate, artefacts within ABB support, MoveIt configuration and plugin packages shall be named using the following template:

```
  irbMODEL[MODIFIER]_PAYLOAD_REACH_[VARIANT]
```

Where `MODEL` is a numeric string, `MODIFIER` is a string (optional), `PAYLOAD` is a numeric string (max payload in kg), `REACH` is a numeric string (reach converted to centimetres, avoiding fractional numbers) and `VARIANT` may be an alphanumeric string (optional).

If a particular model does not have variants based on reach, the REACH component should be omitted from the ROS-Industrial name as well.

Examples: `irb1600_10_120` and `irb4400l_10_255`.
