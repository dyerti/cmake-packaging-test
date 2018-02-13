cmake_minimum_required(VERSION 3.5)
project(ExecA)

find_package(ProjB REQUIRED)

add_executable(ExecA exe.cpp)
target_link_libraries(ExecA PUBLIC Coolio::ProjB)
