cmake_minimum_required(VERSION 3.0.2)
project(abb_irb120_gazebo)

find_package(catkin REQUIRED)

catkin_package()

install(DIRECTORY config launch urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
install(FILES readme.md DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
install(FILES LICENSE DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
