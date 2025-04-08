cmake_minimum_required(VERSION 3.0.2)

project(abb_irb120_support)

find_package(catkin REQUIRED)

catkin_package()

if (CATKIN_ENABLE_TESTING)
  find_package(roslaunch REQUIRED)
  roslaunch_add_file_check(tests/roslaunch_test_irb120_3_58.xml)
  roslaunch_add_file_check(tests/roslaunch_test_irb120t_3_58.xml)
endif()

install(DIRECTORY config launch meshes urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
install(FILES LICENSE
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
