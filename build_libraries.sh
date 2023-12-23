dest_dir="$PWD/distr"
build_dir="build"

if [[ $# -ge 1 ]]; then
	config=$1
else
	config="debug"
fi

set -e

meson setup $build_dir --reconfigure --buildtype $config --bindir /c/msys64/clang64/bin
#meson compile -C $build_dir
meson test -C $build_dir
meson install -C $build_dir --tags host,lib --destdir $dest_dir
