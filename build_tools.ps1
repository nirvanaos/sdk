$ErrorActionPreference = "Stop"

$llvm_root = $PSScriptRoot + "\llvm-project"
$libc_config = $PSScriptRoot + "\libc"

Set-Location $llvm_root
if (Test-Path build-libc-tools) {
	Remove-Item build-libc-tools -Force -Recurse
}
mkdir build-libc-tools
Set-Location build-libc-tools

#-DLIBC_CONFIG_PATH="$libc_config" -DLLVM_LIBC_FULL_BUILD=ON `

& cmake ../llvm -G Ninja -DLLVM_ENABLE_PROJECTS="libc" `
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ `
   -DLLVM_ENABLE_PROJECTS=libc `
	 -DLIBC_CONFIG_PATH="$libc_config" -DLLVM_LIBC_FULL_BUILD=ON `
	 -DLIBC_TARGET_OS_IS_BAREMETAL=ON `
   -DCMAKE_BUILD_TYPE=Debug

ninja libc-hdrgen

Set-Location $PSScriptRoot
