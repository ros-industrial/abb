^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_driver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Forthcoming
-----------
* driver: ROS_motionServer.mod was checking for wrong comm type to send reply
  message, causing dirver to quite working after stop command.
  Fix `#42 <https://github.com/ros-industrial/abb/issues/42>`_.
* Contributors: Levi Armstrong

1.1.4 (2014-12-14)
------------------
* No changes

1.1.3 (2014-09-05)
------------------
* driver: reintroduce coupling factor default.
  Reverts 3765cd6.
* Bump versions.
* driver: remove default for J23 coupling parameter.
  Users should explicitly provide this on the command line, or use one
  of the convenience launchfiles provided with the support packages.
  It is of critical importance that this parameter is set to the
  correct value, and should therefore not be supplied a default in
  a (for end-users) file with low visibility.
* driver: move driver (Rapid and nodes) into separate package.
  Node sources, headers and launch files copied from abb_common.
* Contributors: gavanderhoorn
