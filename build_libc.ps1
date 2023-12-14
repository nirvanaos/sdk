if ($args.count -ge 1) {
	$platform = $args[0]
} else {
	$platform = "x86_64"
}
if ($args.count -ge 2) {
	$config = $args[1]
} else {
	$config = "debug"
}
if ($args.count -ge 3) {
	$destdir = $args[2]
} else {
	$destdir = "C:/nirvanasdk"
}

$ErrorActionPreference = "Stop"

$llvm_root = $PSScriptRoot + "\llvm-project"
$libc_config = $PSScriptRoot + "\libc"

Set-Location $llvm_root

if (Test-Path .\build) {
	Remove-Item .\build -Force -Recurse
}
mkdir .\build
Set-Location .\build

& cmake ../llvm -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" `
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang `
	-DLLVM_ENABLE_LIBCXX=ON `
	-DLIBC_TARGET_OS=baremetal `
	-DLIBC_TARGET_ARCHITECTURE="$platform" `
	-DCMAKE_BUILD_TYPE="$config" `
	-DCMAKE_INSTALL_PREFIX="$destdir"
