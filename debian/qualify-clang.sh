#!/usr/bin/env bats

setup() {

    load '/usr/lib/bats/bats-support/load' # this is required by bats-assert!
    load '/usr/lib/bats/bats-assert/load'

    # Common setup
    VERSION=$(dpkg-parsechangelog | sed -rne "s,^Version: 1:([0-9]+).*,\1,p")
    DETAILED_VERSION=$(dpkg-parsechangelog | sed -rne "s,^Version: 1:([0-9.]+)(~|-)(.*),\1\2\3,p")
    DEB_HOST_ARCH=$(dpkg-architecture -qDEB_HOST_ARCH)

    # Define the package list
    LIST="libomp5-${VERSION}_${DETAILED_VERSION}_amd64.deb libomp-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb lldb-${VERSION}_${DETAILED_VERSION}_amd64.deb python3-lldb-${VERSION}_${DETAILED_VERSION}_amd64.deb python3-clang-${VERSION}_${DETAILED_VERSION}_amd64.deb libllvm${VERSION}_${DETAILED_VERSION}_amd64.deb llvm-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb liblldb-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb  libclang1-${VERSION}_${DETAILED_VERSION}_amd64.deb  libclang-common-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb  llvm-${VERSION}_${DETAILED_VERSION}_amd64.deb  liblldb-${VERSION}_${DETAILED_VERSION}_amd64.deb  llvm-${VERSION}-runtime_${DETAILED_VERSION}_amd64.deb lld-${VERSION}_${DETAILED_VERSION}_amd64.deb libfuzzer-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libclang-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++abi-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libc++1-${VERSION}_${DETAILED_VERSION}_amd64.deb libc++abi1-${VERSION}_${DETAILED_VERSION}_amd64.deb clang-${VERSION}_${DETAILED_VERSION}_amd64.deb llvm-${VERSION}-tools_${DETAILED_VERSION}_amd64.deb clang-tools-${VERSION}_${DETAILED_VERSION}_amd64.deb clangd-${VERSION}_${DETAILED_VERSION}_amd64.deb libclang-cpp${VERSION}_${DETAILED_VERSION}_amd64.deb clang-tidy-${VERSION}_${DETAILED_VERSION}_amd64.deb libclang-cpp${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libclc-${VERSION}_${DETAILED_VERSION}_all.deb libclc-${VERSION}-dev_${DETAILED_VERSION}_all.deb llvm-${VERSION}-linker-tools_${DETAILED_VERSION}_amd64.deb libunwind-${VERSION}_${DETAILED_VERSION}_amd64.deb libunwind-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libmlir-${VERSION}_${DETAILED_VERSION}_amd64.deb libmlir-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libclang-rt-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libclang-rt-${VERSION}-dev-wasm32_${DETAILED_VERSION}_all.deb libclang-rt-${VERSION}-dev-wasm64_${DETAILED_VERSION}_all.deb libc++abi-${VERSION}-dev-wasm32_${DETAILED_VERSION}_all.deb libc++-${VERSION}-dev-wasm32_${DETAILED_VERSION}_all.deb libpolly-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb  bolt-${VERSION}_${DETAILED_VERSION}_amd64.deb libbolt-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb flang-${VERSION}_${DETAILED_VERSION}_amd64.deb libflang-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb libllvmlibc-${VERSION}-dev_${DETAILED_VERSION}_amd64.deb"
}

@test "Print LLVM installation information" {
    echo
    echo "==============================================="
    echo "LLVM Version ${VERSION} Installation Instructions"
    echo "==============================================="
    echo
    echo "Detailed version: ${DETAILED_VERSION}"
    echo

    echo "Step 1: Remove potentially conflicting packages"
    echo "---------------------------------------------"
    echo "Run the following command to remove existing packages:"
    echo "sudo apt --purge remove 'libomp5-*' 'libc++*dev' 'libc++*' 'python3-lldb-*' 'libunwind-*' 'libclc-*' 'libclc-*dev' 'libmlir-*'"
    echo

    echo "Step 2: Install new packages"
    echo "-------------------------"
    echo "You have two options for installation:"
    echo

    echo "Option 1: Using dpkg (if you have the .deb files)"
    echo "----------------------------------------"
    echo "sudo dpkg -i $LIST"
    echo

    echo "Option 2: Using apt (recommended)"
    echo "----------------------------"
    L=""
    for f in $LIST; do
        L="$L $(echo $f|cut -d_ -f1)"
    done
    echo "sudo apt-get install $L"
    echo
    run clang-$VERSION --version
    assert_output -p 'clang version'
}

@test "Check debian/ directory existence" {
    [ -d "debian/" ]
}

@test "Check for llvm-config binary" {
    [ -f "/usr/bin/llvm-config-$VERSION" ]
}

@test "Ensure libLLVM.so.VERSION.1 exists in libllvm$VERSION" {
    NBLINES=$(dpkg -L libllvm$VERSION | grep -c "libLLVM.so.$VERSION.1")
    [ "$NBLINES" -gt 0 ]
}

@test "llvm-config does not export -W warnings" {
    run llvm-config-$VERSION --cxxflags
    refute_output -p " -W"
}

@test "nm recognizes libLLVMBitWriter.a format" {
    # Test https://bugs.llvm.org/show_bug.cgi?id=40059
    run nm /usr/lib/llvm-$VERSION/lib/libLLVMBitWriter.a
    refute_output -p 'File format not recognized'
}

@test "Verify llvm manpages" {
    [ -f "/usr/share/man/man1/llc-$VERSION.1.gz" ]
}


# ===================== clang

@test "Test clang dumpversion" {
    run clang-$VERSION -dumpversion
    assert_success
    refute_output "4.2.1"
}

@test "Test compilation of standard library headers with Clang" {
    # Test 1: Compile with <string.h>
    cat > "${BATS_TMPDIR}/string_test.c" <<EOF
#include <string.h>
int main() {
    (void) strcat;
    return 0;
}
EOF
    run clang-$VERSION -c "${BATS_TMPDIR}/string_test.c"
    assert_success "Compilation with <string.h> failed"

    # Test 2: Compile with <errno.h>
    cat > "${BATS_TMPDIR}/errno_test.c" <<EOF
#include <errno.h>
int main() {}
EOF
    run clang-$VERSION "${BATS_TMPDIR}/errno_test.c"
    assert_success "Compilation with <errno.h> failed"

    # Test 3: Compile with <chrono>
    cat > "${BATS_TMPDIR}/chrono_test.cpp" <<EOF
#include <chrono>
int main() {}
EOF
    run clang++-$VERSION -std=c++11 "${BATS_TMPDIR}/chrono_test.cpp"
    assert_success "Compilation with <chrono> and C++11 standard failed"
}


# ===================== scan-build

@test "Check scan-build functionality with GCC" {

    echo '
         void test() {
         int x;
         x = 1; // warn
         }
    '> ${BATS_TMPDIR}/scan_build_test.c

    # Run scan-build with GCC
    run scan-build-$VERSION -o "${BATS_TMPDIR}/scan_build_output" gcc -c "${BATS_TMPDIR}/scan_build_test.c"
    assert_success
    assert_output -p "1 bug found"

    # Clean up
    rm -rf "${BATS_TMPDIR}/scan_build_output"
}

@test "Check scan-build functionality with Clang" {

    echo '
         void test() {
         int x;
         x = 1; // warn
         }
    '> ${BATS_TMPDIR}/scan_build_test.c

    run scan-build-$VERSION -o scan-build clang-$VERSION -c ${BATS_TMPDIR}/scan_build_test.c
    assert_output -p "1 bug found"
}

@test "scan-build --exclude functionality" {

    echo '
         void test() {
         int x;
         x = 1; // warn
         }
    '> ${BATS_TMPDIR}/scan_build_test.c

    run scan-build-$VERSION --exclude ${BATS_TMPDIR} -v clang-$VERSION -c ${BATS_TMPDIR}/scan_build_test.c
    assert_success
	assert_output -p 'scan-build: 0 bugs found.'
}

@test "Check clang-tidy detection" {
    echo 'namespace mozilla { namespace dom { void foo(); }}' > foo.cpp
    run clang-tidy-$VERSION -checks='modernize-concat-nested-namespaces' foo.cpp -extra-arg=-std=c++17
    assert_output -p "nested namespaces can"
}

@test "Check clang-tidy autofix" {
    echo 'namespace mozilla { namespace dom { void foo(); } }' > foo.cpp
    clang-tidy-$VERSION -checks='modernize-concat-nested-namespaces' foo.cpp -extra-arg=-std=c++17 -fix
    run grep -q "namespace mozilla::dom" foo.cpp
    assert_success
}

@test "Check clangd output" {
    echo '{
  "jsonrpc": "2.0",
  "id": 0,
  "method": "initialize",
  "params": {
    "capabilities": {
      "textDocument": {
        "completion": {
          "completionItem": {
            "snippetSupport": true
          }
        }
      }
    },
    "trace": "off"
  }
}
---
{
    "jsonrpc": "2.0",
    "method": "textDocument/didOpen",
    "params": {
        "textDocument": {
            "uri": "test:///main.cpp",
            "languageId": "cpp",
            "version": 1,
            "text": "int func_with_args(int a, int b);\nint main() {\nfunc_with\n}"
        }
    }
}
---
{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "textDocument/completion",
    "params": {
        "textDocument": {
            "uri": "test:///main.cpp"
        },
        "position": {
            "line": 2,
            "character": 7
         }
     }
}
---
{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "shutdown"
}
---
{
    "jsonrpc": "2.0",
    "method": "exit"
}
    ' > clangd.json

    run clangd-$VERSION -lit-test -pch-storage=memory < clangd.json
    assert_success
    assert_output -p 'func_with_args(${1:int a}, ${2:int b})'
}

@test "Test LLI and LLVM runtime functionality" {
    local temp_dir="${BATS_TMPDIR}/lli_test"
    mkdir -p "${temp_dir}"

    cat > "${temp_dir}/foo.c" <<EOF
#include <stdio.h>
int main() {
    printf("lli foo");
    return 0;
}
EOF

    # Generate LLVM IR
    run clang-$VERSION -S -emit-llvm "${temp_dir}/foo.c" -o "${temp_dir}/foo.ll"
    assert_success "Failed to generate LLVM IR"

    # Compile LLVM IR to assembly
    run llc-$VERSION "${temp_dir}/foo.ll" -o "${temp_dir}/foo.s"
    assert_success "Failed to compile LLVM IR to assembly"

    # Execute the LLVM IR using lli
    run lli-$VERSION "${temp_dir}/foo.ll"
    assert_output -p "lli foo" "LLI did not produce the expected output"

    # Optimize the LLVM IR
    run opt-$VERSION -S -O3 "${temp_dir}/foo.ll" -o "${temp_dir}/opt.ll"
    assert_success "Failed to optimize LLVM IR"

    # Execute the optimized LLVM IR
    run lli-$VERSION "${temp_dir}/opt.ll"
    assert_output -p "lli foo" "LLI did not produce the expected output after optimization"

    # Generate LLVM bitcode
    run clang-$VERSION -O3 -emit-llvm "${temp_dir}/foo.c" -c -o "${temp_dir}/foo.bc"
    assert_success "Failed to generate LLVM bitcode"

    # Make the bitcode executable
    chmod +x "${temp_dir}/foo.bc"

    # Check if binfmt is enabled for LLVM bitcode
    if grep -q "enabled" /proc/sys/fs/binfmt_misc/llvm-${VERSION}-runtime.binfmt; then
        # Execute the bitcode
        run "${temp_dir}/foo.bc"
        assert_output -p "lli foo" "Execution of LLVM bitcode failed"
    else
        skip "binfmt_misc for LLVM bitcode is not enabled"
    fi

    rm -rf "${temp_dir}"
}

@test "Verify lld linker output (Bug 40659)" {
    echo "int foo(void) {	return 0; }"> "${BATS_TMPDIR}/foo.c"
    echo "int foo(void); int main() {foo();	return 0;}"> "${BATS_TMPDIR}/main.c"

    run clang-$VERSION -fuse-ld=lld -O2  "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" -o foo
    run ./foo
    assert_success

    run clang-$VERSION -fuse-ld=lld-$VERSION -O2 "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" -o foo
    assert_success
    run ./foo
    assert_success
}



@test "Test LLVM coverage tools" {
    echo '#include <stdio.h>
		int main() { printf("Coverage test"); return 0; }' > foo.c
    run clang-$VERSION --coverage foo.c -o foo
    assert_success
    run ./foo
	assert_success
    run test -f foo-foo.gcno
	assert_success
}


@test "Test clang c++ standard library functionality" {
    echo '#include <vector>
    #include <string>
    #include <iostream>
    using namespace std;
    int main() {
        vector<string> tab;
        tab.push_back("Hello");
        return 0;
    }' > "${BATS_TMPDIR}/test.cpp"

    run clang++-$VERSION "${BATS_TMPDIR}/test.cpp" -o "${BATS_TMPDIR}/test"
    assert_success

    run "${BATS_TMPDIR}/test"
    assert_success
}

@test "Test OpenMP support" {
    echo '#include "omp.h"
    #include <stdio.h>
    int main(void) {
        #pragma omp parallel
        printf("thread %d\n", omp_get_thread_num());
        return 0;
    }' > "${BATS_TMPDIR}/omp_test.c"

    run clang-$VERSION "${BATS_TMPDIR}/omp_test.c" -fopenmp -o "${BATS_TMPDIR}/omp_test"
    assert_success

    run "${BATS_TMPDIR}/omp_test"
    assert_success
}

@test "Test address sanitizer" {
    echo '#include <stdlib.h>
    int main() {
        char *x = (char*)malloc(10 * sizeof(char*));
        free(x);
        return x[5];
    }' > "${BATS_TMPDIR}/asan_test.c"

    run clang-$VERSION -o "${BATS_TMPDIR}/asan_test" -fsanitize=address -O1 -fno-omit-frame-pointer -g "${BATS_TMPDIR}/asan_test.c"
    assert_success

    run "${BATS_TMPDIR}/asan_test"
    assert_failure
    assert_output -p "heap-use-after-free"
}

@test "Test Address Sanitizer verbose mode" {
    echo 'int main(int argc, char **argv) {
        int *array = new int[100];
        delete [] array;
        return array[argc];  // BOOM
    }' > "${BATS_TMPDIR}/asan_test.cpp"

    # Compile the program with AddressSanitizer enabled
    run clang++-$VERSION -O1 -g -fsanitize=address -fno-omit-frame-pointer "${BATS_TMPDIR}/asan_test.cpp" -o "${BATS_TMPDIR}/asan_test"
    assert_success "ASan compilation failed"

    # Run the program with ASan verbose mode enabled
    ASAN_OPTIONS=verbosity=1 ${BATS_TMPDIR}/asan_test &> foo.log || true
    run cat foo.log
    assert_output -p "Init done"

}
@test "Test all sanitizers and multiarch compatibility" {
    local temp_dir="${BATS_TMPDIR}/sanitizer_multi"
    mkdir -p "${temp_dir}"

    # Generate the C test file
    cat > "${temp_dir}/test.c" <<EOF
#include <stdlib.h>
#include <stdio.h>
int main ()
{
#if __has_feature(address_sanitizer)
  puts("address_sanitizer");
#endif
#if __has_feature(thread_sanitizer)
  puts("thread_sanitizer");
#endif
#if __has_feature(memory_sanitizer)
  puts("memory_sanitizer");
#endif
#if __has_feature(undefined_sanitizer)
  puts("undefined_sanitizer");
#endif
#if __has_feature(dataflow_sanitizer)
  puts("dataflow_sanitizer");
#endif
#if __has_feature(efficiency_sanitizer)
  puts("efficiency_sanitizer");
#endif
  printf("Ok\n");
  return EXIT_SUCCESS;
}
EOF

    # Check for compiler-rt library
    run clang-$VERSION --target=x86_64-unknown-linux-gnu --rtlib=compiler-rt --print-libgcc-file-name
    assert_success "Failed to locate compiler-rt runtime library"

    # Multiarch compatibility testing
    # only for AMD64 for now
    # many sanitizers only work on AMD64
    # x32 programs need to be enabled in the kernel bootparams for debian
    # (https://wiki.debian.org/X32Port)
    #
    # SYSTEM should iterate multiple targets (eg. x86_64-unknown-none-gnu for embedded)
    # MARCH should iterate the library architectures via flags
    # LIB should iterate the different libraries
    echo "if it fails, please run"
    echo "apt-get install libc6-dev:i386 libgcc-5-dev:i386 libc6-dev-x32 libx32gcc-5-dev libx32gcc-9-dev"
    local architectures=("-m64") # "-m32" "-mx32")
    local sanitizers=("--rtlib=compiler-rt" "-fsanitize=address" "-fsanitize=thread" "-fsanitize=memory" "-fsanitize=undefined" "-fsanitize=dataflow")

    for arch in "${architectures[@]}"; do
        for sanitizer in "${sanitizers[@]}"; do
            # Skip unsupported combinations
            if [[ "$arch" == "-m32" || "$arch" == "-mx32" ]]; then
                if [[ "$sanitizer" == "-fsanitize=thread" || "$sanitizer" == "-fsanitize=memory" || "$sanitizer" == "-fsanitize=dataflow" ]]; then
                    continue
                fi
            fi

            echo "Testing sanitizer: $sanitizer with architecture: $arch"
            rm -f "${temp_dir}/test"
            run clang-$VERSION $arch $sanitizer -o "${temp_dir}/test" "${temp_dir}/test.c"
            assert_success "Compilation failed for sanitizer: $sanitizer with architecture: $arch"

            if [ -f "${temp_dir}/test" ]; then
                run "${temp_dir}/test"
                assert_success "Execution failed for sanitizer: $sanitizer with architecture: $arch"
            fi
        done
    done

    rm -rf "${temp_dir}"
}

@test "Test LLVM symbolizer integration with AddressSanitizer" {
    echo 'int main(int argc, char **argv) {
        int *array = new int[100];
        delete [] array;
        return array[argc];  // BOOM
    }' > "${BATS_TMPDIR}/symbolizer_test.cpp"

    # Compile the program with AddressSanitizer enabled
    run clang++-$VERSION -O1 -g -fsanitize=address -fno-omit-frame-pointer "${BATS_TMPDIR}/symbolizer_test.cpp" -o "${BATS_TMPDIR}/symbolizer_test"
    assert_success "ASan compilation failed"

    # Run the program with external symbolizer path and verbose mode enabled
    ASAN_OPTIONS=verbosity=2:external_symbolizer_path=/usr/lib/llvm-$VERSION/bin/llvm-symbolizer \
       run "${BATS_TMPDIR}/symbolizer_test"
    assert_failure

    assert_output -p 'new[](unsigned'

    assert_output -p "symbolizer_test.cpp:4"

    # Run again without verbose mode and check symbolization
    run "${BATS_TMPDIR}/symbolizer_test"
    assert_output -p "new[](unsigned"
    assert_output -p "symbolizer_test.cpp:4"
}


@test "Test libc++ with AddressSanitizer" {
    echo '#include <stdexcept>
    int main() {
        std::logic_error("");
    }' > "${BATS_TMPDIR}/sanitizer_test.cpp"

    # Compile with libc++ and AddressSanitizer
    run clang++-$VERSION -stdlib=libc++ -fsanitize=address "${BATS_TMPDIR}/sanitizer_test.cpp" -o "${BATS_TMPDIR}/sanitizer_test"
    assert_success "Compilation with libc++ and AddressSanitizer failed"

    # Run the compiled binary
    run "${BATS_TMPDIR}/sanitizer_test"
    assert_success "Running the binary failed with AddressSanitizer enabled"
}

@test "Test AddressSanitizer with C standard library (Bug 876973)" {

    cat > "${BATS_TMPDIR}/asan_c_test.c" <<EOF
#include <stdio.h>
int main(int argc, char **argv) {
    printf("Hello world!\\n");
    return 0;
}
EOF

    run clang-$VERSION -fsanitize=address "${BATS_TMPDIR}/asan_c_test.c" -o "${BATS_TMPDIR}/asan_c_test" -lc
    assert_success "ASan compilation with -lc failed"

    run "${BATS_TMPDIR}/asan_c_test" &> /dev/null
    assert_success "Execution failed or AddressSanitizer detected an issue with -lc"
}

@test "Test Thread Sanitizer" {
    skip_if_arch "i386"

    echo '#include <pthread.h>
    int Global;
    void *Thread1(void *x) {
        Global++;
        return NULL;
    }
    void *Thread2(void *x) {
        Global--;
        return NULL;
    }
    int main() {
        pthread_t t[2];
        pthread_create(&t[0], NULL, Thread1, NULL);
        pthread_create(&t[1], NULL, Thread2, NULL);
        pthread_join(t[0], NULL);
        pthread_join(t[1], NULL);
    }' > "${BATS_TMPDIR}/tsan_test.c"

    run clang-$VERSION -o "${BATS_TMPDIR}/tsan_test" -fsanitize=thread -g -O1 "${BATS_TMPDIR}/tsan_test.c"
    assert_success

    run "${BATS_TMPDIR}/tsan_test"
    assert_failure
    assert_output -p "data race"
}

@test "Test AddressSanitizer and Undefined Behavior Sanitizer with complex C++ code" {
    # Create the C++ source file
    cat > "${BATS_TMPDIR}/asan_ubsan_test.cpp" <<EOF
class a {
public:
  ~a();
};
template <typename, typename> using b = a;
struct f {
  template <typename d> using e = b<a, d>;
};
struct g {
  typedef f::e<int> c;
};
class h {
  struct : g::c { int i; };
};
struct m {
  h i;
};
template <typename> void __attribute__((noreturn)) j();
void k() {
  m l;
  j<int>();
}
EOF

    # Compile the C++ code with AddressSanitizer and Undefined Behavior Sanitizer enabled
    run clang++-$VERSION -std=c++14 -O3 -fsanitize=address -fsanitize=undefined -c "${BATS_TMPDIR}/asan_ubsan_test.cpp" -fno-crash-diagnostics
    assert_success "Compilation with AddressSanitizer and Undefined Behavior Sanitizer failed"
}


# ===================== polly

@test "Test Polly optimizations" {
    echo '#define N 512
    float A[N][N], B[N][N], C[N][N];
    void init_arrays() {
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++) {
                A[i][j] = 1.0;
                B[i][j] = 2.0;
            }
    }
    int main() {
        init_arrays();
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                for (int k = 0; k < N; k++)
                    C[i][j] += A[i][k] * B[k][j];
        return 0;
    }' > "${BATS_TMPDIR}/polly_test.c"

    # Compile with Polly optimizations enabled
    run clang-$VERSION -O3 -mllvm -polly -mllvm -polly-vectorizer=stripmine "${BATS_TMPDIR}/polly_test.c" -o "${BATS_TMPDIR}/polly_test"
    assert_success "Polly optimization failed"

    # Verify the optimization record
    run clang-$VERSION -S -fsave-optimization-record -emit-llvm "${BATS_TMPDIR}/polly_test.c" -o "${BATS_TMPDIR}/polly_test.s"
    assert_success "Failed to generate Polly optimization record"

    # broken https://bugs.llvm.org/show_bug.cgi?id=51642
    # run test -s "${BATS_TMPDIR}/polly_test.opt.yaml"

    run clang-$VERSION -S -O2 -fsave-optimization-record -emit-llvm "${BATS_TMPDIR}/polly_test.c" -o "${BATS_TMPDIR}/polly_test.s"
    assert_success
    run test -s "${BATS_TMPDIR}/polly_test.opt.yaml"
    assert_success
    run opt-$VERSION -S -polly-canonicalize  "${BATS_TMPDIR}/polly_test.s" >  "${BATS_TMPDIR}/polly_test.ll"
    assert_success
    run opt-$VERSION -basic-aa -polly-ast "${BATS_TMPDIR}/polly_test.ll" -polly-process-unprofitable
    assert_success
    # help with the path
    cp "${BATS_TMPDIR}/polly_test.c" .
    run /usr/lib/llvm-$VERSION/share/opt-viewer/opt-viewer.py -source-dir ${BATS_TMPDIR}/ ${BATS_TMPDIR}/polly_test.opt.yaml -o ${BATS_TMPDIR}/output > /dev/null
    assert_success

    run grep -q "inlined into" ${BATS_TMPDIR}/output/*polly_test.c.html
    assert_success
}

@test "Test libpolly package presence" {
    run test -f "/usr/lib/llvm-$VERSION/include/polly/LinkAllPasses.h"
    assert_success
}

# ===================== lldb

@test "Test LLDB debugger functionality" {
    echo '#include <stdio.h>
    int main() {
        printf("LLDB test\n");
        return 0;
    }' > "${BATS_TMPDIR}/lldb_test.c"

    run clang-$VERSION -g -o "${BATS_TMPDIR}/lldb_test" "${BATS_TMPDIR}/lldb_test.c"
    assert_success

    echo "b main
    run
    bt
    quit" > "${BATS_TMPDIR}/lldb_commands.txt"

    run lldb-$VERSION -s "${BATS_TMPDIR}/lldb_commands.txt" "${BATS_TMPDIR}/lldb_test"
    assert_success
}


@test "Test LLDB debugging with libc++" {
    # Create the C++ source file
    cat > "${BATS_TMPDIR}/foo.cpp" <<EOF
#include <vector>
int main (void) {
    std::vector<int> a;
    a.push_back(0);
}
EOF

    # Compile the program with debugging symbols
    run clang++-$VERSION -g -o "${BATS_TMPDIR}/foo32" "${BATS_TMPDIR}/foo.cpp"
    assert_success "Compilation with debugging symbols failed"

    # Create the LLDB command script
    echo "b main
r
n
p a
quit
" > "${BATS_TMPDIR}/lldb_commands.txt"

    run lldb-$VERSION -s "${BATS_TMPDIR}/lldb_commands.txt" "${BATS_TMPDIR}/foo32"
    assert_output -p "stop reason = step over"
}

# ===================== cmake

@test "Test CMake integration (Bug 900440)" {
    mkdir -p "${BATS_TMPDIR}/cmake_test"

    cat > "${BATS_TMPDIR}/cmake_test/CMakeLists.txt" <<EOF
		cmake_minimum_required(VERSION 3.7)
		project(testllvm)

		find_package(LLVM CONFIG REQUIRED)
		find_package(Clang CONFIG REQUIRED)

		if(NOT LLVM_VERSION STREQUAL Clang_VERSION)
		    #message(FATAL_ERROR "LLVM ${LLVM_VERSION} not matching to Clang ${Clang_VERSION}")
		endif()
EOF

    cd "${BATS_TMPDIR}/cmake_test"
    run cmake .
    assert_success
}

@test "Test if lit-cpuid in LLVMExports CMake files" {
    # Define the path to LLVMExports CMake files
    local cmake_files="/usr/lib/llvm-${VERSION}/lib/cmake/llvm/LLVMExports*.cmake"

    # Ensure at least one CMake file exists
    run ls ${cmake_files}
    assert_success "No LLVMExports CMake files found"

    # Check for lit-cpuid in the files
    run grep -q "lit-cpuid" ${cmake_files}
    assert_failure "Found 'lit-cpuid' in LLVMExports CMake files. This introduces a dependency between llvm-${VERSION} and lldb."
}

@test "Test CMake integration with LLVM and Clang" {
    local cmake_test_dir="${BATS_TMPDIR}/cmaketest"
    mkdir -p "${cmake_test_dir}"

    cat > "${cmake_test_dir}/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.7)
project(SanityCheck)
find_package(LLVM $VERSION.1 REQUIRED CONFIG)
message(STATUS "LLVM_CMAKE_DIR: \${LLVM_CMAKE_DIR}")
if(NOT EXISTS "\${LLVM_TOOLS_BINARY_DIR}/clang")
message(FATAL_ERROR "Invalid LLVM_TOOLS_BINARY_DIR: \${LLVM_TOOLS_BINARY_DIR}")
endif()
find_package(Clang REQUIRED CONFIG)
find_file(H clang/AST/ASTConsumer.h PATHS \${CLANG_INCLUDE_DIRS} NO_DEFAULT_PATH)
message(STATUS "CLANG_INCLUDE_DIRS: \${CLANG_INCLUDE_DIRS}")
if(NOT H)
message(FATAL_ERROR "Invalid Clang header path: \${CLANG_INCLUDE_DIRS}")
endif()
EOF

    mkdir -p "${cmake_test_dir}/standard"
    mkdir -p "${cmake_test_dir}/explicit"

    # Test: CMake find LLVM and Clang in the default path
    pushd "${cmake_test_dir}/standard" > /dev/null
    run cmake ..
    assert_success "CMake integration test for default path failed"
    popd > /dev/null

    # Test: CMake find LLVM and Clang in the explicit prefix path
    pushd "${cmake_test_dir}/explicit" > /dev/null
    run cmake -DCMAKE_PREFIX_PATH="/usr/lib/llvm-${VERSION}" ..
    assert_success "CMake integration test for explicit path failed"
    popd > /dev/null

    rm -rf "${cmake_test_dir}"
}

@test "Test CMake lib detection with LLVM and Clang" {
    # # https://reviews.llvm.org/D107799#3027607
    if ! dpkg -l | grep -q zlib1g-dev; then
        skip "zlib1g-dev is not installed"
    fi

    local cmake_test_dir="${BATS_TMPDIR}/cmaketest"
    mkdir -p "${cmake_test_dir}"

    cat > "${cmake_test_dir}/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.0)
project(test)
find_package(ZLIB)
EOF

    mkdir -p "${cmake_test_dir}/foo"
    pushd "${cmake_test_dir}/foo" > /dev/null

    # Run CMake and capture the output
    run cmake -DCMAKE_C_COMPILER=clang-$VERSION -DCMAKE_CXX_COMPILER=clang++-$VERSION ..
    assert_success "CMake failed to run with ZLIB detection"

    # Ensure ZLIB is detected successfully
    refute_output -p "Could NOT find ZLIB" "CMake could not find ZLIB even though zlib1g-dev is installed"

    popd > /dev/null
    rm -rf "${cmake_test_dir}"
}
@test "Test CMake Clang detection (Bug 994827)" {
    local cmake_test_dir="${BATS_TMPDIR}/cmaketest"
    mkdir -p "${cmake_test_dir}"

    cat > "${cmake_test_dir}/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.18)
project(testllvm)

find_package(Clang REQUIRED CONFIG HINTS "/usr/lib/llvm-${VERSION}/lib/cmake/clang/")
EOF

    mkdir -p "${cmake_test_dir}/foo"
    pushd "${cmake_test_dir}/foo" > /dev/null

    # Run CMake and check for success
    run cmake ..
    assert_success "CMake failed to detect Clang with the specified HINTS path"

    popd > /dev/null
    rm -rf "${cmake_test_dir}"
}

# ===================== libc++

@test "Test libc++ and libc++abi integration" {
    echo '#include <vector>
    #include <string>
    #include <iostream>
    int main() {
        std::vector<std::string> v;
        v.push_back("test");
        return 0;
    }' > "${BATS_TMPDIR}/libcxx_test.cpp"

    run clang++-$VERSION -stdlib=libc++ -lc++abi "${BATS_TMPDIR}/libcxx_test.cpp" -o "${BATS_TMPDIR}/libcxx_test"
    assert_success

    run "${BATS_TMPDIR}/libcxx_test"
    assert_success
}

skip_if_arch() {
    if [ "$DEB_HOST_ARCH" = "$1" ]; then
        skip "Test not supported on $1 architecture"
    fi
}

# ===================== wasm

@test "Test WASM support for C program with wasi-libc" {
    if ! dpkg -l | grep -q wasi-libc; then
        skip "wasi-libc not installed"
    fi

    # Test C program compilation for WASM
    echo '#include <stdio.h>
    int main(int argc, char *argv[]) {
        printf("%s\n", "Hello World!");
    }' > "${BATS_TMPDIR}/wasm_printf_test.c"

    # Compile with clang targeting wasm32-wasi
    run clang-$VERSION -target wasm32-wasi -o "${BATS_TMPDIR}/wasm_printf" "${BATS_TMPDIR}/wasm_printf_test.c"
    assert_success "Failed to compile printf.c for wasm32-wasi"

    # Check the output binary is a WebAssembly file
    run file "${BATS_TMPDIR}/wasm_printf"
    assert_output -p "WebAssembly"

    # Clean up
    rm -f "${BATS_TMPDIR}/wasm_printf_test.c" "${BATS_TMPDIR}/wasm_printf"
}

@test "Test WASM support for C++ program with wasi-libc" {
    if ! dpkg -l | grep -q wasi-libc; then
        skip "wasi-libc not installed"
    fi

    # Test C++ program compilation for WASM
    echo '#include <iostream>
    int main() {
        std::cout << "Hello World!" << std::endl;
    }' > "${BATS_TMPDIR}/wasm_cout_test.cpp"

    # Compile with clang++ targeting wasm32-wasi
    run clang++-$VERSION --target=wasm32-wasi -o "${BATS_TMPDIR}/wasm_cout" "${BATS_TMPDIR}/wasm_cout_test.cpp"
    assert_success "Failed to compile cout.cpp for wasm32-wasi"

    # Check the output binary is a WebAssembly file
    run file "${BATS_TMPDIR}/wasm_cout"
    assert_output -p "WebAssembly"

    # Clean up
    rm -f "${BATS_TMPDIR}/wasm_cout_test.cpp" "${BATS_TMPDIR}/wasm_cout"
}

# ===================== sanitizers

@test "Test Memory sanitizer" {
    skip_if_arch "i386"

    echo '#include <stdlib.h>
    int main() {
        int *a = (int*)malloc(sizeof(int));
        int b = *a;  // Use uninitialized value
        free(a);
        return b;
    }' > "${BATS_TMPDIR}/msan_test.c"

    run clang-$VERSION -fsanitize=memory -o "${BATS_TMPDIR}/msan_test" "${BATS_TMPDIR}/msan_test.c"
    assert_success
}

@test "Test undefined behavior sanitizer" {
    echo '#include <stdio.h>
    int main(int argc, char **argv) {
        int k = 0x7fffffff;
        k += argc;  // potential overflow
        return 0;
    }' > "${BATS_TMPDIR}/ubsan_test.c"

    run clang-$VERSION -fsanitize=undefined -o "${BATS_TMPDIR}/ubsan_test" "${BATS_TMPDIR}/ubsan_test.c"
    assert_success
}

@test "Test compiler-rt library presence" {
    run clang-$VERSION --target=x86_64-unknown-linux-gnu --rtlib=compiler-rt --print-libgcc-file-name
    assert_success
    assert_output -p 'libclang_rt'
}

# ===================== libfuzzer

@test "Test libFuzzer presence" {
    run test -f "/usr/lib/llvm-$VERSION/lib/libFuzzer.a"
    assert_success
}
@test "Test libFuzzer compilation and execution across architectures" {
    if [[ "$DEB_HOST_ARCH" != "amd64" && "$DEB_HOST_ARCH" != "i386" ]]; then
        skip "Test not applicable on architectures other than amd64 or i386"
    fi

    # Create a fuzzer test source file
    cat > "${BATS_TMPDIR}/test_fuzzer.cc" <<EOF
#include <stdint.h>
#include <stddef.h>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size > 0 && data[0] == 'H') {
        if (size > 1 && data[1] == 'I') {
            if (size > 2 && data[2] == '!') {
                __builtin_trap();
            }
        }
    }
    return 0;
}
EOF

    # Compile the test with libFuzzer
    run clang-$VERSION -fsanitize=fuzzer "${BATS_TMPDIR}/test_fuzzer.cc" -o "${BATS_TMPDIR}/a.out" &> "${BATS_TMPDIR}/foo.log"

    # Check for missing file errors in the log
    if grep -q "No such file or directory" "${BATS_TMPDIR}/foo.log"; then
        skip "Fuzzer compilation failed due to missing files or incorrect libraries"
    fi

    run "${BATS_TMPDIR}/a.out"
    assert_output -e "(Test unit written|PreferSmall)"
}

@test "Test libFuzzer functionality" {
    if [[ "$DEB_HOST_ARCH" != "amd64" && "$DEB_HOST_ARCH" != "i386" ]]; then
        skip "Test not applicable on architectures other than amd64 or i386"
    fi
    echo '#include <stdint.h>
    #include <stddef.h>
    extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
        if (size > 0 && data[0] == '\''H'\'')
            if (size > 1 && data[1] == '\''I'\'')
                if (size > 2 && data[2] == '\''!'\'')
                    __builtin_trap();
        return 0;
    }' > "${BATS_TMPDIR}/fuzzer_test.cc"

    # Compile with libFuzzer explicitly linked
    run clang++-$VERSION -fsanitize=address,fuzzer "${BATS_TMPDIR}/fuzzer_test.cc" -o "${BATS_TMPDIR}/fuzzer_test"
    assert_success "Fuzzer compilation failed"

    run "${BATS_TMPDIR}/fuzzer_test"
    assert_failure
    assert_output -p "libFuzzer: deadly signal"

    run clang++-$VERSION -fsanitize=address -fsanitize-coverage=edge,trace-pc "${BATS_TMPDIR}/fuzzer_test.cc" /usr/lib/llvm-$VERSION/lib/libFuzzer.a -o "${BATS_TMPDIR}/fuzzer_test_explicit"
    assert_success "Fuzzer compilation with explicit linking failed"
    run "${BATS_TMPDIR}/fuzzer_test_explicit"
    assert_output -e "(Test unit written|PreferSmall)"
}

@test "Test coverage Fuzzing with llvm-profdata and llvm-cov" {
    # Create the main fuzzing driver
    cat > "${BATS_TMPDIR}/StandaloneFuzzTargetMain.c" <<EOF
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

extern int LLVMFuzzerTestOneInput(const unsigned char *data, size_t size);
__attribute__((weak)) extern int LLVMFuzzerInitialize(int *argc, char ***argv);
int main(int argc, char **argv) {
  fprintf(stderr, "StandaloneFuzzTargetMain: running %d inputs\n", argc - 1);
  if (LLVMFuzzerInitialize)
    LLVMFuzzerInitialize(&argc, &argv);
  for (int i = 1; i < argc; i++) {
    fprintf(stderr, "Running: %s\n", argv[i]);
    FILE *f = fopen(argv[i], "r");
    assert(f);
    fseek(f, 0, SEEK_END);
    size_t len = ftell(f);
    fseek(f, 0, SEEK_SET);
    unsigned char *buf = (unsigned char*)malloc(len);
    size_t n_read = fread(buf, 1, len, f);
    fclose(f);
    assert(n_read == len);
    LLVMFuzzerTestOneInput(buf, len);
    free(buf);
    fprintf(stderr, "Done:    %s: (%zd bytes)\n", argv[i], n_read);
  }
}
EOF

    # Create the fuzzing target
    cat > "${BATS_TMPDIR}/fuzz_me.cc" <<EOF
#include <stdint.h>
#include <stddef.h>

bool FuzzMe(const uint8_t *Data, size_t DataSize) {
  return DataSize >= 3 &&
      Data[0] == 'F' &&
      Data[1] == 'U' &&
      Data[2] == 'Z' &&
      Data[3] == 'Z';
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  FuzzMe(Data, Size);
  return 0;
}
EOF

    # Compile the fuzzing target and driver with profiling and coverage mapping
    run clang-$VERSION -fprofile-instr-generate -fcoverage-mapping \
        "${BATS_TMPDIR}/fuzz_me.cc" "${BATS_TMPDIR}/StandaloneFuzzTargetMain.c" \
        -o "${BATS_TMPDIR}/a.out"
    assert_success "Fuzzer compilation failed"

    # Set up the corpus directory and create initial inputs
    mkdir -p "${BATS_TMPDIR}/CORPUS"
    echo -n A > "${BATS_TMPDIR}/CORPUS/A"

    # Run the fuzzer binary with initial inputs
    run "${BATS_TMPDIR}/a.out" "${BATS_TMPDIR}/CORPUS/*"
    # fails on purpose
    assert_failure
    assert_output -p "running 1 inputs"

    # Merge profiling data
    run llvm-profdata-$VERSION merge -sparse *.profraw -o "${BATS_TMPDIR}/default.profdata"
    assert_success "Failed to merge profiling data"

    # Generate coverage report for the function `FuzzMe`
    run llvm-cov-$VERSION show "${BATS_TMPDIR}/a.out" \
        -instr-profile="${BATS_TMPDIR}/default.profdata" \
        -name=FuzzMe
    assert_success "llvm-cov failed to generate a coverage report"
    assert_output -p 'DataSize >= 3'

    # Add another input to the corpus and rerun
    echo -n FUZA > "${BATS_TMPDIR}/CORPUS/FUZA"
    run "${BATS_TMPDIR}/a.out" "${BATS_TMPDIR}/CORPUS/*"
    assert_failure
    assert_output -p "running 1 inputs"

    # Merge profiling data again
    run llvm-profdata-$VERSION merge -sparse *.profraw -o "${BATS_TMPDIR}/default.profdata"
    assert_success "Failed to merge profiling data after adding new inputs"

    # Generate coverage report again
    run llvm-cov-$VERSION show "${BATS_TMPDIR}/a.out" \
        -instr-profile="${BATS_TMPDIR}/default.profdata" \
        -name=FuzzMe &> "${BATS_TMPDIR}/coverage.log"
    assert_success "llvm-cov failed to generate a coverage report after new inputs"
    assert_output -p "Data[3] == 'Z';"

    # Cleanup
    rm -rf "${BATS_TMPDIR}/CORPUS" "${BATS_TMPDIR}/fuzz_me.cc" "${BATS_TMPDIR}/StandaloneFuzzTargetMain.c" *.profraw
}

@test "Test BuildID in binaries for different linkers (Bug 916975)" {

    echo "int foo(void) {	return 0; }"> "${BATS_TMPDIR}/foo.c"
    echo "int foo(void); int main() {foo();	return 0;}"> "${BATS_TMPDIR}/main.c"

    # Case 1: Compile and link with LLD
    run clang-$VERSION -fuse-ld=lld -O2 "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" -o "${BATS_TMPDIR}/foo_lld"
    assert_success "Compilation and linking with LLD failed"

    # Check for BuildID in the LLD-linked binary
    run file "${BATS_TMPDIR}/foo_lld"
    assert_output -p "BuildID" "BuildID missing from binary generated with LLD"

    # Case 2: Compile and link with the specific LLD version
    run clang-$VERSION -fuse-ld=lld-$VERSION -O2 "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" -o "${BATS_TMPDIR}/foo_lld_version"
    assert_success "Compilation and linking with LLD-$VERSION failed"

    # Check for BuildID in the LLD-$VERSION-linked binary
    run file "${BATS_TMPDIR}/foo_lld_version"
    assert_output -p "BuildID" "BuildID missing from binary generated with LLD-$VERSION"

    # Case 3: Compile and link with default LD, then strip the binary
    run clang-$VERSION -O2 "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" -o "${BATS_TMPDIR}/foo_ld"
    assert_success "Compilation and linking with default LD failed"

    # Check for BuildID in the LD-linked binary
    run file "${BATS_TMPDIR}/foo_ld"
    assert_output -p "BuildID" "BuildID missing from binary generated with default LD"

    # Strip the binary and recheck for BuildID
    run strip "${BATS_TMPDIR}/foo_ld"
    assert_success "Stripping binary failed"

    run file "${BATS_TMPDIR}/foo_ld"
    assert_output -p "BuildID" "BuildID missing from stripped binary"

    # Cleanup
    rm -f "${BATS_TMPDIR}/foo.c" "${BATS_TMPDIR}/main.c" "${BATS_TMPDIR}/foo_lld" "${BATS_TMPDIR}/foo_lld_version" "${BATS_TMPDIR}/foo_ld"
}

@test "Test optimization record generation" {
    echo '#define N 1536
    float A[N][N];
    void test() {
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                A[i][j] = 0;
    }' > "${BATS_TMPDIR}/opt_test.c"

    run clang-$VERSION -S -O2 -fsave-optimization-record -emit-llvm "${BATS_TMPDIR}/opt_test.c" -o "${BATS_TMPDIR}/opt_test.s"
    assert_success

    run test -s "${BATS_TMPDIR}/opt_test.opt.yaml"
    assert_success
}

@test "Test LLVM tools - llvm-dis" {
    echo 'int main() { return 42; }' > "${BATS_TMPDIR}/llvm_tools_test.c"

    run clang-$VERSION -O3 -emit-llvm "${BATS_TMPDIR}/llvm_tools_test.c" -c -o "${BATS_TMPDIR}/llvm_tools_test.bc"
    assert_success

    run llvm-dis-$VERSION < "${BATS_TMPDIR}/llvm_tools_test.bc"
    assert_success
    assert_output -p "42"
}

@test "Test LLVM debuginfod-find" {
    run llvm-debuginfod-find-$VERSION --executable=1 5d016364c1cb69dd

    # Check that it's not built without curl support
    refute_output -p "No working HTTP"
}

@test "Test libclang library versions" {
    run test ! -f "/usr/lib/llvm-$VERSION/lib/libclang.so.1"
    assert_success "/usr/lib/llvm-$VERSION/lib/libclang.so.1 found. - Break the build as it breaks the coinstalability"
}

@test "Test clang-cpp linking" {
    echo '#include <vector>
    int main() { return 0; }' > "${BATS_TMPDIR}/cpp_link_test.cpp"

    run clang-$VERSION -lclang-cpp$VERSION "${BATS_TMPDIR}/cpp_link_test.cpp" -o "${BATS_TMPDIR}/cpp_link_test"
    assert_success

    run ldd "${BATS_TMPDIR}/cpp_link_test"
    assert_output -p "libclang-cpp"
    run "${BATS_TMPDIR}/cpp_link_test"
    assert_success
}

@test "Verify symbolic links for LLVM libraries" {
    check_symlink() {
        local symlink_path="/usr/lib/llvm-${VERSION}/lib/$1"

        # Check if the symlink exists
        if [ ! -e "$symlink_path" ]; then
            echo "Invalid symlink: $symlink_path"
            ls -al "$symlink_path" 2>/dev/null || true
            fail "Symbolic link validation failed for $1"
        fi
    }

    # Check required symlinks
    check_symlink "libclang-cpp.so"
    check_symlink "libclang-${VERSION}.so"
    check_symlink "libclang.so"
}

@test "Test Python Clang bindings" {
    skip_if_arch "i386"
    echo "
from ctypes import *
libclang='/usr/lib/llvm-$VERSION/lib/libclang-$VERSION.so.1'
lib = CDLL(libclang)
fun = lib.clang_getAddressSpace
print(fun)
    " > foo.py

    run python3 foo.py
    assert_output -p "_FuncPtr"
}

# ===================== libc++

@test "Test libc++ linking" {
    echo '#include <vector>
    	int main() { std::vector<int> v; v.push_back(1); return 0; }' > foo.cpp
    run clang++-$VERSION -stdlib=libc++ foo.cpp -o foo
    assert_success
    run ./foo
	assert_success
}

@test "Test libc++abi linking" {
    echo '#include <vector>
    	int main() { std::vector<int> v; v.push_back(1); return 0; }' > foo.cpp
    run clang++-$VERSION -stdlib=libc++ -lc++abi foo.cpp -o foo
    assert_success
    run ./foo
    assert_success
}

@test "Test libc++ compilation and linking" {
    # Create the C++ source file
    cat > "${BATS_TMPDIR}/libcxx_test.cpp" <<EOF
#include <vector>
#include <string>
#include <iostream>
using namespace std;
int main(void) {
    vector<string> tab;
    tab.push_back("the");
    tab.push_back("world");
    tab.insert(tab.begin(), "Hello");

    for(vector<string>::iterator it=tab.begin(); it!=tab.end(); ++it)
    {
        cout << *it << " ";
    }
    return 0;
}
EOF

    # Compile and link with libc++
    run clang++-$VERSION -stdlib=libc++ "${BATS_TMPDIR}/libcxx_test.cpp" -o "${BATS_TMPDIR}/o"
    assert_success "Compilation with libc++ failed"

    # Check if the binary is linked against libc++.so.1
    run ldd "${BATS_TMPDIR}/o"
    assert_output -p "libc++.so.1" "Binary is not linked against libc++.so.1"

    # Check if the binary is linked against libc++abi.so.1
    run ldd "${BATS_TMPDIR}/o"
    assert_output -p "libc++abi.so.1" "Binary is not linked against libc++abi.so.1"

    # Run the compiled binary
    run "${BATS_TMPDIR}/o" > /dev/null
    assert_success "Execution of binary with libc++ failed"

    # Compile with libc++ and C++11 standard
    run clang++-$VERSION -std=c++11 -stdlib=libc++ "${BATS_TMPDIR}/libcxx_test.cpp" -o "${BATS_TMPDIR}/o_cpp11"
    assert_success "Compilation with libc++ and C++11 failed"

    # Run the C++11 binary
    run "${BATS_TMPDIR}/o_cpp11" > /dev/null
    assert_success "Execution of C++11 binary with libc++ failed"

    # Compile with libc++, C++14 standard, and experimental features
    run clang++-$VERSION -std=c++14 -stdlib=libc++ "${BATS_TMPDIR}/libcxx_test.cpp" -lc++experimental -o "${BATS_TMPDIR}/o_cpp14"
    assert_success "Compilation with libc++, C++14, and experimental features failed"

    # Run the C++14 experimental binary
    run "${BATS_TMPDIR}/o_cpp14" > /dev/null
    assert_success "Execution of C++14 binary with libc++ and experimental features failed"
}

@test "Test libc++ filesystem support" {
    echo '#include <filesystem>
    #include <type_traits>
    using namespace std::filesystem;
    int main() {
        static_assert(std::is_same<
                path,
                std::filesystem::path
            >::value, "");
        return 0;
    }' > "${BATS_TMPDIR}/filesystem_test.cpp"

    run clang++-$VERSION -std=c++17 -stdlib=libc++ "${BATS_TMPDIR}/filesystem_test.cpp" -o "${BATS_TMPDIR}/filesystem_test"
    assert_success
}

@test "Test libc++ and libc++abi compatibility" {
    # Create the C++ source file
    echo '#include <chrono>
int main() { }' > "${BATS_TMPDIR}/foo.cpp"

    # Part 1: Compile and link with libc++ and libc++abi
    run clang++-$VERSION -stdlib=libc++ -lc++abi "${BATS_TMPDIR}/foo.cpp" -o "${BATS_TMPDIR}/o_libcxxabi"
    assert_success "Compilation with libc++ and libc++abi failed"

    # Execute the binary
    run "${BATS_TMPDIR}/o_libcxxabi" > /dev/null
    assert_success "Execution of binary linked with libc++ and libc++abi failed"

    # Check if the binary is linked against libc++abi.so.1
    run ldd "${BATS_TMPDIR}/o_libcxxabi"
    assert_output -p "libc++abi.so.1" "Binary is not linked against libc++abi.so.1"

    # Part 2: Compile with libc++abi and use libstdc++ headers
    run clang++-$VERSION -lc++abi "${BATS_TMPDIR}/foo.cpp" -o "${BATS_TMPDIR}/o_libstdc++"
    assert_success "Compilation with libc++abi and libstdc++ headers failed"

    # Execute the binary
    run "${BATS_TMPDIR}/o_libstdc++" > /dev/null
    assert_success "Execution of binary linked with libc++abi and libstdc++ headers failed"

    # Check if the binary is linked against libstdc++
    run ldd "${BATS_TMPDIR}/o_libstdc++"
    assert_output -p "libstdc++.so." "Binary is not linked against libstdc++"
}

@test "Test C++ exception handling with libc++ (Bug 1586215)" {
    cat > "${BATS_TMPDIR}/foo.cpp" <<EOF
#include <string>
#include <iostream>

int main()
{
    try
    {
        std::string x;
        char z = x.at(2);
        std::cout << z << std::endl;
    }
    catch (...)
    {
    }

    return 0;
}
EOF

    run clang++-$VERSION -stdlib=libc++ -Wall -Werror "${BATS_TMPDIR}/foo.cpp" -o "${BATS_TMPDIR}/foo"
    assert_success "Compilation with libc++ failed"

    run "${BATS_TMPDIR}/foo"
    assert_success "Execution of binary failed"
}
@test "Test inline C++ compilation with libc++ (Bug 889832)" {
    echo '#include <iostream>
int main() {}' > foo.cpp
    run clang++-$VERSION -std=c++1z -x c++ -stdlib=libc++ foo.cpp
    assert_success "Inline C++ compilation with libc++ failed"
}

@test "Test inline C++ compilation and libc++ modules (Bug 889832)" {

    echo '#include <iostream>
int main() {}' > foo.cpp
    run clang++-$VERSION -std=c++1z -x c++ -stdlib=libc++ foo.cpp
    assert_success "Inline C++ compilation with libc++ failed"


    cat > "${BATS_TMPDIR}/foo.cpp" <<EOF
import std;
import std.compat;

int main() {
  std::cout << "Hello modular world\\n";
  ::printf("Hello compat modular world\\n");
}
EOF

    # Build the std module
    run clang++-$VERSION -std=c++20 \
        -nostdinc++ \
        -isystem /usr/lib/llvm-$VERSION/include/c++/v1/ \
        -Wno-reserved-module-identifier -Wno-reserved-user-defined-literal \
        --precompile -o "${BATS_TMPDIR}/std.pcm" \
        -c /usr/lib/llvm-$VERSION/share/libc++/v1/std.cppm
    assert_success "Compilation of std module failed"

    # Build the std.compat module
    run clang++-$VERSION -std=c++20 \
        -nostdinc++ \
        -isystem /usr/lib/llvm-$VERSION/include/c++/v1/ \
        -Wno-reserved-module-identifier -Wno-reserved-user-defined-literal \
        --precompile -o "${BATS_TMPDIR}/std.compat.pcm" \
        -fmodule-file=std="${BATS_TMPDIR}/std.pcm" \
        -c /usr/lib/llvm-$VERSION/share/libc++/v1/std.compat.cppm
    assert_success "Compilation of std.compat module failed"

    # Build the test application
    run clang++-$VERSION -std=c++20 \
        -nostdinc++ \
        -isystem /usr/lib/llvm-$VERSION/include/c++/v1/ \
        -L /usr/lib/llvm-$VERSION/lib \
        -fmodule-file=std="${BATS_TMPDIR}/std.pcm" \
        -fmodule-file=std.compat="${BATS_TMPDIR}/std.compat.pcm" \
        "${BATS_TMPDIR}/std.pcm" \
        "${BATS_TMPDIR}/std.compat.pcm" \
        -lc++ \
        "${BATS_TMPDIR}/foo.cpp" -o "${BATS_TMPDIR}/a.out"
    assert_success "Compilation of test application failed"

    run "${BATS_TMPDIR}/a.out"
    assert_success "Execution of test application failed"
    assert_output -p "Hello modular world"
    assert_output -p "Hello compat modular world"
}

@test "Test libclc package presence" {
    if ! test -f "/usr/lib/clc/amdgcn--amdhsa.bc"; then
        skip "libclc-$VERSION not installed"
    fi

    run test -f "/usr/lib/clc/polaris10-amdgcn-mesa-mesa3d.bc"
    assert_success
}

@test "Test static linking with LLVM libc (libllvmlibc)" {

    cat > "${BATS_TMPDIR}/main.c" <<EOF
#include <math.h>
int main(void)
{
    double f = 2.0;
    if (isnan(f))
      return 1;
    return 0;
}
EOF

    # Compile the C program statically with libllvmlibc
    run clang-$VERSION -static -nostdlib -nolibc -L/usr/lib/llvm-$VERSION/lib/ -lllvmlibc \
        "${BATS_TMPDIR}/main.c" -o "${BATS_TMPDIR}/foo"
    assert_success "Compilation with libllvmlibc failed"

    # Verify no linkage to regular libc
    run ldd "${BATS_TMPDIR}/foo"
    refute_output -p "libc." "Binary is linked against regular libc"

    # Run the binary (segfault expected)
    run "${BATS_TMPDIR}/foo"
    assert_failure "Execution of binary failed (segfault expected)"
}



@test "Test HIP language support" {
    if ! dpkg -l | grep -q hipcc; then
        skip "hipcc not installed"
    fi

    echo '#include <hip/hip_runtime_api.h>
    int main() { return 0; }' > "${BATS_TMPDIR}/hip_test.hip"

    run clang++-$VERSION --rocm-path=/usr -x hip -lamdhip64 "${BATS_TMPDIR}/hip_test.hip"
    assert_success
}

@test "Test binary format check with lld" {
    echo 'bool testAndSet(void *atomic) {
        return __atomic_test_and_set(atomic, __ATOMIC_SEQ_CST);
    }' > "${BATS_TMPDIR}/format_test.cpp"

    run clang++-$VERSION -c -target aarch64-linux-gnu "${BATS_TMPDIR}/format_test.cpp"
    assert_success

    run file "format_test.o"
    assert_output -p "aarch64"
}

@test "Test errno header inclusion" {
    echo '#include <errno.h>
    int main() { return 0; }' > "${BATS_TMPDIR}/errno_test.c"

    run clang-$VERSION "${BATS_TMPDIR}/errno_test.c"
    assert_success
}

@test "Test ARM target features (Bug 930008)" {
    run clang-$VERSION --target=arm-linux-gnueabihf -dM -E -xc - < /dev/null
    assert_success
    assert_output -p "#define __ARM_ARCH 7"
}

@test "Test Cross TU optimization" {
    echo 'int sum(int a, int b);' > "${BATS_TMPDIR}/crosstu_1.h"
    echo '#include "crosstu_1.h"
    int sum(int a, int b) { return a + b; }' > "${BATS_TMPDIR}/crosstu_1.cpp"
    echo '#include "crosstu_1.h"
    int main() { return sum(1, 2); }' > "${BATS_TMPDIR}/crosstu_2.cpp"

    run clang++-$VERSION -c "${BATS_TMPDIR}/crosstu_1.cpp"
    assert_success
    run clang++-$VERSION -c "${BATS_TMPDIR}/crosstu_2.cpp"
    assert_success
}

@test "Test header generation" {
    echo "#include <fenv.h>" > "${BATS_TMPDIR}/header_test.cc"
    run clang++-$VERSION -P -E "${BATS_TMPDIR}/header_test.cc"
    assert_success

    # Check if output has more than 60 non-empty lines
    run bash -c "clang++-$VERSION -P -E ${BATS_TMPDIR}/header_test.cc | grep . | wc -l"
    assert [ "$output" -gt 60 ]
}

@test "Test atomic operations compilation (Bug 903709)" {
    # Bug 903709: Ensure atomic operations compile correctly

    cat > "${BATS_TMPDIR}/atomic_test.c" <<EOF
#include <stdatomic.h>
void increment(atomic_size_t *arg) {
    atomic_fetch_add(arg, 1);
}
EOF

    run clang-$VERSION -v -c "${BATS_TMPDIR}/atomic_test.c"
    assert_success "Compilation of atomic operations (stdatomic.h) failed"
}

@test "Test profile generation and use" {
    echo 'int X = 0;
    int main() {
        for (int i = 0; i < 100; i++)
            X += i;
        return 0;
    }' > "${BATS_TMPDIR}/profile_test.cc"

    run clang++-$VERSION -O2 -fprofile-instr-generate "${BATS_TMPDIR}/profile_test.cc" -o "${BATS_TMPDIR}/profile_test"
    assert_success

    LLVM_PROFILE_FILE="${BATS_TMPDIR}/profile_test-%p.profraw" run "${BATS_TMPDIR}/profile_test"
    assert_success

    run llvm-profdata-$VERSION merge -output="${BATS_TMPDIR}/profile_test.profdata" "${BATS_TMPDIR}/profile_test-"*.profraw
    assert_success

    run clang++-$VERSION -O2 -fprofile-instr-use="${BATS_TMPDIR}/profile_test.profdata" "${BATS_TMPDIR}/profile_test.cc" -o "${BATS_TMPDIR}/profile_test_final"
    assert_success
}

# ===================== flang

@test "Test flang Fortran compilation" {
    echo 'program math
  implicit none
  real :: x, y
  x = 3.14
  y = 2.71
  print *, "x + y = ", x + y
end program math' > foo.f90
    run flang-new-$VERSION foo.f90 -o foo
    assert_success
    run ./foo
    assert_success
    assert_output -p  "x + y ="
}

@test "Test flang shared library functionality" {
    if ! dpkg -l | grep -q "flang-$VERSION"; then
        skip "flang-$VERSION not installed"
    fi

    echo 'module hello_world
        contains
            subroutine say_hello()
                print *, "Hello, World!"
            end subroutine say_hello
    end module hello_world' > "${BATS_TMPDIR}/flang_lib.f90"

    run flang-new-$VERSION -c "${BATS_TMPDIR}/flang_lib.f90" -fpie
    assert_success

    run flang-new-$VERSION -shared -fpie -o "${BATS_TMPDIR}/libflib.so" "flang_lib.o"
    assert_success

    echo 'program main
        use hello_world
        call say_hello()
    end program main' > "${BATS_TMPDIR}/flang_main.f90"

    run flang-new-$VERSION "${BATS_TMPDIR}/flang_main.f90" -L"${BATS_TMPDIR}" -lflib -o "${BATS_TMPDIR}/flang_test"
    assert_success

    LD_LIBRARY_PATH="${BATS_TMPDIR}" run "${BATS_TMPDIR}/flang_test"
    assert_output -p "Hello, World!"
}

@test "Verify llvm-symbolizer functionality in verbose mode" {
    # Define the path to llvm-symbolizer
    local symbolizer_path="/usr/lib/llvm-${VERSION}/bin/llvm-symbolizer"

    # Ensure llvm-symbolizer exists
    run test -f "${symbolizer_path}"
    assert_success "llvm-symbolizer is missing"

    # Create a simple test program
    echo '#include <stdlib.h>
    int main() {
        char *x = (char*)malloc(10 * sizeof(char*));
        free(x);
        return x[5];  // Invalid memory access
    }' > "${BATS_TMPDIR}/asan_test.c"

    # Compile with AddressSanitizer and enable verbose mode
    run clang-$VERSION -o "${BATS_TMPDIR}/asan_test" -fsanitize=address -fno-omit-frame-pointer -g "${BATS_TMPDIR}/asan_test.c"
    assert_success

    # Run the test program with verbose symbolizer options
    ASAN_OPTIONS=verbosity=2:external_symbolizer_path="${symbolizer_path}" run "${BATS_TMPDIR}/asan_test"
    assert_failure
    assert_output -p "Using llvm-symbolizer"
}

@test "Test SIMD intrinsics compilation (AMD64/i386)" {
    # Skip test if not on AMD64 or i386 architectures
    if [[ "$DEB_HOST_ARCH" != "amd64" && "$DEB_HOST_ARCH" != "i386" ]]; then
        skip "Test skipped for non-x86 architectures"
    fi

    # Create a C++ source file with SIMD intrinsics
    echo '#include <emmintrin.h>' > "${BATS_TMPDIR}/simd_test.cc"

    # Compile the source file
    run clang++-$VERSION -c "${BATS_TMPDIR}/simd_test.cc"
    assert_success "Compilation of SIMD intrinsics (<emmintrin.h>) failed on x86"
}

@test "Test preprocessing of limits header (Bug 913213)" {
    echo '#include <limits.h>' > "${BATS_TMPDIR}/limits_test.cc"

    # Compile the source file
    run clang++-$VERSION -E -c "${BATS_TMPDIR}/limits_test.cc"
    assert_output -p "limits.h"
    assert_success "Preprocessing of <limits.h> failed"
}

@test "Test cross-compiler compatibility for C++ objects (Bug 1488254)" {
    cat > "${BATS_TMPDIR}/foo.cc" <<EOF
#include <string>
std::string hello = "Hello, world!\\n";
EOF

    cat > "${BATS_TMPDIR}/bar.cc" <<EOF
#include <string>
#include <iostream>
extern std::string hello;
int main() {
    std::cout << hello;
    return 0;
}
EOF

    # Test 1: Compile and link using GCC
    run g++ -c "${BATS_TMPDIR}/foo.cc" -o "${BATS_TMPDIR}/foo.o"
    assert_success "Compilation with GCC failed for foo.cc"
    run g++ "${BATS_TMPDIR}/foo.o" "${BATS_TMPDIR}/bar.cc" -o "${BATS_TMPDIR}/a.out"
    assert_success "Linking with GCC failed"
    run "${BATS_TMPDIR}/a.out"
    assert_success "Execution failed for binary compiled and linked with GCC"

    # Test 2: Compile and link using Clang++
    run clang++-$VERSION -c "${BATS_TMPDIR}/foo.cc" -o "${BATS_TMPDIR}/foo.o"
    assert_success "Compilation with Clang++ failed for foo.cc"
    run clang++-$VERSION "${BATS_TMPDIR}/foo.o" "${BATS_TMPDIR}/bar.cc" -o "${BATS_TMPDIR}/a.out"
    assert_success "Linking with Clang++ failed"
    run "${BATS_TMPDIR}/a.out"
    assert_success "Execution failed for binary compiled and linked with Clang++"

    # Test 3: Compile with GCC, link with Clang++
    run g++ -c "${BATS_TMPDIR}/foo.cc" -o "${BATS_TMPDIR}/foo.o"
    assert_success "Compilation with GCC failed for foo.cc"
    run clang++-$VERSION "${BATS_TMPDIR}/foo.o" "${BATS_TMPDIR}/bar.cc" -o "${BATS_TMPDIR}/a.out"
    assert_success "Linking with Clang++ failed for GCC-compiled object"
    run "${BATS_TMPDIR}/a.out"
    assert_success "Execution failed for GCC-compiled, Clang++-linked binary"

    # Test 4: Compile with Clang++ -fPIC, link with GCC
    run clang++-$VERSION -c "${BATS_TMPDIR}/foo.cc" -fPIC -o "${BATS_TMPDIR}/foo.o"
    assert_success "Compilation with Clang++ -fPIC failed for foo.cc"
    run g++ "${BATS_TMPDIR}/foo.o" "${BATS_TMPDIR}/bar.cc" -o "${BATS_TMPDIR}/a.out"
    assert_success "Linking with GCC failed for Clang++-compiled object"
    run "${BATS_TMPDIR}/a.out"
    assert_success "Execution failed for Clang++-compiled, GCC-linked binary"
}

@test "Test static linking and unwind library (Bug 46321)" {
    cat > "${BATS_TMPDIR}/test.cpp" <<EOF
#include <iostream>
int main() {
  std::cout << "Hello World!" << std::endl;
}
EOF

    # Compile and link with libc++, libunwind, and static libstdc++
    run clang++-$VERSION -stdlib=libc++ -unwindlib=libunwind -rtlib=compiler-rt \
        -static-libstdc++ -static-libgcc "${BATS_TMPDIR}/test.cpp" -lpthread -ldl -o "${BATS_TMPDIR}/test_static"
    assert_success "Compilation with static linking and unwind library failed"

    # Execute the binary
    run "${BATS_TMPDIR}/test_static" > /dev/null
    assert_success "Execution of static-linked binary failed"

    # Compile with libc++, static libstdc++, and LLD
    run clang++-$VERSION -stdlib=libc++ -static-libstdc++ -fuse-ld=lld -l:libc++abi.a \
        "${BATS_TMPDIR}/test.cpp" -o "${BATS_TMPDIR}/test_lld"
    assert_success "Compilation with LLD failed"

    # Execute the binary
    run "${BATS_TMPDIR}/test_lld" > /dev/null
    assert_success "Execution of LLD-linked binary failed"

    # Compile with libc++ and nostdlib++
    run clang++-$VERSION -stdlib=libc++ -nostdlib++ "${BATS_TMPDIR}/test.cpp" \
        -l:libc++.a -l:libc++abi.a -pthread -o "${BATS_TMPDIR}/test_nostdlib"
    assert_success "Compilation with nostdlib++ failed"

    # Execute the binary
    run "${BATS_TMPDIR}/test_nostdlib" > /dev/null
    assert_success "Execution of nostdlib++ binary failed"
}

@test "Test shared plugin compilation (Bug 43604)" {

    cat > "${BATS_TMPDIR}/plugin_test.cpp" <<EOF
#include <iostream>
__attribute__((visibility("default")))
extern "C" void plugin() {
    std::cout << "Hello World from a plugin!" << std::endl;
}
EOF

    # Compile the shared library with hidden visibility and static libstdc++
    run clang++-$VERSION -shared -o "${BATS_TMPDIR}/plugin.so" -fvisibility=hidden \
        "${BATS_TMPDIR}/plugin_test.cpp" -static-libstdc++ || true
    assert_success "Compilation of shared plugin with static libstdc++ failed"

    # Compile the shared library with hidden visibility and libc++
    run clang++-$VERSION -shared -o "${BATS_TMPDIR}/plugin.so" -fvisibility=hidden \
        "${BATS_TMPDIR}/plugin_test.cpp" -stdlib=libc++ -static-libstdc++ || true
    assert_success "Compilation of shared plugin with libc++ failed"

    # Cleanup
    rm -f "${BATS_TMPDIR}/plugin.so"
}

@test "Test if LLVM IR bitcode in libclangIndex.a" {
    rm -f *.o
    # Define the path to libclangIndex.a
    local archive_path="/usr/lib/llvm-${VERSION}/lib/libclangIndex.a"

    # Ensure the archive exists
    run test -f "${archive_path}"
    assert_success "libclangIndex.a is missing"

    # Extract the archive contents
    run /usr/bin/ar x "${archive_path}" --output "${BATS_TMPDIR}"
    assert_success "Failed to extract libclangIndex.a"

    # Check the extracted object files
    run file "${BATS_TMPDIR}"/*.o
    refute_output -p "LLVM IR bitcode" "Found LLVM IR bitcode in libclangIndex.a"
}

@test "Test Z3 solver integration for static analysis" {
    # Create the C source file
    cat > "${BATS_TMPDIR}/z3_test.c" <<EOF
void clang_analyzer_eval(int);
void testBitwiseRules(unsigned int a, int b) {
  clang_analyzer_eval((1 & a) <= 1); // expected-warning{{TRUE}}
  // with -analyzer-constraints=z3, it can tell that it is FALSE
  // without the option, it is unknown
  clang_analyzer_eval((b | -2) >= 0); // expected-warning{{FALSE}}
}
EOF

    # Step 1: Check if LLVM was built with Z3 support
    run clang-$VERSION -cc1 -analyze -analyzer-constraints=range -analyzer-checker=core,debug.ExprInspection -analyzer-constraints=z3 "${BATS_TMPDIR}/z3_test.c" &> "${BATS_TMPDIR}/z3_test.log" || true
    if grep -q "error: analyzer constraint manager 'z3' is only available if LLVM was built with -DLLVM_ENABLE_Z3_SOLVER=ON" "${BATS_TMPDIR}/z3_test.log"; then
        skip "Z3 solver not available in this LLVM build"
    fi

    # Step 2: Run static analysis with Z3 constraints
    run clang-$VERSION -cc1 -analyze -analyzer-constraints=range -analyzer-checker=core,debug.ExprInspection -verify -analyzer-config eagerly-assume=false -analyzer-constraints=z3 "${BATS_TMPDIR}/z3_test.c"
    assert_success "Static analysis with Z3 constraints failed"

    # Step 3: Verify warnings generated
    run clang-$VERSION -cc1 -analyze -analyzer-constraints=range -analyzer-checker=core,debug.ExprInspection -analyzer-constraints=z3 "${BATS_TMPDIR}/z3_test.c" &> "${BATS_TMPDIR}/z3_test.log"
    assert_success "Static analysis with Z3 constraints failed on verification"
    cat "${BATS_TMPDIR}/z3_test.log"
    assert_output -p "2 warnings generated."

    # Step 4: Run static analysis without Z3 constraints
    run clang-$VERSION -cc1 -analyze -analyzer-constraints=range -analyzer-checker=core,debug.ExprInspection -verify -analyzer-config eagerly-assume=false "${BATS_TMPDIR}/z3_test.c" &> "${BATS_TMPDIR}/z3_test.log" || true
    refute_output -p "File a.c Line 7: UNKNOWN" "Static analysis should fail without Z3 constraints"

    # Step 5: Verify general static analysis warnings
    run clang-$VERSION -cc1 -analyze -analyzer-constraints=range -analyzer-checker=core,debug.ExprInspection "${BATS_TMPDIR}/z3_test.c" &> "${BATS_TMPDIR}/z3_test.log"
    assert_success "Static analysis failed"
    cat "${BATS_TMPDIR}/z3_test.log"
    assert_output -p "warnings generated."

}

@test "Test atomic test-and-set compilation for AArch64 (Bug 827866)" {

    cat > "${BATS_TMPDIR}/atomic_test.cpp" <<EOF
bool testAndSet(void *atomic) {
    return __atomic_test_and_set(atomic, __ATOMIC_SEQ_CST);
}
EOF

    run clang++-$VERSION -c -target aarch64-linux-gnu "${BATS_TMPDIR}/atomic_test.cpp" -o "${BATS_TMPDIR}/atomic_test.o"
    assert_success "Compilation for AArch64 target failed"

    # Check the object file architecture
    run file "${BATS_TMPDIR}/atomic_test.o"
    assert_output -p "aarch64" "Expected 'aarch64' in the object file's architecture output"
}

@test "Test Thin LTO functionality" {
    echo "int foo(void) { return 0; }" > "${BATS_TMPDIR}/thinlto_1.c"
    echo "int foo(void); int main() { return foo(); }" > "${BATS_TMPDIR}/thinlto_2.c"

    run clang-$VERSION -flto=thin -O2 "${BATS_TMPDIR}/thinlto_1.c" "${BATS_TMPDIR}/thinlto_2.c" -o "${BATS_TMPDIR}/thinlto_test"
    assert_success

    run "${BATS_TMPDIR}/thinlto_test"
    assert_success
}

@test "Test compilation and execution with LTO and Gold linker" {
    cat > "${BATS_TMPDIR}/foo.c" <<EOF
#include <stdio.h>
int main() {
    if (1==1) {
        printf("true");
    } else {
        printf("false");
        return 42;
    }
    return 0;
}
EOF

    # Test 1: Compile with LTO and execute
    run clang-$VERSION -flto "${BATS_TMPDIR}/foo.c" -opaque-pointers -o "${BATS_TMPDIR}/foo_lto"
    assert_success "Compilation with LTO failed"
    run "${BATS_TMPDIR}/foo_lto"
    assert_success "Execution of LTO binary failed"

    # Test 2: Compile with Gold linker and execute
    run clang-$VERSION -fuse-ld=gold "${BATS_TMPDIR}/foo.c" -o "${BATS_TMPDIR}/foo_gold"
    assert_success "Compilation with Gold linker failed"
    run "${BATS_TMPDIR}/foo_gold"
    assert_success "Execution of binary linked with Gold linker failed"
}

@test "Test LTO file generation and Gold linker compatibility (Bug 919020)" {

    echo "int foo(void) { return 0; }" > "${BATS_TMPDIR}/foo.c"

    # Compile the source file with LTO
    run clang-$VERSION -flto -c "${BATS_TMPDIR}/foo.c" -o "${BATS_TMPDIR}/foo.o"
    assert_success "Compilation with LTO failed"

    # Check if the output is LLVM IR bitcode
    run file "${BATS_TMPDIR}/foo.o"
    assert_output -p "LLVM IR bitcode" "Expected LLVM IR bitcode but found otherwise"

    # Check if the symbol `foo` is present in the LTO object
    run llvm-nm-$VERSION "${BATS_TMPDIR}/foo.o"
    assert_output -p "T foo" "Symbol 'foo' not found in LTO object file, indicating Gold linker issue"
}

@test "Test LLVM Exegesis execution validation" {
    # Run llvm-exegesis with vzeroupper snippet
    echo "vzeroupper" | llvm-exegesis-$VERSION -mode=uops -snippets-file=- &> "${BATS_TMPDIR}/exegesis.log" || true

    # Check for issues related to libpfm initialization
    if grep -q -E "(built without libpfm|cannot initialize libpfm)" "${BATS_TMPDIR}/exegesis.log"; then
        echo "llvm-exegesis could not run correctly"
        head -n 10 "${BATS_TMPDIR}/exegesis.log"
        fail "llvm-exegesis execution failed due to libpfm issues"
    fi

    # Ensure llvm-exegesis produced output successfully
    run test -s "${BATS_TMPDIR}/exegesis.log"
    assert_success "llvm-exegesis did not produce valid output"
}

@test "Test backtrace functionality with libunwind" {
    # Create the C++ source file for backtrace tests
    cat > "${BATS_TMPDIR}/backtrace_test.cpp" <<EOF
#include <libunwind.h>
#include <stdlib.h>

void backtrace(int lower_bound) {
  unw_context_t context;
  unw_getcontext(&context);

  unw_cursor_t cursor;
  unw_init_local(&cursor, &context);

  int n = 0;
  do {
    ++n;
    if (n > 100) {
      abort();
    }
  } while (unw_step(&cursor) > 0);

  if (n < lower_bound) {
    abort();
  }
}

void test1(int i) {
  backtrace(i);
}

void test2(int i, int j) {
  backtrace(i);
  test1(j);
}

void test3(int i, int j, int k) {
  backtrace(i);
  test2(j, k);
}

void test_no_info() {
  unw_context_t context;
  unw_getcontext(&context);

  unw_cursor_t cursor;
  unw_init_local(&cursor, &context);

  unw_proc_info_t info;
  int ret = unw_get_proc_info(&cursor, &info);
  if (ret != UNW_ESUCCESS)
    abort();

  unw_set_reg(&cursor, UNW_REG_IP, (unw_word_t)0);

  ret = unw_get_proc_info(&cursor, &info);
  if (ret != UNW_ENOINFO)
    abort();
}

int main(int, char**) {
  test1(1);
  test2(1, 2);
  test3(1, 2, 3);
  test_no_info();
  return 0;
}
EOF

    # Compile the program with libunwind
    run clang++-$VERSION "${BATS_TMPDIR}/backtrace_test.cpp" -lunwind -ldl -I/usr/include/libunwind -o "${BATS_TMPDIR}/backtrace_test"
    assert_success "Compilation with libunwind failed"

    # Run the compiled program
    run "${BATS_TMPDIR}/backtrace_test"
    assert_success "Execution of backtrace test failed"

    # Compile with libunwind and compiler-rt
    run clang++-$VERSION "${BATS_TMPDIR}/backtrace_test.cpp" -unwindlib=libunwind -rtlib=compiler-rt -I/usr/include/libunwind -ldl -o "${BATS_TMPDIR}/backtrace_test_rt"
    assert_success "Compilation with libunwind and compiler-rt failed"

    # Run the compiled program with compiler-rt
    run "${BATS_TMPDIR}/backtrace_test_rt"
    assert_success "Execution of backtrace test with compiler-rt failed"
}
@test "Test signal handling with libunwind" {
    # Create the C++ source file for signal handling
    cat > "${BATS_TMPDIR}/signal_test.cpp" <<EOF
#include <assert.h>
#include <dlfcn.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <unwind.h>

_Unwind_Reason_Code frame_handler(struct _Unwind_Context* ctx, void* arg) {
  (void)arg;
  Dl_info info = { 0, 0, 0, 0 };

  if (dladdr(reinterpret_cast<void *>(_Unwind_GetIP(ctx)), &info) &&
      info.dli_sname && !strcmp("main", info.dli_sname)) {
    _Exit(0);
  }
  return _URC_NO_REASON;
}

void signal_handler(int signum) {
  (void)signum;
  _Unwind_Backtrace(frame_handler, NULL);
  _Exit(-1);
}

int main(int, char**) {
  signal(SIGUSR1, signal_handler);
  kill(getpid(), SIGUSR1);
  return -2;
}
EOF

    # Compile the program with libunwind statically
    run clang++-$VERSION "${BATS_TMPDIR}/signal_test.cpp" /usr/lib/llvm-$VERSION/lib/libunwind.a -I/usr/include/libunwind/ -lpthread -ldl -o "${BATS_TMPDIR}/signal_test_static"
    assert_success "Compilation of signal handler with static libunwind failed"

    # Run the statically linked program (should exit gracefully)
    run "${BATS_TMPDIR}/signal_test_static"
    assert_failure "Execution of signal handler with static libunwind failed"

    # Compile with libunwind dynamically
    run clang++-$VERSION "${BATS_TMPDIR}/signal_test.cpp" -unwindlib=libunwind -rtlib=compiler-rt -I/usr/include/libunwind -ldl -o "${BATS_TMPDIR}/signal_test_dynamic"
    assert_success "Compilation of signal handler with dynamic libunwind failed"

    # Run the dynamically linked program (should exit gracefully)
    run "${BATS_TMPDIR}/signal_test_dynamic"
    assert_failure "Execution of signal handler with dynamic libunwind failed"
}

teardown() {
    rm -f clangd.json *.o foo* crash-* *profraw hello* a.out polly_test.c
    rm -rf scan-build output
}
