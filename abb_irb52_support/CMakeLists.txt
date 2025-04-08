cmake_minimum_required(VERSION 3.0.2)

project(abb_irb52_support)

find_package(catkin REQUIRED)

catkin_package()

if (CATKIN_ENABLE_TESTING)
  find_package(roslaunch REQUIRED)
  roslaunch_add_file_check(test/roslaunch_test_irb52_7_120.xml)
  roslaunch_add_file_check(test/roslaunch_test_irb52_7_145.xml)
endif()

install(DIRECTORY config launch meshes urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
install(FILES LICENSE
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
