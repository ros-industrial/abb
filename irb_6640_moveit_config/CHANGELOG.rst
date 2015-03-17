^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package irb_6640_moveit_config
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.1.6 (2015-03-17)
------------------
* Fix typos and links in CHANGELOG.rst
* Contributors: Levi Armstrong

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
* Added new files missed in last commit
* Regenerated moveit package for irb 6640
* moveit_cfgs: add GetPlanningScene capability. Fix `#18 <https://github.com/ros-industrial/abb/issues/18>`_.
* moveit_cfgs: run_depend on industrial_robot_simulator. Fix `#16 <https://github.com/ros-industrial/abb/issues/16>`_.
* moveit_cfgs: add GetPlanningScene capability. Fix `#18 <https://github.com/ros-industrial/abb/issues/18>`_.
* moveit_cfgs: run_depend on industrial_robot_simulator. Fix `#16 <https://github.com/ros-industrial/abb/issues/16>`_.
* changed naming link_base into base_link and corrected collision meshes
* Added files for IRB6640
* Contributors: Berend Kupers, Shaun Edwards, gavanderhoorn
