# Install script for directory: /home/user/llvm-google/compiler-rt/lib/xray

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.xray-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.xray.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.xray-fdr-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.xray-fdr.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.xray-basic-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.xray-basic.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.xray-profiling-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.xray-profiling.a")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/user/llvm-google/llvm/out/projects/compiler-rt/lib/xray/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
