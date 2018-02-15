macro(install_target_helper)
  set(options "")
  set(oneValueArgs VERSION NAMESPACE)
  set(multiValueArgs TARGETS)
  cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT ARGS_VERSION)
    message(FATAL_ERROR "install_target_helper: VERSION not defined")
  endif()

  if(NOT ARGS_NAMESPACE)
    message(FATAL_ERROR "install_target_helper: NAMESPACE not defined")
  endif()

  if(NOT ARGS_TARGETS)
    message(FATAL_ERROR "install_target_helper: TARGETS not defined")
  endif()

  if(NOT PROJECT_NAME)
    message(FATAL_ERROR "install_target_helper: PROJECT_NAME not defined")
  endif()

  # Parse major version
  string(REPLACE "." ";" VERSION_LIST ${ARGS_VERSION})
  list(GET VERSION_LIST 0 ARGS_VERSION_MAJOR)

  foreach(ARGS_TARGET IN LISTS ARGS_TARGETS)
    set_property(TARGET ${ARGS_TARGET} PROPERTY VERSION ${ARGS_VERSION})
    set_property(TARGET ${ARGS_TARGET} PROPERTY SOVERSION ${ARGS_VERSION_MAJOR})
    set_property(TARGET ${ARGS_TARGET} PROPERTY
      INTERFACE_${ARGS_TARGET}_MAJOR_VERSION ${ARGS_VERSION_MAJOR})
    set_property(TARGET ${ARGS_TARGET} APPEND PROPERTY
      COMPATIBLE_INTERFACE_STRING ${ARGS_TARGET}_MAJOR_VERSION
    )
  endforeach()

  install(TARGETS ${ARGS_TARGETS} EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
  )

  include(CMakePackageConfigHelpers)
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${ARGS_VERSION}
    COMPATIBILITY AnyNewerVersion
  )

  export(EXPORT ${PROJECT_NAME}Targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}Targets.cmake"
    NAMESPACE ${ARGS_NAMESPACE}
  )

  set(ConfigPackageLocation lib/cmake/${PROJECT_NAME})
  install(EXPORT ${PROJECT_NAME}Targets
    FILE "${PROJECT_NAME}Targets.cmake"
    NAMESPACE ${ARGS_NAMESPACE}
    DESTINATION ${ConfigPackageLocation}
  )

  install(
    FILES
      "cmake/${PROJECT_NAME}Config.cmake"
      "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${ConfigPackageLocation}
    COMPONENT Devel
  )
endmacro()
