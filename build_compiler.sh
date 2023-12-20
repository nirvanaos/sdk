#cd nidl2cpp
build_dir="build-nidl2cpp"
dest_dir="distr"

if [[ "$OSTYPE" == "msys" ]]; then
cmake -B $build_dir -S nidl2cpp -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake -DVCPKG_HOST_TRIPLET=x64-mingw-dynamic
else
cmake -B $build_dir -S nidl2cpp -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
fi
cmake --build $build_dir --config Release
cmake --install $build_dir --config Release --prefix $dest_dir/host
#cd ..
