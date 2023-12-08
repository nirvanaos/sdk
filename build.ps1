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
	$destdir = $args[1]
} else {
	$destdir = "C:/nirvanasdk/lib"
}

$ErrorActionPreference = "Stop"

meson setup --buildtype=$config --native-file=meson_$platform.ini build/$platform/$config
meson compile -C build/$platform/$config
meson test -C build/$platform/$config
meson install -C build/$platform/$config --tags lib --destdir $destdir/lib/$platform/$config
