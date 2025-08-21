# This file allows users to call find_package(LLD) and pick up our targets.



set(LLVM_VERSION 20.0.0)
find_package(LLVM ${LLVM_VERSION} EXACT REQUIRED CONFIG
             HINTS "/home/user/llvm-google/llvm/out/./lib/cmake/llvm")

set(LLD_EXPORTED_TARGETS "lldCommon;lld;lldCOFF;lldELF;lldMachO;lldMinGW;lldWasm")
set(LLD_CMAKE_DIR "/home/user/llvm-google/llvm/out/lib/cmake/lld")
set(LLD_INCLUDE_DIRS "/home/user/llvm-google/lld/include;/home/user/llvm-google/llvm/out/tools/lld/include")

# Provide all our library targets to users.
include("/home/user/llvm-google/llvm/out/lib/cmake/lld/LLDTargets.cmake")
