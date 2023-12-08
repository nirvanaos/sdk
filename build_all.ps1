$sdk = "C:/nirvanasdk"

.\build.ps1 x64 debug $sdk
.\build.ps1 x64 release $sdk
.\build.ps1 x86 debug $sdk
.\build.ps1 x86 release $sdk
meson install -C build/x64/debug --tags inc --destdir $sdk
