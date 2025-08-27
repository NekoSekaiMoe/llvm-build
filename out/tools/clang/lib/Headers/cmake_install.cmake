# Install script for directory: /home/user/llvm-google/clang/lib/Headers

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/builtins.h"
    "/home/user/llvm-google/clang/lib/Headers/float.h"
    "/home/user/llvm-google/clang/lib/Headers/inttypes.h"
    "/home/user/llvm-google/clang/lib/Headers/iso646.h"
    "/home/user/llvm-google/clang/lib/Headers/limits.h"
    "/home/user/llvm-google/clang/lib/Headers/module.modulemap"
    "/home/user/llvm-google/clang/lib/Headers/stdalign.h"
    "/home/user/llvm-google/clang/lib/Headers/stdarg.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg___gnuc_va_list.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg___va_copy.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_header_macro.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_arg.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_copy.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_list.h"
    "/home/user/llvm-google/clang/lib/Headers/stdatomic.h"
    "/home/user/llvm-google/clang/lib/Headers/stdbool.h"
    "/home/user/llvm-google/clang/lib/Headers/stdckdint.h"
    "/home/user/llvm-google/clang/lib/Headers/stddef.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_header_macro.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_max_align_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_null.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_nullptr_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_offsetof.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_ptrdiff_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_rsize_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_size_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_unreachable.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_wchar_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_wint_t.h"
    "/home/user/llvm-google/clang/lib/Headers/stdint.h"
    "/home/user/llvm-google/clang/lib/Headers/stdnoreturn.h"
    "/home/user/llvm-google/clang/lib/Headers/tgmath.h"
    "/home/user/llvm-google/clang/lib/Headers/unwind.h"
    "/home/user/llvm-google/clang/lib/Headers/varargs.h"
    "/home/user/llvm-google/clang/lib/Headers/arm_acle.h"
    "/home/user/llvm-google/clang/lib/Headers/arm_cmse.h"
    "/home/user/llvm-google/clang/lib/Headers/armintr.h"
    "/home/user/llvm-google/clang/lib/Headers/arm64intr.h"
    "/home/user/llvm-google/clang/lib/Headers/arm_neon_sve_bridge.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_builtin_vars.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_math.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_complex_builtins.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_device_functions.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_texture_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_libdevice_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_math_forward_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_runtime_wrapper.h"
    "/home/user/llvm-google/clang/lib/Headers/hexagon_circ_brev_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/hexagon_protos.h"
    "/home/user/llvm-google/clang/lib/Headers/hexagon_types.h"
    "/home/user/llvm-google/clang/lib/Headers/hvx_hexagon_protos.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_libdevice_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_math.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_stdlib.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_runtime_wrapper.h"
    "/home/user/llvm-google/clang/lib/Headers/larchintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lasxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lsxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/msa.h"
    "/home/user/llvm-google/clang/lib/Headers/opencl-c.h"
    "/home/user/llvm-google/clang/lib/Headers/opencl-c-base.h"
    "/home/user/llvm-google/clang/lib/Headers/altivec.h"
    "/home/user/llvm-google/clang/lib/Headers/htmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/htmxlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/riscv_bitmanip.h"
    "/home/user/llvm-google/clang/lib/Headers/riscv_crypto.h"
    "/home/user/llvm-google/clang/lib/Headers/riscv_ntlh.h"
    "/home/user/llvm-google/clang/lib/Headers/sifive_vector.h"
    "/home/user/llvm-google/clang/lib/Headers/s390intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vecintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/velintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/velintrin_gen.h"
    "/home/user/llvm-google/clang/lib/Headers/velintrin_approx.h"
    "/home/user/llvm-google/clang/lib/Headers/adcintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/adxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ammintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxcomplexintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxfp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512convertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512minmaxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512niintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512satcvtintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2convertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2minmaxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2niintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2satcvtintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bf16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bitalgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512cdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512dqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512fintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512fp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512ifmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512ifmavlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmivlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbf16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbitalgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlcdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vldqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlfp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvbmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvp2intersectintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vp2intersectintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vpopcntdqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vpopcntdqvlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxifmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxneconvertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniint16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniint8intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/bmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/bmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cetintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cldemoteintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clflushoptintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clwbintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clzerointrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cmpccxaddintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/crc32intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/emmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/enqcmdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/f16cintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fma4intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fxsrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/gfniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/hresetintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ia32intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/immintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/invpcidintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/keylockerintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lwpintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lzcntintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/mm3dnow.h"
    "/home/user/llvm-google/clang/lib/Headers/mmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/movdirintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/mwaitxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/nmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pconfigintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pkuintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/popcntintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/prfchiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/prfchwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ptrauth.h"
    "/home/user/llvm-google/clang/lib/Headers/ptwriteintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/raointintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rdpruintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rdseedintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rtmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/serializeintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sgxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sha512intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/shaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sm3intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sm4intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/smmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tbmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tsxldtrkintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/uintrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/usermsrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vaesintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vpclmulqdqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/waitpkgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/wbnoinvdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/__wmmintrin_aes.h"
    "/home/user/llvm-google/clang/lib/Headers/wmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/__wmmintrin_pclmul.h"
    "/home/user/llvm-google/clang/lib/Headers/x86gprintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/x86intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xopintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsavecintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsaveintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsaveoptintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsavesintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xtestintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cet.h"
    "/home/user/llvm-google/clang/lib/Headers/cpuid.h"
    "/home/user/llvm-google/clang/lib/Headers/wasm_simd128.h"
    "/home/user/llvm-google/clang/lib/Headers/intrin0.h"
    "/home/user/llvm-google/clang/lib/Headers/intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vadefs.h"
    "/home/user/llvm-google/clang/lib/Headers/yvals_core.h"
    "/home/user/llvm-google/clang/lib/Headers/mm_malloc.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_neon.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_fp16.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_sve.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_sme.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_bf16.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_mve.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_cde.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_vector_types.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/cuda_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/algorithm"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/cmath"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/complex"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/new"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/cuda_wrappers/bits" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/shared_ptr_base.h"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/basic_string.h"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/basic_string.tcc"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/ppc_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/mmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/xmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/mm_malloc.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/emmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/pmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/tmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/smmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/nmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/bmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/bmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/immintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/x86intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/x86gprintrin.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/llvm_libc_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/assert.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/stdio.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/stdlib.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/string.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/ctype.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/inttypes.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_libc_wrappers/time.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/openmp_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/math.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/cmath"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/__clang_openmp_device_functions.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/new"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/llvm_offload_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload_host.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload_device.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "clang-resource-headers" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/zos_wrappers" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/zos_wrappers/builtins.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "core-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/builtins.h"
    "/home/user/llvm-google/clang/lib/Headers/float.h"
    "/home/user/llvm-google/clang/lib/Headers/inttypes.h"
    "/home/user/llvm-google/clang/lib/Headers/iso646.h"
    "/home/user/llvm-google/clang/lib/Headers/limits.h"
    "/home/user/llvm-google/clang/lib/Headers/module.modulemap"
    "/home/user/llvm-google/clang/lib/Headers/stdalign.h"
    "/home/user/llvm-google/clang/lib/Headers/stdarg.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg___gnuc_va_list.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg___va_copy.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_header_macro.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_arg.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_copy.h"
    "/home/user/llvm-google/clang/lib/Headers/__stdarg_va_list.h"
    "/home/user/llvm-google/clang/lib/Headers/stdatomic.h"
    "/home/user/llvm-google/clang/lib/Headers/stdbool.h"
    "/home/user/llvm-google/clang/lib/Headers/stdckdint.h"
    "/home/user/llvm-google/clang/lib/Headers/stddef.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_header_macro.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_max_align_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_null.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_nullptr_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_offsetof.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_ptrdiff_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_rsize_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_size_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_unreachable.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_wchar_t.h"
    "/home/user/llvm-google/clang/lib/Headers/__stddef_wint_t.h"
    "/home/user/llvm-google/clang/lib/Headers/stdint.h"
    "/home/user/llvm-google/clang/lib/Headers/stdnoreturn.h"
    "/home/user/llvm-google/clang/lib/Headers/tgmath.h"
    "/home/user/llvm-google/clang/lib/Headers/unwind.h"
    "/home/user/llvm-google/clang/lib/Headers/varargs.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "arm-common-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/arm_acle.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_neon.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_fp16.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "arm-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/arm_cmse.h"
    "/home/user/llvm-google/clang/lib/Headers/armintr.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_mve.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_cde.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "aarch64-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/arm64intr.h"
    "/home/user/llvm-google/clang/lib/Headers/arm_neon_sve_bridge.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_sve.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_sme.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_bf16.h"
    "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/arm_vector_types.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cuda-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/cuda_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/algorithm"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/cmath"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/complex"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/new"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cuda-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/cuda_wrappers/bits" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/shared_ptr_base.h"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/basic_string.h"
    "/home/user/llvm-google/clang/lib/Headers/cuda_wrappers/bits/basic_string.tcc"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cuda-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_builtin_vars.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_math.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_complex_builtins.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_device_functions.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_texture_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_libdevice_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_math_forward_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_cuda_runtime_wrapper.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "hexagon-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/hexagon_circ_brev_intrinsics.h"
    "/home/user/llvm-google/clang/lib/Headers/hexagon_protos.h"
    "/home/user/llvm-google/clang/lib/Headers/hexagon_types.h"
    "/home/user/llvm-google/clang/lib/Headers/hvx_hexagon_protos.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "hip-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_libdevice_declares.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_math.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_stdlib.h"
    "/home/user/llvm-google/clang/lib/Headers/__clang_hip_runtime_wrapper.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "loongarch-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/larchintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lasxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lsxintrin.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "mips-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/msa.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "ppc-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/ppc_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/mmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/xmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/mm_malloc.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/emmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/pmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/tmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/smmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/nmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/bmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/bmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/immintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/x86intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ppc_wrappers/x86gprintrin.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "ppc-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/altivec.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "ppc-htm-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/htmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/htmxlintrin.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "riscv-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/riscv_bitmanip.h"
    "/home/user/llvm-google/clang/lib/Headers/riscv_crypto.h"
    "/home/user/llvm-google/clang/lib/Headers/riscv_ntlh.h"
    "/home/user/llvm-google/clang/lib/Headers/sifive_vector.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "systemz-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/s390intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vecintrin.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "systemz-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/zos_wrappers" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/zos_wrappers/builtins.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "ve-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/velintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/velintrin_gen.h"
    "/home/user/llvm-google/clang/lib/Headers/velintrin_approx.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "webassembly-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/wasm_simd128.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "x86-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/adcintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/adxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ammintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxcomplexintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxfp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/amxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512convertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512minmaxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512niintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2_512satcvtintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2convertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2minmaxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2niintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx10_2satcvtintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bf16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bitalgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512bwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512cdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512dqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512fintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512fp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512ifmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512ifmavlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vbmivlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbf16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbitalgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlbwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlcdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vldqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlfp16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvbmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vlvp2intersectintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vp2intersectintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vpopcntdqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avx512vpopcntdqvlintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxifmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxneconvertintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniint16intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniint8intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/avxvnniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/bmi2intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/bmiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cetintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cldemoteintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clflushoptintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clwbintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/clzerointrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cmpccxaddintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/crc32intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/emmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/enqcmdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/f16cintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fma4intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fmaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/fxsrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/gfniintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/hresetintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ia32intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/immintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/invpcidintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/keylockerintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lwpintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/lzcntintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/mm3dnow.h"
    "/home/user/llvm-google/clang/lib/Headers/mmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/movdirintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/mwaitxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/nmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pconfigintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pkuintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/pmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/popcntintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/prfchiintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/prfchwintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/ptrauth.h"
    "/home/user/llvm-google/clang/lib/Headers/ptwriteintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/raointintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rdpruintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rdseedintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/rtmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/serializeintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sgxintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sha512intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/shaintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sm3intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/sm4intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/smmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tbmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/tsxldtrkintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/uintrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/usermsrintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vaesintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vpclmulqdqintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/waitpkgintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/wbnoinvdintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/__wmmintrin_aes.h"
    "/home/user/llvm-google/clang/lib/Headers/wmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/__wmmintrin_pclmul.h"
    "/home/user/llvm-google/clang/lib/Headers/x86gprintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/x86intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xmmintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xopintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsavecintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsaveintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsaveoptintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xsavesintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/xtestintrin.h"
    "/home/user/llvm-google/clang/lib/Headers/cet.h"
    "/home/user/llvm-google/clang/lib/Headers/cpuid.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "hlsl-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/hlsl.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "hlsl-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/hlsl" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/hlsl/hlsl_basic_types.h"
    "/home/user/llvm-google/clang/lib/Headers/hlsl/hlsl_intrinsics.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "opencl-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/opencl-c.h"
    "/home/user/llvm-google/clang/lib/Headers/opencl-c-base.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "openmp-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/openmp_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/math.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/cmath"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/__clang_openmp_device_functions.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/complex_cmath.h"
    "/home/user/llvm-google/clang/lib/Headers/openmp_wrappers/new"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "openmp-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include/llvm_offload_wrappers" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload_host.h"
    "/home/user/llvm-google/clang/lib/Headers/llvm_offload_wrappers/__llvm_offload_device.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "utility-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES "/home/user/llvm-google/clang/lib/Headers/mm_malloc.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "windows-resource-headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/clang/20/include" TYPE FILE FILES
    "/home/user/llvm-google/clang/lib/Headers/intrin0.h"
    "/home/user/llvm-google/clang/lib/Headers/intrin.h"
    "/home/user/llvm-google/clang/lib/Headers/vadefs.h"
    "/home/user/llvm-google/clang/lib/Headers/yvals_core.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/user/llvm-google/llvm/out/tools/clang/lib/Headers/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
