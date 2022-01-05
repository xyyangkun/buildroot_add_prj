cmake_minimum_required(VERSION 3.1.0)
set(CMAKE_CXX_STANDARD 11)

project(cmake_demo)

set(SOURCES main.cpp)

add_executable(${PROJECT_NAME} ${SOURCES})

install(TARGETS cmake_demo DESTINATION bin)
