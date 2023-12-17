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

$llvm_root = "$PSScriptRoot\llvm-project"
$libc_config = "$PSScriptRoot\libc"
$main_build = "$PSScriptRoot\build"

$build_path = "$llvm_root\build"

if (Test-Path $build_path) {
	Remove-Item $build_path -Force -Recurse
}
mkdir $build_path

if ($platform -contains "x64") {
	$triple = "x86_64-pc-none-eabi"
} else {
	$triple = "i686-pc-none-eabi"
}

meson install -C $main_build --tags inc --destdir $build_path/projects/libc

& cmake "$llvm_root/llvm" -B "$build_path" -G Ninja -DLLVM_ENABLE_PROJECTS="libc" -DLIBC_CONFIG_PATH="$libc_config" `
-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ `
-DCMAKE_CXX_FLAGS="-DLIBC_COPT_USE_C_ASSERT" `
-DLLVM_ENABLE_LIBCXX=ON `
-DLIBC_TARGET_TRIPLE="$triple" `
-DCMAKE_BUILD_TYPE="$config"

ninja -C $build_path libc

$dest_path = "$destdir\lib\$platform\$config"
if (-not (Test-Path $dest_path)) {
	New-Item -ItemType Directory -Path $dest_path
}
Copy-Item "$build_path\projects\libc\lib\libllvmlibc.a" -Destination $dest_path -Force
# ninja install-libc
Set-Location $PSScriptRoot
