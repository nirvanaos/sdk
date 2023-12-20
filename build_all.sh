dest_dir="distr"
build_dir="build"

./build_compiler.sh
./build.sh x64 debug
./build.sh x64 release
meson install -C $build_dir --tags inc --destdir $dest_dir