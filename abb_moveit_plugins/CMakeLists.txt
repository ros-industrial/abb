# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(abb_moveit_plugins)
find_package(catkin REQUIRED COMPONENTS moveit_core roscpp)

#######################################
## Adding directories and definitions #
#######################################
include_directories(include ${Boost_INCLUDE_DIR} ${catkin_INCLUDE_DIRS})

#set the default path for built executables to the "bin" directory of the src package
#set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
#set the default path for built libraries to the "lib" directory of the src package
#set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

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

###################################
## catkin specific configuration ##
###################################
## Declare artifacts to be passed to dependent projects
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
    DEPENDS moveit_core roscpp
    CATKIN_DEPENDS moveit_core roscpp
    INCLUDE_DIRS include
    LIBRARIES 
)

###########
## Build ##
###########

# Library containing IKFast plugin
add_library(irb_2400_moveit_arm_kinematics
  src/irb_2400_manipulator_ikfast_moveit_plugin.cpp src/irb_2400_manipulator_ikfast_solver.cpp)



