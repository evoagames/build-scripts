#!/bin/sh
if [ -z $1 ]; then
    echo "$0 VERSION"
    echo "    VERSION - boost version to build in form 1.XX.X. (e.g: 1.63.0)"
    exit 1
fi

if [ -z $2 ] ;then
    toolset=clang
else
    toolset=$2
fi

if [ "$toolset" = "clang" ] ;then
    without_libs="python,mpi,context,coroutine,coroutine2,fiber"
elif [ "$toolset" = "gcc" ] ;then
    without_libs="python,mpi"
else
    echo "Unexpected toolset '$toolset'"
    exit 1
fi

version=$1
echo "Working with boost version $version"
echo "Using toolset: $toolset"


. $PWD/boost-utils.sh
init_vars $version

downloadBoost
unpackBoost

aarch=aarch64-linux-gnu
jam_compile_flags=""

add_compile_flag() {
    jam_compile_flags="$jam_compile_flags <compileflags>$1"
}


if [ "$toolset" = "clang" ] ;then
    add_compile_flag -I/usr/${aarch}/include/c++/5/${aarch}
    add_compile_flag -I/usr/${aarch}/include
    cat > "$boost_src/tools/build/src/user-config.jam" <<EOF
using clang : 3.8
: clang++-3.8 --target=$aarch --gcc-toolchain=/usr -isysroot=/usr/$aarch
: <architecture>arm ${jam_compile_flags} <linkflags>-stdlib=libstdc++
;
EOF
else
    cat > "$boost_src/tools/build/src/user-config.jam" <<EOF
using gcc : arm
: ${aarch}-g++
: <architecture>arm ${jam_compile_flags}
;
EOF
fi

cd $boost_src

echo Start bootstrap ...

./bootstrap.sh --with-toolset=${toolset} --without-libraries=$without_libs
fail_abort "bootstrap failed"
doneSection

echo Start b2 ...

./b2 --prefix=$current_dir/__install/$version2 \
    --build-dir=$current_dir/__build/$version2 \
    toolset=$toolset                           \
    cxxflags="-std=c++11 -fPIC -pthread"       \
    link=shared                                \
    threading=multi                            \
    target-os=linux                            \
    abi=aapcs                                  \
    address-model=64                           \
    binary-format=elf                          \
    install -j6 
fail_abort "b2 failed"
doneSection

cd -
