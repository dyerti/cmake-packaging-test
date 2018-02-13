include(CMakeFindDependencyMacro)
find_dependency(ProjA)

include("${CMAKE_CURRENT_LIST_DIR}/ProjBTargets.cmake")
