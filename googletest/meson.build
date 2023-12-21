test_inc_dirs = [inc_dirs, include_directories('googletest/googletest/include')]

# Build host libraries
foreach platform, arch : host_platforms
	foreach config : configurations
		options = ['buildtype=' + config]
		cpp_args = arch ['cpp_args'] + ['-includeNirvana/Nirvana.h']

		googletest = static_library('host/' + platform + '/' + config + '/libgoogletest',
			'googletest/googletest/src/gtest-all.cc',
			'googletest/googletest/src/gtest_main.cc',
			name_prefix: '',
			include_directories : [test_inc_dirs, include_directories('googletest/googletest')],
			override_options: options,
			cpp_args: cpp_args,
			install: true,
			install_tag: 'host',
			install_dir: 'host/' + platform + '/' + config,
			)

		host_libs += googletest

	endforeach
endforeach

# Build Nirvana libraries
foreach platform, arch : all_platforms
	foreach config : configurations
		options = ['buildtype=' + config]
		cpp_args = nirvana_cpp_opts + arch ['cpp_args'] + [
				'-includeNirvana/Nirvana.h',
				'-DGTEST_HAS_POSIX_RE=0',
				'-DGTEST_HAS_SEH=0']

		googletest = static_library(platform + '/' + config + '/libgoogletest',
			'googletest/googletest/src/gtest-all.cc',
			'googletest/googletest/src/gtest_main.cc',
			name_prefix: '',
			include_directories : [test_inc_dirs, sys_inc, include_directories('googletest/googletest')],
			cpp_args: cpp_args,
			override_options: options,
			install: true,
			install_tag: 'host',
			install_dir: platform + '/' + config,
			)

	endforeach
endforeach