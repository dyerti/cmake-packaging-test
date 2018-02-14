cmake_minimum_required(VERSION 3.5)
project(ProjB)

find_package(ProjA)

add_library(ProjB SHARED b.cpp)
target_link_libraries(ProjB PUBLIC Coolio::ProjA)

include(../cmake/InstallHelper.cmake)
install_target_helper(TARGETS ProjB VERSION 3.5.1 NAMESPACE Coolio::)
