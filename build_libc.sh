if [[ $# -ge 1 ]]; then
	platform=$1
else
	platform="x64"
fi

if [[ $# -ge 2 ]]; then
	config=$2
else
	config="Debug"
fi

set -e

dest_dir="$PWD/distr"
build_dir="$PWD/build-libc-$platform-$config"
main_build="$PWD/build"
llvm_root="$PWD/llvm-project"
libc_config="$PWD/libc"

if [[ "$platform" == "x64" ]]; then
triple="x86_64-pc-none-eabi"
else
triple="i686-pc-none-eabi"
fi

meson install -C $main_build --tags inc --destdir $build_dir/projects/libc

cmake "$llvm_root/llvm" -B "$build_dir" -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" \
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
	-DCMAKE_CXX_FLAGS="-DLIBC_COPT_USE_C_ASSERT -fshort-wchar" \
	-DCMAKE_C_FLAGS="-DLIBC_COPT_USE_C_ASSERT -fshort-wchar" \
	-DLLVM_ENABLE_LIBCXX=ON \
	-DLIBC_TARGET_TRIPLE="$triple" \
	-DCMAKE_BUILD_TYPE="$config"

ninja -C $build_dir libc

dest_path="$dest_dir/$platform/$config"
/bin/mkdir -p $dest_path
/bin/cp "$build_dir/projects/libc/lib/libllvmlibc.a" $dest_path
