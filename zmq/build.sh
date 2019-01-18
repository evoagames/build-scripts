#!/bin/sh
if [ -z $1 ]; then
    echo "$0 VERSION"
    echo "    VERSION - zmq version to build in form X.X.X. (e.g: 4.2.5)"
    exit 1
fi

. ${PWD}/zmq-utils.sh

init_vars $1
unpack_zmq

cd $build_dir
./configure --prefix=$cache_dir/__install --host=aarch64-linux-gnu CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ CXXFLAGS="-std=c++11 -fPIC" LDFLAGS="-fPIC"
cd -
