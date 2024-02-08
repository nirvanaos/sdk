build_dir="build-test"

if [[ $# -ge 1 ]]; then
	config=$1
else
	config="debug"
fi

set -e

export CXX_LD="$PWD/sdk/windows/bin/ld.lld"
meson setup $build_dir "test" --reconfigure --buildtype $config
meson compile -C $build_dir
#meson test -C $build_dir
