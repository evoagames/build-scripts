#!/bin/bash

if [ -z $1 ] ;then
    echo "Usage:"
    echo "    $0 gcc|clang"
    exit 0
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
build_dir=build_linux_arm64
mkdir -p $build_dir
pushd $build_dir

cmake -DCMAKE_TOOLCHAIN_FILE=$cwd/$toolchain \
      -DCMAKE_POSITION_INDEPENDENT_CODE=1                     \
      -DCMAKE_INSTALL_PREFIX=$cwd/$build_dir/__install                   \
      ../src

popd
