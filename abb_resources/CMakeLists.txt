cmake_minimum_required(VERSION 3.12)
project(abb_resources NONE)

find_package(ament_cmake REQUIRED)
ament_package()

install(DIRECTORY rviz urdf
  DESTINATION share/${PROJECT_NAME})
install(FILES LICENSE
  DESTINATION share/${PROJECT_NAME})
