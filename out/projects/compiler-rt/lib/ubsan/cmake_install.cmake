# Install script for directory: /home/user/llvm-google/compiler-rt/lib/ubsan

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.ubsan_standalone-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.ubsan_standalone_cxx-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE STATIC_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone_cxx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.ubsan_standalone-dynamic-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE SHARED_LIBRARY FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang_rt.ubsan_standalone-dynamic-aarch64" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE FILE FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone.a.syms")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/lib/aarch64-unknown-linux-gnu" TYPE FILE FILES "/home/user/llvm-google/llvm/out/lib/clang/20/lib/aarch64-unknown-linux-gnu/libclang_rt.ubsan_standalone_cxx.a.syms")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/user/llvm-google/llvm/out/projects/compiler-rt/lib/ubsan/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
