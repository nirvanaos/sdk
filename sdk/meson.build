project ('sdk', 'cpp')

nidl2cpp = find_program (build_machine.system () + '/bin/nidl2cpp')

idl_full = generator (nidl2cpp,
	output: [ '@BASENAME@.h', '@BASENAME@_s.h', '@BASENAME@.cpp', '@BASENAME@_p.cpp' ],
	arguments: [ '@INPUT@',
		'-out', '@BUILD_DIR@',
		'-I', meson.current_source_dir () + '/include'
	 	]
	)

idl_client = generator (nidl2cpp,
	output: [ '@BASENAME@.h', '@BASENAME@.cpp' ],
	arguments: [ '@INPUT@',
		'-out', '@BUILD_DIR@',
		'-client',
		'-I', meson.current_source_dir () + '/include'
	 	]
	)

compiler = meson.get_compiler ('cpp')
if compiler.get_id () != 'clang'
	error ('Compiler must be CLang')
endif

clang_ver = compiler.version ().split('.')[0]

fs = import('fs')

clang = find_program ('clang++')
msys64 = fs.parent (fs.parent (fs.parent (clang.full_path ())))
clang64 = msys64 + '/clang64'
clang32 = msys64 + '/clang32'

libc_inc = clang64 + '/include/c++/v1'
mingw64 = fs.parent (clang64) + '/mingw64'
clang_inc = mingw64 + '/lib/clang/' + clang_ver + '/include'

sys_inc = include_directories (libc_inc, clang_inc, 'include')

# Map platform name to CLang architecture

platforms = {
	'x64': {
		'cpp_args' : ['--target=x86_64-pc-none-eabi', '-mlzcnt']
	},
	'x86': {
		'cpp_args' : ['--target=i686-pc-none-eabi']
	}
}

nirvana_cpp_opts = ['-nostdinc', '-nostdinc++',
	'-D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS',
	'-D_LIBCPP_PROVIDES_DEFAULT_RUNE_TABLE',
	'-D_LIBCPP_OBJECT_FORMAT_COFF',
	'-fshort-wchar',
	'-fsjlj-exceptions',
	'-Wno-unused-function'
]

sdk_dep = declare_dependency (
	include_directories: sys_inc,
	compile_args : platforms ['x64']['cpp_args']
)

meson.override_dependency ('sdk', sdk_dep)
