test_inc_dirs = [inc_dirs, include_directories('googletest/googletest/include')]

googletest_host = static_library('googletest_host',
	'googletest/googletest/src/gtest-all.cc',
	'googletest/googletest/src/gtest_main.cc',
	include_directories : [test_inc_dirs, include_directories('googletest/googletest')],
	cpp_args: '--include=Nirvana/Nirvana.h',
	install: true,
	install_tag: 'host',
	install_dir: '.'
)