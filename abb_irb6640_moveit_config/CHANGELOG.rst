^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package abb_irb6640_moveit_config
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1.3.1 (2019-09-17)
------------------
* Update maintainers (`#139 <https://github.com/ros-industrial/abb/issues/139>`_)
* Contributors: gavanderhoorn

1.3.0 (2017-05-27)
------------------
* kinetic-devel release of ros-industrial/abb
* Contributors: AustinDeric

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
* No changes

1.1.3 (2014-09-05)
------------------
* Bump versions.
* irb6640: (re)add plan execution support to MoveIt package.
* irb6640: add basic (regenerated) MoveIt package.
  Regenerated package, updated version of the irb_6640_moveit_config.
  This uses the files from the abb_irb6600_support package.
* Contributors: gavanderhoorn
