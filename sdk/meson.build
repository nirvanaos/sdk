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

host_platforms = { 'windows':
	{
		'x64': {
			'cpp_args' : ['--target=x86_64-w64-windows-gnu', '-mlzcnt'],
			'link_args' : ['--sysroot=' + clang64]
		},
		'x86': {
			'cpp_args' : ['--target=i686-w64-windows-gnu'],
			'link_args' : ['-m32', '--sysroot=' + clang32]
		}
	}
}

all_platforms = {
	'x64': {
		'cpp_args' : [
#			'--target=x86_64-pc-none-eabi',
			'--target=x86_64-w64-windows-gnu', '-U_WIN32', '-U__MINGW32__', '-U__MINGW64__',
			'-mlzcnt'],
		'link_args' : ['-nodefaultlibs', '-m64']
	}
#	,
#	'x86': {
#		'cpp_args' : ['--target=i686-pc-none-eabi'],
#		'link_args' : ['-m32']
#	}
}

# C++ options to build Nirvana binaries
nirvana_cpp_opts = ['-nostdinc', '-nostdinc++',
	'-D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS',
	'-D_LIBCPP_PROVIDES_DEFAULT_RUNE_TABLE',
	'-D_LIBCPP_OBJECT_FORMAT_COFF',
	'-fshort-wchar',
	'-fsjlj-exceptions',
	'-Wno-unused-function'
]

lib_dir = meson.current_source_dir () + '/' + get_option ('buildtype')
libraries = ['nirvana', 'imports', 'crtl', 'googletest', 'llvmlibc']

sdk_deps = {}
foreach platform, arch : all_platforms
	platform_deps = []
	foreach lib : libraries
		platform_deps += compiler.find_library (lib + '-' + platform, dirs: lib_dir)
	endforeach
	dep = declare_dependency (
		include_directories: sys_inc,
		compile_args : nirvana_cpp_opts + all_platforms [platform]['cpp_args'],
		link_args : all_platforms [platform]['link_args'],
		dependencies: platform_deps
	)
	sdk_deps += {platform: dep}
endforeach

#meson.override_dependency ('sdk', sdk_dep)
