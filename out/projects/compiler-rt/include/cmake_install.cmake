# Install script for directory: /home/user/llvm-google/compiler-rt/include

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/sanitizer" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES
    "/home/user/llvm-google/compiler-rt/include/sanitizer/allocator_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/asan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/common_interface_defs.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/coverage_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/dfsan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/hwasan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/linux_syscall_hooks.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/lsan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/msan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/netbsd_syscall_hooks.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/scudo_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/tsan_interface.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/tsan_interface_atomic.h"
    "/home/user/llvm-google/compiler-rt/include/sanitizer/ubsan_interface.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/fuzzer" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES "/home/user/llvm-google/compiler-rt/include/fuzzer/FuzzedDataProvider.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/sanitizer" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES "/home/user/llvm-google/compiler-rt/include/sanitizer/memprof_interface.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/xray" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES
    "/home/user/llvm-google/compiler-rt/include/xray/xray_interface.h"
    "/home/user/llvm-google/compiler-rt/include/xray/xray_log_interface.h"
    "/home/user/llvm-google/compiler-rt/include/xray/xray_records.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/orc" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES "/home/user/llvm-google/compiler-rt/include/orc_rt/c_api.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "compiler-rt-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/profile" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES
    "/home/user/llvm-google/compiler-rt/include/profile/InstrProfData.inc"
    "/home/user/llvm-google/compiler-rt/include/profile/instr_prof_interface.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/user/llvm-google/llvm/out/projects/compiler-rt/include/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
