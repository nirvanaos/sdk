if ($args.count -ge 1) {
	$platform = $args[0]
} else {
	$platform = "x64"
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

if (Test-Path .\build\$platform\$config) {
	Remove-Item .\build -Force -Recurse
}
mkdir .\build\$platform\$config
Set-Location .\build\$platform\$config

#$triple = "x86_64-w64-none-eabi"
if ($platform -contains "x64") {
	$triple = "x86_64-pc-none-eabi"
} else {
	$triple = "i386-pc-none-eabi"
}

Write-Host $triple

$full_build = $false

if ($full_build) {
$hdrgen = $llvm_root + "\build-libc-tools\bin\libc-hdrgen.exe"
& cmake ../../../runtimes -G Ninja -DLLVM_ENABLE_RUNTIMES="libc" -DLIBC_CONFIG_PATH="$libc_config" `
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ `
	-DLIBC_HDRGEN_EXE="$hdrgen" `
	-DCMAKE_CXX_FLAGS="-DLIBC_COPT_USE_C_ASSERT" `
	-DLLVM_ENABLE_LIBCXX=ON `
	-DLLVM_LIBC_FULL_BUILD=ON `
	-DLIBC_TARGET_TRIPLE="$triple" `
	-DCMAKE_BUILD_TYPE="$config" `
	-DCMAKE_INSTALL_PREFIX="$destdir/$platform/$config"

} else {
	& cmake ../../../llvm -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" `
	-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ `
	-DCMAKE_CXX_FLAGS="-DLIBC_COPT_USE_C_ASSERT" `
	-DLLVM_ENABLE_LIBCXX=ON `
	-DLIBC_TARGET_TRIPLE="$triple" `
	-DCMAKE_BUILD_TYPE="$config" `
	-DCMAKE_INSTALL_PREFIX="$destdir/$platform/$config"

}
#	ninja libc libm
# ninja install-libc
#Set-Location $PSScriptRoot
