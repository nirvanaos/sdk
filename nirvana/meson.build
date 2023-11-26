nidl2cpp = find_program('nidl2cpp', required: true)
idl = generator(nidl2cpp,
	output: ['@BASENAME@.cpp'],
	arguments: ['@INPUT@', '-no_proxy', '-legacy',
		'-I', meson.current_source_dir() + '/orb/Include',
		'-I', meson.current_source_dir() + '/library/Include',
		'-out_cpp', '@BUILD_DIR@'])

inc_dirs = include_directories('orb/Include', 'library/Include')
subdir('library')
subdir('orb')
library('nirvana',
	lib_src,
	orb_src,
 	lib_idl,
	orb_idl,
  include_directories : inc_dirs)
