dest_dir="sdk"
build_dir="build"

set -e

./build_compiler.sh

./build_libraries.sh debug
./build_libraries.sh release
meson install -C $build_dir --tags inc --destdir $dest_dir

./build_libc.sh x64 Debug
./build_libc.sh x64 Release
#./build_libc.sh x86 Debug
#./build_libc.sh x86 Release

tar -Jcvf sdk.tar.xz $dest_dir