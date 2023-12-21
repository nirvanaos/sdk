nidl2cpp = find_program(meson.source_root () + '/distr/host/bin/nidl2cpp', required: true)

subdir('library')
subdir('orb')

cust_targets = []

foreach f : orb_idl_no_ami
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-inc_cpp', '@CURRENT_SOURCE_DIR@/pch/pch.h',
			'-out_cpp', '@OUTDIR@',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : orb_idl
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-legacy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-inc_cpp', '@CURRENT_SOURCE_DIR@/pch/pch.h',
			'-out_cpp', '@OUTDIR@',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : orb_idl_hdr_only
	name = fs.name (f)
	custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : lib_idl
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-inc_cpp', '@CURRENT_SOURCE_DIR@/pch/pch.h',
			'-out_cpp', '@OUTDIR@',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : lib_idl_hdr_only
	name = fs.name (f)
	custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

# Includes

inc_dirs = include_directories('orb/Include', 'library/Include')

install_subdir ('orb/Include', 
	install_dir: 'include', strip_directory: true,
	exclude_files: 'CORBA/meson.build', install_tag: 'inc')

install_subdir ('library/Include',
 	install_dir: 'include', strip_directory: true,
	exclude_files: 'Nirvana/meson.build', exclude_directories: 'CRTL', install_tag: 'inc')

install_subdir ('library/Include/CRTL',
	install_dir: 'include', strip_directory: true,
	exclude_directories: 'impl', install_tag: 'inc')

# Build host libraries

host_libs = []
foreach platform, arch : host_platforms
	foreach config : configurations
		options = ['buildtype=' + config]
		cpp_args = arch ['cpp_args']

		nirvana = static_library ('host/' + platform + '/' + config + '/libnirvana',
			lib_src,
			orb_src,
			cust_targets,
			name_prefix: '',
			include_directories : inc_dirs,
			cpp_pch: ['pch/pch.h', 'pch/pch.cpp'],
			cpp_args : cpp_args,
			override_options: options,
			install: true,
			install_dir: 'host/' + platform + '/' + config,
			install_tag: 'host'
			)

		host_libs += nirvana

		mock = static_library ('host/' + platform + '/' + config + '/libmock',
			lib_mock,
			orb_mock,
			name_prefix: '',
			include_directories : inc_dirs,
			cpp_args : cpp_args,
			override_options: options,
			install: true,
			install_dir: 'host/' + platform + '/' + config,
			install_tag: 'host'
			)

		host_libs += mock

	endforeach
endforeach

# Build Nirvana libraries

foreach platform, arch : all_platforms
	foreach config : configurations
		options = ['buildtype=' + config]

		cpp_args = nirvana_cpp_opts + arch ['cpp_args']

		imports = static_library(platform + '/' + config + '/libimports',
			lib_import,
			orb_import,
			name_prefix: '',
			include_directories : [inc_dirs, sys_inc],
			cpp_args: cpp_args,
			override_options: options,
			install: true,
			install_dir: platform + '/' + config,
			install_tag: 'lib'
			)

		crtl = static_library(platform + '/' + config + '/libcrtl',
			crtl_src,
			name_prefix: '',
			include_directories : [inc_dirs, sys_inc],
			cpp_args: cpp_args,
			override_options: options,
			cpp_pch: ['library/CRTL/pch/pch.h', 'library/CRTL/pch/pch.cpp'],
			install: true,
			install_dir: platform + '/' + config,
			install_tag: 'lib'
			)

	endforeach
endforeach
