cmake_minimum_required(VERSION 3.12)
project(abb_irb2600_support NONE)

find_package(ament_cmake REQUIRED)
ament_package()

install(DIRECTORY launch meshes urdf
  DESTINATION share/${PROJECT_NAME})
install(FILES LICENSE
  DESTINATION share/${PROJECT_NAME})
