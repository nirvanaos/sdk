test_inc_dirs = [inc_dirs, include_directories('googletest/googletest/include')]

# Build host libraries
foreach platform, arch : host_platforms
	cpp_args = arch ['cpp_args'] + ['-includeNirvana/Nirvana.h']

	googletest = static_library('googletest-' + platform + '-' + host_system,
		'googletest/googletest/src/gtest-all.cc',
		'googletest/googletest/src/gtest_main.cc',
		include_directories : [test_inc_dirs, include_directories ('googletest/googletest')],
		cpp_args: cpp_args,
		install: true,
		install_tag: 'host',
		install_dir: host_system + '/' + get_option ('buildtype'),
		)

	host_libs += {platform: host_libs [platform] + googletest}

endforeach

# Build Nirvana libraries
foreach platform, arch : all_platforms
	cpp_args = nirvana_cpp_opts + arch ['cpp_args'] + [
			'-includeNirvana/Nirvana.h',
			'-DGTEST_HAS_POSIX_RE=0',
			'-DGTEST_HAS_SEH=0']

	googletest = static_library ('googletest-' + platform,
		'googletest/googletest/src/gtest-all.cc',
		'googletest/googletest/src/gtest_main.cc',
		include_directories : [test_inc_dirs, sys_inc, include_directories('googletest/googletest')],
		cpp_args: cpp_args,
		install: true,
		install_tag: 'lib',
		install_dir: get_option ('buildtype'),
		)

endforeach