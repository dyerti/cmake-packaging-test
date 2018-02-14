cmake_minimum_required(VERSION 3.5)
project(ProjA)

find_package(Threads REQUIRED)
find_package(libssh REQUIRED)

add_library(ProjA SHARED a.cpp)
target_link_libraries(ProjA PUBLIC Threads::Threads ${LIBSSH_LIBRARIES})

add_library(AwesomeStatic a.cpp)

include(../cmake/InstallHelper.cmake)
install_target_helper(TARGETS ProjA AwesomeStatic VERSION 1.2 NAMESPACE Coolio::)
