cmake_minimum_required(VERSION 2.8)

# Project name
project(<?!-PROJECT_NAME-!?>)

# Flags
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-std=c++11")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# Sources
set(<?!-PROJECT_NAME-!?>_SOURCES "src/<?!-PROJECT_NAME-!?>.cpp")

# Output
add_executable(<?!-PROJECT_NAME-!?> ${<?!-PROJECT_NAME-!?>_SOURCES})

# Modules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# OpenGL
find_package(OpenGL REQUIRED)
# GLEW
find_package(GLEW REQUIRED)
# GLFW
#find_package(GLFW REQUIRED)
# V8
find_package(V8 REQUIRED)
# SFML
find_package(SFML REQUIRED COMPONENTS graphics window system)
# Boost
set(Boost_USE_STATIC_LIBS        ON)
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost 1.50.0 COMPONENTS system REQUIRED)
# Threads
find_package(Threads)

include_directories(${V8_INCLUDE_DIR} ${OPENGL_INCLUDE_DIR} ${GLEW_INCLUDE_PATH} ${SFML_INCLUDE_DIR} ${Boost_INCLUDE_DIRS})
target_link_libraries(<?!-PROJECT_NAME-!?> ${V8_LIBRARY} ${OPENGL_LIBRARIES} ${GLEW_LIBRARY} ${SFML_LIBRARIES} ${Boost_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})

#add_definitions(-DSFH_dev_mode)


################################################################################
# Toggle verbosity (comment to re-enable "nice" output)
set( CMAKE_VERBOSE_MAKEFILE off )
