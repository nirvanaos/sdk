if [[ $# -ge 1 ]]; then
	platform=$1
else
	platform="x64"
fi

if [[ $# -ge 2 ]]; then
	config=$2
else
	config="debug"
fi

set -e

dest_dir="$PWD/sdk"
build_dir="$PWD/build-libc-$platform-$config"
main_build="build"
llvm_root="llvm-project"
libc_config="$PWD/libc"

if [[ "$platform" == "x64" ]]; then
triple="x86_64-pc-none-elf"
cpu_features="AVX;AVX2;FMA;SSE2;SSE4_2"
else
triple="i686-pc-none-elf"
cpu_features="MMX;SSE"
fi

meson install -C $main_build --tags inc --destdir $build_dir/projects/libc

# Define LLVM_LIBC_SRC___SUPPORT_FILE_FILE_H to avoid File/file.h include.
# -DLLVM_LIBC_SRC___SUPPORT_FILE_FILE_H\
cpp_flags="-DLIBC_COPT_USE_C_ASSERT -D_LIBCPP_PROVIDES_DEFAULT_RUNE_TABLE -D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS\
 -DLIBC_COPT_STDIO_USE_SYSTEM_FILE\
 -fshort-wchar -fsized-deallocation"

# echo $cpp_flags

#	-DLLVM_ENABLE_LIBCXX=ON \
#	
#	-DCMAKE_C_FLAGS="$cpp_flags -std=c11" \
#	-DLIBC_COMMON_TUNE_OPTIONS="-Wno-unused-function -Wno-implicit-int-conversion -Wno-implicit-int-float-conversion -Wno-c99-extensions -Wno-all" \
# LIBC_COMPILE_OPTIONS_DEFAULT
cmake "$llvm_root/llvm" -B "$build_dir" -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" \
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
	-DCMAKE_CXX_FLAGS="$cpp_flags" \
	-DLLVM_ENABLE_LIBCXX=ON \
	-DLIBC_TARGET_TRIPLE="$triple" \
	-DLIBC_CPU_FEATURES="$cpu_features" \
	-DCMAKE_BUILD_TYPE="$config"

ninja -C $build_dir libc

dest_path="$dest_dir/$config"
mkdir -p $dest_path
set -x
cp "$build_dir/projects/libc/lib/libllvmlibc.a" "$dest_path/libllvmlibc-$platform.a"
