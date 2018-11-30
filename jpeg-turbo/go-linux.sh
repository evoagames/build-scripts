mkdir -p build_linux
pushd build_linux

export CC=clang
export CXX=clang++
#cmake -DCMAKE_C_FLAGS=-fPIC -DCMAKE_INSTALL_PREFIX=$PWD/__install -DCMAKE_CXX_FLAGS=-stdlib=libc++ ../src
cmake -DCMAKE_POSITION_INDEPENDENT_CODE=1 -DCMAKE_INSTALL_PREFIX=$PWD/__install  ../src

popd
