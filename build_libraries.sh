dest_dir="$PWD/distr"
build_dir="build"

set -e

meson setup $build_dir --reconfigure
#meson compile -C $build_dir
meson test -C $build_dir
meson install -C $build_dir --destdir $dest_dir
