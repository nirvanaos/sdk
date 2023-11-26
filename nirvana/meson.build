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
			'-out_cpp', '@CURRENT_SOURCE_DIR@/orb/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : ['@CURRENT_SOURCE_DIR@/orb/Include/CORBA', '@CURRENT_SOURCE_DIR@/orb/Include/CORBA', '@CURRENT_SOURCE_DIR@/orb/Source']
	)
endforeach

foreach f : orb_idl
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-legacy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@CURRENT_SOURCE_DIR@/orb/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : ['@CURRENT_SOURCE_DIR@/orb/Include/CORBA', '@CURRENT_SOURCE_DIR@/orb/Include/CORBA', '@CURRENT_SOURCE_DIR@/orb/Source']
	)
endforeach

foreach f : orb_idl_hdr_only
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h'],
		install : true,
		install_dir : ['@CURRENT_SOURCE_DIR@/orb/Include/CORBA', '@CURRENT_SOURCE_DIR@/orb/Include/CORBA']
	)
endforeach

foreach f : lib_idl
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'-out_cpp', '@CURRENT_SOURCE_DIR@/library/Source',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h', 	fs.replace_suffix (name, '.cpp')],
		install : true,
		install_dir : ['@CURRENT_SOURCE_DIR@/library/Include/Nirvana', '@CURRENT_SOURCE_DIR@/library/Include/Nirvana', '@CURRENT_SOURCE_DIR@/library/Source']
	)
endforeach

foreach f : lib_idl_hdr_only
	name = fs.name (f)
	cust_targets += custom_target (name,
		input : f,
		command : [nidl2cpp, '-no_proxy', '-no_ami', '-no_client_cpp',
			'-I', '@CURRENT_SOURCE_DIR@/orb/Include',
			'-I', '@CURRENT_SOURCE_DIR@/library/Include',
			'@INPUT@'],
		output : [fs.replace_suffix (name, '.h'), fs.replace_suffix (name, '') + '_s.h'],
		install : true,
		install_dir : ['@CURRENT_SOURCE_DIR@/library/Include/Nirvana', '@CURRENT_SOURCE_DIR@/library/Include/Nirvana']
	)
endforeach

inc_dirs = include_directories('orb/Include', 'library/Include')

library('nirvana',
	lib_src,
	orb_src,
# 	cust_targets,
  include_directories : inc_dirs)
