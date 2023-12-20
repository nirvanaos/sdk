test_inc_dirs = [inc_dirs, include_directories('googletest/googletest/include')]

# Build host libraries
googletest_lib_host = {}
foreach platform, arch : host_platforms
	foreach config : configurations
		options = ['buildtype=' + config]

		googletest = static_library('host/' + platform + '/' + config + '/libgoogletest',
			'googletest/googletest/src/gtest-all.cc',
			'googletest/googletest/src/gtest_main.cc',
			include_directories : [test_inc_dirs, include_directories('googletest/googletest')],
			override_options: options,
			install: true,
			install_tag: 'host',
			install_dir: 'host/' + platform + '/' + config,
			)

		googletest_lib_host += {platform + '-' + config : googletest}

	endforeach
endforeach

# Build Nirvana libraries
foreach platform, arch : all_platforms
	foreach config : configurations
		options = ['buildtype=' + config]

		googletest = static_library(platform + '/' + config + '/libgoogletest',
			'googletest/googletest/src/gtest-all.cc',
			'googletest/googletest/src/gtest_main.cc',
			include_directories : [test_inc_dirs, sys_inc, include_directories('googletest/googletest')],
			cpp_args: cpp_opts + arch + ['-DGTEST_HAS_POSIX_RE=0', '-DGTEST_HAS_SEH=0'],
			override_options: options,
			install: true,
			install_tag: 'host',
			install_dir: platform + '/' + config,
			)

	endforeach
endforeach
