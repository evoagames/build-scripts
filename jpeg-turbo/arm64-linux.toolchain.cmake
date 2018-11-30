# For cross-compiling on arm64 Linux using gcc-aarch64-linux-gnu package:
# - install aarch64 tool chain:
#   $ sudo apt-get install g++-aarch64-linux-gnu gcc-aarch64-linux-gnu

set(CMAKE_SYSTEM_NAME "Linux")
set(CMAKE_SYSTEM_PROCESSOR "aarch64")

#set(CMAKE_SYSROOT /usr/aarch64-linux-gnu)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_CXX_FLAGS "-stdlib=libstdc++")
set(CMAKE_CXX_STANDARD 11)

set(MY_COMPILER_TARGET aarch64-linux-gnu)
set(MY_TOOLCHAIN_ROOT  /usr)

# Clang can fail to compile if CMake doesn't correctly supply the target and
# external toolchain, but to do so, CMake needs to already know that the
# compiler is clang. Tell CMake that the compiler is really clang, but don't
# use CMakeForceCompiler, since we still want compile checks. We only want
# to skip the compiler ID detection step.
set(CMAKE_C_COMPILER_ID_RUN TRUE)
set(CMAKE_CXX_COMPILER_ID_RUN TRUE)
set(CMAKE_C_COMPILER_ID Clang)
set(CMAKE_CXX_COMPILER_ID Clang)
set(CMAKE_C_COMPILER_VERSION 3.8)
set(CMAKE_CXX_COMPILER_VERSION 3.8)
set(CMAKE_C_STANDARD_COMPUTED_DEFAULT 11)
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT 98)
set(CMAKE_C_COMPILER_TARGET   ${MY_COMPILER_TARGET})
set(CMAKE_CXX_COMPILER_TARGET ${MY_COMPILER_TARGET})
set(CMAKE_ASM_COMPILER_TARGET ${MY_COMPILER_TARGET})
set(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN   "${MY_TOOLCHAIN_ROOT}")
set(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN "${MY_TOOLCHAIN_ROOT}")
set(CMAKE_ASM_COMPILER_EXTERNAL_TOOLCHAIN "${MY_TOOLCHAIN_ROOT}")

set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES
    ${MY_TOOLCHAIN_ROOT}/${MY_COMPILER_TARGET}/include
    )
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES
    ${MY_TOOLCHAIN_ROOT}/${MY_COMPILER_TARGET}/include/c++/5
    ${MY_TOOLCHAIN_ROOT}/${MY_COMPILER_TARGET}/include/c++/5/${MY_COMPILER_TARGET}
    )

set(CMAKE_C_COMPILER /home/user/tmp/cc/cross/ccc)
set(CMAKE_CXX_COMPILER /home/user/tmp/cc/cross/ccc++)

