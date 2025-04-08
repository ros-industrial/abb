^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_irb5400_support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.5.0 (2025-04-08)
------------------
* Switch to JSP GUI in all support packages (`#221 <https://github.com/ros-industrial/abb/issues/221>`_).
* Add preamble to launch files if missing (`#220 <https://github.com/ros-industrial/abb/issues/220>`_).
* Fix joint names in the ``xacro:macro`` (`#219 <https://github.com/ros-industrial/abb/issues/219>`_).
* Remove ``--inorder`` xacro arg everywhere (`#217 <https://github.com/ros-industrial/abb/issues/217>`_).
* Update all manifests and build scripts (`#216 <https://github.com/ros-industrial/abb/issues/216>`_).
* Update maintainers everywhere.
* Add license files and install them.
* Use SPDX license identifiers everywhere.
* Remove URDF files from packages: only provide XACROs.
* For a complete list of changes see the `commit log for 1.5.0 <https://github.com/ros-industrial/abb/compare/1.3.1...1.5.0>`_.
* Contributors: Aaryan Murgunde, gavanderhoorn

1.3.1 (2019-09-17)
------------------
* Use the 'doc' attribute on 'arg' elements. (`#143 <https://github.com/ros-industrial/abb/issues/143>`_)
* Update maintainers (`#139 <https://github.com/ros-industrial/abb/issues/139>`_)
* Contributors: Harsh Deshpande, gavanderhoorn

1.3.0 (2017-05-27)
------------------
* remove reference to source build and rebase to indigo devel.
* kinetic-devel release of ros-industrial/abb
* Contributors: Austin Deric

1.2.1 (2017-03-27)
------------------
* No changes

1.2.0 (2015-06-06)
------------------
* No changes

1.1.9 (2015-04-07)
------------------
* No changes

1.1.8 (2015-04-06)
------------------
* No changes

1.1.7 (2015-04-01)
------------------
* Merged hydro branch
  - Updated CHANGELOG.rst and package.xml files
* Fix `#48 <https://github.com/Levi-Armstrong/abb/issues/48>`_: added default true for J23_coupled for 5400
* Fix incorrect maintainer email in manifests. Fix `#65 <https://github.com/Levi-Armstrong/abb/issues/65>`_.
* Fix `#32 <https://github.com/Levi-Armstrong/abb/issues/32>`_: corrects tool0 to match robot controller
* Fix for issue `#49 <https://github.com/Levi-Armstrong/abb/issues/49>`_: add 'base' link (transform to World)
  This should not affect existing kinematic plugins or MoveIt configurations:
  - the link is not part of the main kinematic chain
  - the transform is implemented as a fixed joint
* Contributors: Levi Armstrong, Shaun Edwards, dpsolomon, gavanderhoorn

1.1.6 (2015-03-17)
------------------
* No changes

1.1.5 (2015-03-17)
------------------
* No changes

1.1.4 (2014-12-14)
------------------
* Corrected 5400 wrist by adding axis 5 mimic joint
* Contributors: dpsolomon

1.1.3 (2014-09-05)
------------------
* Bump versions.
* support: add roslaunch testing.
* support: add robot interface and visualisation convenience launchfiles.
  Defaults for 'J23_coupled' argument/parameter copied from irb_2400_moveit_config
  and irb_6640_moveit_config packages.
  TODO: provide default for coupling factor of IRB 5400 (no existing value available).
* irb5400: move IRB 5400 support into separate support pkg.
  Meshes and urdfs copied from abb_common package.
* Contributors: gavanderhoorn
