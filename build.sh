dest_dir="$PWD/distr"
build_dir="build"

set -e

./build_compiler.sh

meson setup $build_dir --reconfigure
meson compile -C $build_dir
meson test -C $build_dir
meson install -C $build_dir --destdir $dest_dir

#./build_libc.sh x64 Debug
#./build_libc.sh x64 Release
#./build_libc.sh x86 Debug
#./build_libc.sh x86 Release
