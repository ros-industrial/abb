# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(abb_common)
# Load catkin and all dependencies required for this package
# TODO: remove all from COMPONENTS that are not catkin packages.
find_package(catkin REQUIRED COMPONENTS industrial_robot_client roscpp industrial_utils)


#######################################
## Adding directories and definitions #
#######################################
include_directories(include ${Boost_INCLUDE_DIR} ${catkin_INCLUDE_DIRS})
add_definitions(-DLINUXSOCKETS=1)  #build using LINUX SOCKETS libraries

#set the default path for built executables to the "bin" directory
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

#set the default path for built libraries to the "lib" directory
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

#set the default path for urdf's to the "urdf" directory
set(URDF_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/urdf)

#######################################
## Declare ROS messages and services ##
#######################################

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the 'srv' folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   std_msgs
# )

###########
## Build ##
###########
add_executable(abb_robot_state #MD: old name "robot_state" conflicted with that from industrial_robot_client
  src/abb_robot_state_node.cpp
  src/abb_utils.cpp)
target_link_libraries(abb_robot_state ${catkin_LIBRARIES})

add_executable(abb_motion_download_interface
  src/abb_joint_downloader_node.cpp
  src/abb_utils.cpp)
target_link_libraries(abb_motion_download_interface ${catkin_LIBRARIES})


