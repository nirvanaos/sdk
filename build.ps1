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
	$destdir = "$PSScriptRoot\distr"
}

$ErrorActionPreference = "Stop"

$build_path = "build"

if (Test-Path $build_path) {
	Remove-Item $build_path -Force -Recurse
}

meson setup --buildtype=$config --native-file=meson_$platform.ini "$build_path"
#meson compile -C build/$platform/$config
meson test -C $build_path
meson install -C $build_path --tags lib --destdir $destdir/lib/$platform/$config

.\build_libc.ps1 $platform $config $destdir