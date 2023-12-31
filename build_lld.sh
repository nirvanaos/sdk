llvm_root="llvm-project"
build_dir="build-lld"
dest_dir="$PWD/sdk"

host_system=$OSTYPE
if [[ $host_system == "msys" ]]; then
host_system="windows"
fi

set -x
cmake "$llvm_root/llvm" -B "$build_dir" -G "Ninja" -DLLVM_ENABLE_PROJECTS="lld" \
	-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$dest_dir/$host_system" \
	-DLLVM_TARGETS_TO_BUILD="X86" \
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++

ninja -C "$build_dir" install-lld
