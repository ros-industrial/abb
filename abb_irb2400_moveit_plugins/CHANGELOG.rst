^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_irb2400_moveit_plugins
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.2.1 (2017-03-27)
------------------
* No changes

1.2.0 (2015-06-06)
------------------
* Regenerated the ikfast moveit plugin for the irb2400 using an 
  older version of moveit-ikfast plugin. Fixes issue where the 
  ik solutions and the URDF were off by 90 degrees.
* Contributors: Jonathan Meyer

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
* Fix incorrect maintainer email in manifests. Fix `#65 <https://github.com/Levi-Armstrong/abb/issues/65>`_.
* Contributors: Levi Armstrong, Martin Günther, Scott K Logan, Shaun Edwards, gavanderhoorn

1.1.6 (2015-03-17)
------------------
* No changes

1.1.5 (2015-03-17)
------------------
* No changes

1.1.4 (2014-12-14)
------------------
* Merged release artifacts from hydro branch
* fix installation destination of plugin description
  The plugin description used to be installed here:
  /opt/ros/hydro/share/abb_irb2400_moveit_plugins/irb6640_kinematics/abb_irb2400_manipulator_moveit_ikfast_plugin_description.xml
  But it's supposed to be here:
  /opt/ros/hydro/share/abb_irb2400_moveit_plugins/irb2400_kinematics/abb_irb2400_manipulator_moveit_ikfast_plugin_description.xml
  Also see: https://groups.google.com/d/msg/moveit-users/LQFJwqd0N5I/eThqWkXXRMgJ
* irb2400: add depend on liblapack-dev to Moveit plugin.
* Contributors: Martin Günther, Scott K Logan, Shaun Edwards

1.1.3 (2014-09-05)
------------------
* Bump versions.
* irb2400: add regenerated IKFast Moveit plugin.
* Contributors: gavanderhoorn
