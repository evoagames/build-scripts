#!/bin/bash

if [ -z $1 ] ;then
    echo "Usage:"
    echo "    $0 gcc|clang"
else
    compiler=$1
fi

if [ "$compiler" == "clang" ] ;then
    toolchain=arm64-linux.toolchain.cmake
elif [ "$compiler" == "gcc" ] ;then
    toolchain=arm64-linux-gcc.toolchain.cmake
else
    echo "Unexpected compiler '$compiler'"
    exit 1
fi

echo Using toolchain: $toolchain

cwd=$PWD
mkdir -p build_linux_arm64
pushd build_linux_arm64

cmake -DCMAKE_TOOLCHAIN_FILE=$cwd/$toolchain \
      -DCMAKE_POSITION_INDEPENDENT_CODE=1                     \
      -DCMAKE_INSTALL_PREFIX=$cwd/__install                   \
      ../src

popd
