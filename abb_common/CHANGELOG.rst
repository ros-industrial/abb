^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_common
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.1.5 (2015-03-17)
------------------
* driver: ROS_motionServer.mod was checking for wrong comm type to send reply
  message, causing driver to quit working after stop command.
  Fix `#42 <https://github.com/ros-industrial/abb/issues/42>`_.
* Contributors: Levi Armstrong

1.1.4 (2014-12-14)
------------------
* Backported correct 5400 wrist to deprecated abb_common package
* Contributors: Daniel Solomon

1.1.3 (2014-09-05)
------------------
* Merged changes from hydro (release) branch.  Changes include only release artifacts
* Add deprecation notice to old packages.
  And point users to the replacements.
* common: add roslaunch testing.
  In preparation of repository refactoring: roslaunch tests will be
  used to perform regression testing to make sure all changes remain
  backward compatible (wrt executable artefacts, resources and launch
  files).
* Contributors: Shaun Edwards, gavanderhoorn

1.1.2 (2014-06-07)
------------------
* No changes

1.1.1 (2014-05-27)
------------------
* Updated package versions to match abb meta-package version, in prep for release
* Manually merged removal of include install and cleaned up CMakelist
* Cleaned up CMakelist comments and spacing
* Contributors: Berend Kupers, JeremyZoss, Joaquín Ignacio Aramendía, Shaun Edwards, gavanderhoorn, gomezc, jrgnicho, shaun-edwards
