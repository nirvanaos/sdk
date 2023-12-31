dest_dir="sdk"
build_dir="build"
version="1.0"

set -e

./build_compiler.sh
./build_lld.sh

./build_libraries.sh debug
./build_libraries.sh release
meson install -C $build_dir --tags inc --destdir "$PWD/$dest_dir"

./build_libc.sh x64 Debug
./build_libc.sh x64 Release
#./build_libc.sh x86 Debug
#./build_libc.sh x86 Release

./build_libcxx.sh x64 Debug
./build_libcxx.sh x64 Release

tar -Jcvf sdk-$version.tar.xz $dest_dir

rm -rf test/subprojects/sdk
mkdir -p test/subprojects/packagefiles
cp sdk-$version.tar.xz test/subprojects/packagefiles
