nidl2cpp = find_program('nidl2cpp', required: true)
fs = import('fs')

lib_src = []
mock_src = []
subdir('library')
subdir('orb')

cust_targets = []

foreach f : orb_idl_no_ami
	name = fs.name (f)
	dir = fs.parent (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@CURRENT_SOURCE_DIR@/orb/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : [dir, dir, '@CURRENT_SOURCE_DIR@/orb/Source']
	)
endforeach

foreach f : orb_idl
	name = fs.name (f)
	dir = fs.parent (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-legacy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@CURRENT_SOURCE_DIR@/orb/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : [dir, dir, '@CURRENT_SOURCE_DIR@/orb/Source']
	)
endforeach

foreach f : orb_idl_hdr_only
	name = fs.name (f)
	dir = fs.parent (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h'],
		install : true,
		install_dir : [dir, dir]
	)
endforeach

foreach f : lib_idl
	name = fs.name (f)
	dir = fs.parent (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@CURRENT_SOURCE_DIR@/library/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : [dir, dir, '@CURRENT_SOURCE_DIR@/library/Source']
	)
endforeach

foreach f : lib_idl_hdr_only
	name = fs.name (f)
	dir = fs.parent (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h'],
		install : true,
		install_dir : [dir, dir]
	)
endforeach

inc_dirs = include_directories('orb/Include', 'library/Include')

nirvana = static_library('nirvana',
	lib_src,
# 	cust_targets,
  include_directories : inc_dirs)

mock = static_library('mock',
	mock_src,
  include_directories : inc_dirs)
