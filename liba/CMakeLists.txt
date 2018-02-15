cmake_minimum_required(VERSION 3.5)
project(ProjA)

find_package(Threads REQUIRED)
find_package(libssh REQUIRED)

add_library(ProjA SHARED a.cpp)
target_link_libraries(ProjA PUBLIC Threads::Threads ${LIBSSH_LIBRARIES})
target_include_directories(ProjA PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>  
    $<INSTALL_INTERFACE:include>)

add_library(AwesomeStatic a.cpp)
target_include_directories(AwesomeStatic PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>  
    $<INSTALL_INTERFACE:include>)

include(../cmake/InstallHelper.cmake)
install_target_helper(TARGETS ProjA AwesomeStatic VERSION 1.2 NAMESPACE Coolio::)
install(
  DIRECTORY include/ProjA
  DESTINATION include
  COMPONENT Devel
)
