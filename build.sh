if [[ $# -ge 1 ]]; then
	platform=$1
else
	platform="x64"
fi

if [[ $# -ge 2 ]]; then
	config=$2
else
	config="debug"
fi

dest_dir="$PWD/distr"
build_dir="build"

rm -rf $build_dir
mkdir $build_dir

meson setup --buildtype=$config --native-file=meson_$platform.ini $build_dir
#meson compile -C $build_dir
meson test -C $build_dir
meson install -C $build_dir --tags host --destdir $dest_dir/host/$platform/$config
meson install -C $build_dir --tags lib --destdir $dest_dir/$platform/$config

./build_libc.sh $platform $config
