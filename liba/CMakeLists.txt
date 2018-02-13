cmake_minimum_required(VERSION 3.5)
project(ProjA)

find_package(Threads REQUIRED)
find_package(libssh REQUIRED)

add_library(ProjA SHARED a.cpp)
target_link_libraries(ProjA PUBLIC Threads::Threads ${LIBSSH_LIBRARIES})

install(TARGETS ProjA EXPORT ProjATargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

export(EXPORT ProjATargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/ProjA/ProjATargets.cmake"
  NAMESPACE Coolio::
)

configure_file(cmake/ProjAConfig.cmake
  "${CMAKE_CURRENT_BINARY_DIR}/ProjA/ProjAConfig.cmake"
  COPYONLY
)

set(ConfigPackageLocation lib/cmake/ProjA)
install(EXPORT ProjATargets
  FILE
    ProjATargets.cmake
  NAMESPACE
    Coolio::
  DESTINATION
    ${ConfigPackageLocation}
)
install(
  FILES
    cmake/ProjAConfig.cmake
  DESTINATION
    ${ConfigPackageLocation}
  COMPONENT
    Devel
)
