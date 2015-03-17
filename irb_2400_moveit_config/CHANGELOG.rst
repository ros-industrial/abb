^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package irb_2400_moveit_config
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Forthcoming
-----------
* No changes

1.1.5 (2015-03-17)
------------------
* moveit_cfg: make warehouse db location user configurable.
  Fix `#58 <https://github.com/ros-industrial/abb/issues/58>`_.
  Released MoveIt configuration packages are installed in non-writable
  locations most of the time. Starting `demo.launch` or any other launch
  file that starts the mongodb wrapper script results in a 'Permission
  denied' error, as it cannot create the database in those directories.
  These changes allow the user to configure an alternative location
  for the mongodb database by using the `db_path` argument.
  Essentially a backport of the fix in `ros-planning/moveit_setup_assistant
  #103 <https://github.com/ros-planning/moveit_setup_assistant/issues/103>`_.
  These fixes have been applied to both the new and the deprecated MoveIt
  configuration packages.
* Contributors: gavanderhoorn

1.1.4 (2014-12-14)
------------------
* No changes

1.1.3 (2014-09-05)
------------------
* Merged changes from hydro (release) branch.  Changes include only release artifacts
* Add deprecation notice to old packages.
  And point users to the replacements.
* Contributors: Shaun Edwards, gavanderhoorn

1.1.2 (2014-06-07)
------------------
* No changes

1.1.1 (2014-05-27)
------------------
* Updated package versions to match abb meta-package version, in prep for release
* 2400_moveit_cfg: match velocity limits with urdf. Fix `#19 <https://github.com/ros-industrial/abb/issues/19>`_.
* moveit_cfgs: add GetPlanningScene capability. Fix `#18 <https://github.com/ros-industrial/abb/issues/18>`_.
* moveit_cfgs: run_depend on industrial_robot_simulator. Fix `#16 <https://github.com/ros-industrial/abb/issues/16>`_.
* 2400_moveit_cfg: match velocity limits with urdf. Fix `#19 <https://github.com/ros-industrial/abb/issues/19>`_.
* moveit_cfgs: add GetPlanningScene capability. Fix `#18 <https://github.com/ros-industrial/abb/issues/18>`_.
* moveit_cfgs: run_depend on industrial_robot_simulator. Fix `#16 <https://github.com/ros-industrial/abb/issues/16>`_.
* add run_depend on moveit_simple_controller_manager
* update moveit_configs to use moveit_simple_controller_manager
* configured moveit package to use IKFast solver
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/branches/catkin_migration@1408 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* added rosbuild abb stack
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/branches/catkin_migration@1308 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* updates by latest MoveIt Setup Assistant: no dummy EEF, demo.launch auto-generated
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/trunk@1240 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* update IRB_2400 URDF to correct invalid tool0 offset.  Update ikfast plugins and SRDF to match.
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/trunk@1225 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* fix irb_2400_moveit_config URDF paths
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/trunk@1128 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* Merged moveit_dev branch (required semi-manual merge).  All changes were in the abb stack.  Merge untested.
  git-svn-id: https://swri-ros-pkg.googlecode.com/svn/trunk@1086 076cdf4d-ed99-c8c1-5d01-9bc0d27e81bd
* Contributors: Jeremy Zoss, JeremyZoss, Shaun Edwards, gavanderhoorn, jrgnicho, shaun-edwards
