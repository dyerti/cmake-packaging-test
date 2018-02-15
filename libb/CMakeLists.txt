cmake_minimum_required(VERSION 3.5)
project(ProjB)

find_package(ProjA)

add_library(ProjB SHARED b.cpp)
target_link_libraries(ProjB PUBLIC Coolio::ProjA)
target_include_directories(ProjB PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>  
    $<INSTALL_INTERFACE:include>)

include(../cmake/InstallHelper.cmake)
install_target_helper(TARGETS ProjB VERSION 3.5.1 NAMESPACE Coolio::)
install(
  DIRECTORY include/ProjB
  DESTINATION include
  COMPONENT Devel
)
