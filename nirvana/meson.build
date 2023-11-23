nidl2cpp = find_program('nidl2cpp', required: true)
idl = generator(nidl2cpp,
	output: ['@BASENAME@.cpp'],
	arguments: ['@INPUT@', '-no_proxy', '-legacy',
		'-I', meson.current_source_dir() + '/orb/Include',
		'-out_cpp', '@BUILD_DIR@'])

inc_dirs = include_directories('orb/include', 'library/include')
orb_sources=[]
subdir('orb')
library('nirvana', orb_sources, include_directories : inc_dirs)
