cmake_minimum_required(VERSION 3.5)
project(ProjB)

find_package(ProjA)

add_library(ProjB SHARED b.cpp)
target_link_libraries(ProjB PUBLIC Coolio::ProjA)

install(TARGETS ProjB EXPORT ProjBTargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

export(EXPORT ProjBTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/ProjB/ProjBTargets.cmake"
  NAMESPACE Coolio::
)

configure_file(cmake/ProjBConfig.cmake
  "${CMAKE_CURRENT_BINARY_DIR}/ProjB/ProjBConfig.cmake"
  COPYONLY
)

set(ConfigPackageLocation lib/cmake/ProjB)
install(EXPORT ProjBTargets
  FILE
    ProjBTargets.cmake
  NAMESPACE
    Coolio::
  DESTINATION
    ${ConfigPackageLocation}
)
install(
  FILES
    cmake/ProjBConfig.cmake
  DESTINATION
    ${ConfigPackageLocation}
  COMPONENT
    Devel
)
