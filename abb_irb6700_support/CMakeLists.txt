cmake_minimum_required(VERSION 2.8.3)

project(abb_irb6700_support)

find_package(catkin REQUIRED)

catkin_package()

if (CATKIN_ENABLE_TESTING)
  find_package(roslaunch REQUIRED)
  roslaunch_add_file_check(test/roslaunch_test_irb6700_200_260.xml)
  roslaunch_add_file_check(test/roslaunch_test_irb6700_235_265.xml)
endif()

install(DIRECTORY config launch meshes urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
