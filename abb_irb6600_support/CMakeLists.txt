cmake_minimum_required(VERSION 2.8.3)
project(abb_irb6600_support)

find_package(catkin REQUIRED)

catkin_package()

if (CATKIN_ENABLE_TESTING)
  find_package(roslaunch REQUIRED)
  roslaunch_add_file_check(tests/roslaunch_test_irb6640.xml)
  roslaunch_add_file_check(tests/roslaunch_test_irb6600_225_255.xml)
endif()

install(DIRECTORY config launch meshes urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
