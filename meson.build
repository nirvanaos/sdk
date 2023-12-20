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

# Map platform name to CLang architecture
host_platforms = {
	'x64': ['--target=x86_64-w64-windows-gnu'],
	'x86': ['--target=i686-windows-gnu']
	}

all_platforms = {
	'x64': ['--target=x86_64-pc-none-eabi'],
	'x86': ['--target=i686-pc-none-eabi']
	}

configurations = ['debug', 'release']

#add_project_arguments('-stdlib=libc++', '-static', language: 'cpp')
subdir ('nirvana')
subdir ('googletest')
#subdir('nirvana/library/Test')
