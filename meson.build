project('sdk', 'cpp',
	default_options: [
		'cpp_std=c++17',
		'b_ndebug=if-release', 
		'default_library=static',
		'prefer_static=true',
		'cpp_debugstl=true',
		'cpp_link_args=-static'
	]
)
add_project_arguments('-stdlib=libc++', '-static', language: 'cpp')
subdir('nirvana')
subdir('googletest')
subdir('nirvana/library/Test')
