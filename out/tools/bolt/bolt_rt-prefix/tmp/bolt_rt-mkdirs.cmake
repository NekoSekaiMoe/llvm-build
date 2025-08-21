# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/user/llvm-google/bolt/runtime")
  file(MAKE_DIRECTORY "/home/user/llvm-google/bolt/runtime")
endif()
file(MAKE_DIRECTORY
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-bins"
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-prefix"
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-prefix/tmp"
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-stamps"
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-prefix/src"
  "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-stamps"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-stamps/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/user/llvm-google/llvm/out/tools/bolt/bolt_rt-stamps${cfgdir}") # cfgdir has leading slash
endif()
