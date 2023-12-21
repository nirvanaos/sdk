nidl2cpp = find_program(meson.source_root () + '/distr/host/bin/nidl2cpp', required: true)
fs = import('fs')

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

foreach platform, arch : host_platforms
	foreach config : configurations
		options = ['buildtype=' + config]
		key = platform + '-' + config

		nirvana = static_library('host/' + platform + '/' + config + '/libnirvana',
			lib_src,
			orb_src,
			cust_targets,
			name_prefix: '',
			include_directories : inc_dirs,
			cpp_pch: ['pch/pch.h', 'pch/pch.cpp'],
			cpp_args : arch,
			override_options: options,
			install: true,
			install_dir: 'host/' + platform + '/' + config,
			install_tag: 'host'
			)

		mock = static_library('host/' + platform + '/' + config + '/libmock',
			lib_mock,
			orb_mock,
			name_prefix: '',
			include_directories : inc_dirs,
			cpp_args : arch,
			override_options: options,
			install: true,
			install_dir: 'host/' + platform + '/' + config,
			install_tag: 'host'
			)

	endforeach
endforeach

debug ('Test debug')
foreach key, lib : nirvana_lib_host
	debug ('Nirvana ', key)
endforeach

# Build Nirvana libraries

clang = find_program ('clang++')
clang64 = fs.parent (fs.parent (clang.full_path ()))
libc_inc = clang64 + '/include/c++/v1'
mingw64 = fs.parent (clang64) + '/mingw64'
clang_inc = mingw64 + '/lib/clang/17/include'

sys_inc = include_directories (libc_inc, clang_inc, 'library/Include/CRTL')

cpp_opts = ['-nostdinc', '-nostdinc++',
'-D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS',
'-D_LIBCPP_PROVIDES_DEFAULT_RUNE_TABLE',
'-D_LIBCPP_OBJECT_FORMAT_COFF',
'-fshort-wchar',
'-fsjlj-exceptions',
'-Wno-unused-function']

foreach platform, arch : all_platforms
	foreach config : configurations
		options = ['buildtype=' + config]

		imports = static_library(platform + '/' + config + '/libimports',
			lib_import,
			orb_import,
			name_prefix: '',
			include_directories : [inc_dirs, sys_inc],
			cpp_args: cpp_opts + arch,
			override_options: options,
			install: true,
			install_dir: platform + '/' + config,
			install_tag: 'lib'
			)

		crtl = static_library(platform + '/' + config + '/libcrtl',
			crtl_src,
			name_prefix: '',
			include_directories : [inc_dirs, sys_inc],
			cpp_args: cpp_opts + arch,
			override_options: options,
			cpp_pch: ['library/CRTL/pch/pch.h', 'library/CRTL/pch/pch.cpp'],
			install: true,
			install_dir: platform + '/' + config,
			install_tag: 'lib'
			)

	endforeach
endforeach
