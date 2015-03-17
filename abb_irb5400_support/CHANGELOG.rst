^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_irb5400_support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Forthcoming
-----------
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
