test_inc_dirs = [inc_dirs, include_directories('googletest/googletest/include')]

googletest = static_library('googletest',
	'googletest/googletest/src/gtest-all.cc',
	'googletest/googletest/src/gtest_main.cc',
	include_directories : [test_inc_dirs, include_directories('googletest/googletest')],
	cpp_args: '--include=Nirvana/Nirvana.h'
)