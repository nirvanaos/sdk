project ('sdk_test', 'cpp',
	default_options: [
		'cpp_std=c++17',
		'c_std=c11',
		'b_ndebug=if-release', 
		'default_library=static',
		'prefer_static=true',
		'cpp_debugstl=true',
		'cpp_link_args=-static'
	]
)

sdk = subproject ('sdk')

subdir ('hello_world')
