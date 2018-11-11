#!/bin/bash

# Set these variables to suit your needs
NDK_PATH=/home/user/android/ndk/r14b
if [ -z $1 ] ;then
    echo $(basename $0) ANDROID_ABI
    echo ANDROID_ABI can be one of: armeabi-v7a, arm64-v8a
    exit 1
fi

ANDROID_ABI=$1

export LDFLAGS=-pie

mkdir -p build_android
pushd build_android

cat <<EOF >toolchain.cmake
set(ANDROID_TOOLCHAIN clang)
set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION \${ANDROID_TOOLCHAIN})
set(ANDROID_ABI $ANDROID_ABI)
set(ANDROID_NATIVE_API_LEVEL 19)
set(ANDROID_STL c++_shared)
include("${NDK_PATH}/build/cmake/android.toolchain.cmake")
EOF

cmake -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake \
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
    -DCMAKE_INSTALL_PREFIX=$PWD/__install \
    -G"Unix Makefiles" \
    ../libjpeg-turbo

popd

