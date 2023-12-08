nidl2cpp = find_program('nidl2cpp', required: true)
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
			'-inc_cpp', '../../pch/pch.h',
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
			'-inc_cpp', '../../pch/pch.h',
			'-out_cpp', '@OUTDIR@',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : orb_idl_hdr_only
	name = fs.name (f)
	custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
		
		#build_always_stale: true,
		#build_by_default: true
	)
endforeach

foreach f : lib_idl
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@OUTDIR@',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
	)
endforeach

foreach f : lib_idl_hdr_only
	name = fs.name (f)
	custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : fs.replace_suffix (name, '.cpp')
		
		#build_always_stale: true,
		#build_by_default: true
	)
endforeach

inc_dirs = include_directories('orb/Include', 'library/Include')

install_subdir ('orb/Include', install_dir: '.', exclude_files: 'CORBA/meson.build', install_tag: 'inc')
install_subdir ('library/Include', install_dir: '.', exclude_files: 'Nirvana/meson.build', exclude_directories: 'CRTL', install_tag: 'inc')

nirvana = static_library('nirvana',
	lib_src,
	orb_src,
 	cust_targets,
  include_directories : inc_dirs,
	cpp_pch: ['pch/pch.h', 'pch/pch.cpp'],
	install: true,
	install_tag: 'lib',
	install_dir: '.'
	)

mock = static_library('mock',
	lib_mock,
	orb_mock,
  include_directories : inc_dirs)

crtl = static_library('crtl',
	crtl_src,
  include_directories : inc_dirs)
