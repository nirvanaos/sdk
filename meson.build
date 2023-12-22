project('sdk', 'cpp',
	default_options: [
		'cpp_std=c++17',
		'b_ndebug=if-release', 
		'default_library=static',
		'prefer_static=true',
		'cpp_debugstl=true',
		'cpp_link_args=-static',
		'bindir=' + 'c:/msys64/clang32/bin'
	]
)

fs = import('fs')

clang = find_program ('clang++')
msys64 = fs.parent (fs.parent (fs.parent (clang.full_path ())))
clang64 = msys64 + '/clang64'
clang32 = msys64 + '/clang32'

libc_inc = clang64 + '/include/c++/v1'
mingw64 = fs.parent (clang64) + '/mingw64'
clang_inc = mingw64 + '/lib/clang/17/include'

sys_inc = include_directories (libc_inc, clang_inc, 'nirvana/library/Include/CRTL')

# Map platform name to CLang architecture
host_platforms = {
	'x64': {
		'cpp_args' : ['--target=x86_64-w64-windows-gnu', '-mlzcnt'],
		'link_args' : ['--sysroot=' + clang64]
	},
	'x86': {
		'cpp_args' : ['--target=i686-windows-gnu'],
		'link_args' : ['-m32', '--sysroot=' + clang32]
	}
}

all_platforms = {
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
'-Wno-unused-function']

#add_project_arguments('-stdlib=libc++', '-static', language: 'cpp')
subdir ('nirvana')
subdir ('googletest')
subdir ('nirvana/library/Test')
