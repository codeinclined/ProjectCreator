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

# Boost
set(Boost_USE_STATIC_LIBS        ON)
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost 1.50.0 COMPONENTS system REQUIRED)
# Threads
find_package(Threads)

include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(<?!-PROJECT_NAME-!?> ${Boost_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})

################################################################################
# Toggle verbosity (comment to re-enable "nice" output)
set( CMAKE_VERBOSE_MAKEFILE off )
