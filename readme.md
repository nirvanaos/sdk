# Nirvana SDK

### Content

This repository is Git superproject for building the Nirvana SDK.

## Dependencies

### [Meson](https://mesonbuild.com/) + Ninja

Ninja usually included in the Meson installation.

### [CMake](https://cmake.org/)

### [vcpkg](https://vcpkg.io/)

### [MSYS2](https://www.msys2.org/)

Install following MSYS2 packages:

mingw-w64-clang-x86_64-toolchain
mingw-w64-clang-i686-toolchain

Copy `libclang_rt.builtins-i386.a` from "C:\msys64\clang32\lib\clang\17\lib\windows"
to "C:\msys64\clang64\lib\clang\17\lib\windows".
This fix CLang cross-compilation problem that may be will solved in the further versions.

Use MSYS2 CLANG64 environment.

## Submodules

### googletest/[googletest](https://github.com/google/googletest.git)

Google test framework.

### nirvana/[library](https://github.com/nirvanaos/library.git)

Nirvana runtime library.

### nirvana/[orb](https://github.com/nirvanaos/orb.git)

Nirvana ORB IDL support library.

### [llvm-project](https://github.com/llvm/llvm-project.git)

### [nidl2cpp](https://github.com/nirvanaos/nidl2cpp)

Nirvana IDL compiler.
