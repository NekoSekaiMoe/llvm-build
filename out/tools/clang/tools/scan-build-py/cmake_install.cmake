# Install script for directory: /home/user/llvm-google/clang/tools/scan-build-py

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/bin/analyze-build")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/bin/intercept-build")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE PROGRAM RENAME "scan-build-py" FILES "/home/user/llvm-google/clang/tools/scan-build-py/bin/scan-build")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/libexec" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/libexec/analyze-c++")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/libexec" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/libexec/analyze-cc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/libexec" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/libexec/intercept-c++")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/libexec" TYPE PROGRAM FILES "/home/user/llvm-google/clang/tools/scan-build-py/libexec/intercept-cc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/__init__.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/analyze.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/arguments.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/clang.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/compilation.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/intercept.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/report.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/shell.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild/resources" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/resources/scanview.css")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild/resources" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/resources/selectable.js")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libscanbuild/resources" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libscanbuild/resources/sorttable.js")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libear" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libear/__init__.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libear" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libear/config.h.in")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "scan-build-py" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/libear" TYPE FILE FILES "/home/user/llvm-google/clang/tools/scan-build-py/lib/libear/ear.c")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/user/llvm-google/llvm/out/tools/clang/tools/scan-build-py/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
