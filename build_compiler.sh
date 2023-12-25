build_dir="build-nidl2cpp"
dest_dir="sdk"

host_system=$OSTYPE
if [[ $host_system == "msys" ]]; then
host_system="windows"
fi

cmake -B $build_dir -S nidl2cpp
cmake --build $build_dir --config Debug
cmake --install $build_dir --config Debug --prefix $dest_dir/$host_system
