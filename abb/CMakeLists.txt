cmake_minimum_required(VERSION 3.12)
project(abb NONE)
find_package(ament_cmake REQUIRED)
ament_package()

install(FILES LICENSE.Apache-2.0 LICENSE.BSD-3-Clause
  DESTINATION share/${PROJECT_NAME})
