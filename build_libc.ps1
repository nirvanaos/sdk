$llvm_root = $PSScriptRoot + "\llvm-project"
$libc_config = $PSScriptRoot + "\libc"

cd $llvm_root

mkdir .\build
cd .\build

& cmake ../llvm -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" -DLIBC_TARGET_ARCHITECTURE=x86_64 `
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ `
	-DCMAKE_BUILD_TYPE=Debug `
	-DCMAKE_INSTALL_PREFIX="c:\nirvanasdk"
