$destdir = "$PSScriptRoot\distr"

.\build.ps1 x64 debug $destdir
.\build.ps1 x64 release $destdir
#.\build.ps1 x86 debug $sdk
#.\build.ps1 x86 release $sdk
meson install -C build --tags inc --destdir $destdir
