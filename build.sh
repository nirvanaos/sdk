set -e

./build_compiler.sh
./build_libraries.sh

./build_libc.sh x64 Debug
./build_libc.sh x64 Release
#./build_libc.sh x86 Debug
#./build_libc.sh x86 Release
