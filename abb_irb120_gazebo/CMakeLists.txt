cmake_minimum_required(VERSION 3.0.2)
project(abb_irb120_gazebo)

find_package(catkin REQUIRED)

catkin_package()

foreach(dir config launch urdf)
   install(DIRECTORY ${dir}/
      DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach()

install(FILES readme.md DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
