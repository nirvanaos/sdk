host_system = build_machine.system ()
nidl2cpp = find_program (meson.source_root () + '/sdk/' + host_system + '/bin/nidl2cpp', required: true)

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

inc_dirs = include_directories ('orb/Include', 'library/Include')

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

host_libs = {}
foreach platform, arch : host_platforms
	cpp_args = arch ['cpp_args']

	nirvana = static_library ('nirvana-' + platform + '-' + host_system,
		lib_src,
		orb_src,
		cust_targets,
		include_directories : inc_dirs,
		cpp_pch: ['pch/pch.h', 'pch/pch.cpp'],
		cpp_args : cpp_args,
		install: true,
		install_dir: host_system + '/' + get_option ('buildtype'),
		install_tag: 'host'
		)

	mock = static_library ('mock-' + platform + '-' + host_system,
		lib_mock,
		orb_mock,
		include_directories : inc_dirs,
		cpp_args : cpp_args,
		install: true,
		install_dir: host_system + '/' + get_option ('buildtype'),
		install_tag: 'host'
		)

	host_libs += { platform: [nirvana, mock] }

endforeach

# Build Nirvana libraries

foreach platform, arch : all_platforms
	cpp_args = nirvana_cpp_opts + arch ['cpp_args']

	nirvana = static_library ('nirvana-' + platform,
		lib_src,
		orb_src,
		cust_targets,
		include_directories : [inc_dirs, sys_inc],
		cpp_pch: ['pch/pch.h', 'pch/pch.cpp'],
		cpp_args : cpp_args,
		install: true,
		install_dir: get_option ('buildtype'),
		install_tag: 'lib'
		)

	imports = static_library ('imports-' + platform,
		lib_import,
		orb_import,
		include_directories : [inc_dirs, sys_inc],
		cpp_args: cpp_args,
		install: true,
		install_dir: get_option ('buildtype'),
		install_tag: 'lib'
		)

	crtl = static_library('crtl-' + platform,
		crtl_src,
		include_directories : [inc_dirs, sys_inc],
		cpp_args: cpp_args,
		cpp_pch: ['library/CRTL/pch/pch.h', 'library/CRTL/pch/pch.cpp'],
		install: true,
		install_dir: get_option ('buildtype'),
		install_tag: 'lib'
		)

endforeach
