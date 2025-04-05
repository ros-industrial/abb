^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_irb2400_moveit_config
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.3.1 (2019-09-17)
------------------
* Update maintainers (`#139 <https://github.com/ros-industrial/abb/issues/139>`_)
* Contributors: gavanderhoorn

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
* Fix incorrect maintainer email in manifests. Fix `#65 <https://github.com/Levi-Armstrong/abb/issues/65>`_.
* Contributors: Levi Armstrong, Shaun Edwards, gavanderhoorn

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
* Merged release artifacts from hydro branch
* irb2400_moveit_cfg: add missing run_depend on ikfast plugin. Fix `#53 <https://github.com/ros-industrial/abb/issues/53>`_.
* Contributors: Shaun Edwards, gavanderhoorn

1.1.3 (2014-09-05)
------------------
* Bump versions.
* irb2400: update MoveIt config to use IKFast plugin.
* irb2400: (re)add plan execution support to MoveIt package.
* irb2400: add basic (regenerated) MoveIt package.
  Regenerated package, updated version of the irb_2400_moveit_config.
  This uses the files from the abb_irb2400_support package.
  Note: acceleration limits are identical to those specified in the
  old irb_2400_moveit_config package (ie: 1.0 m/s^2), which should
  be updated to more realistic values.
* Contributors: gavanderhoorn
