#!/bin/sh
if ! cd boost_1_68_0/
then
    echo Boost directory not found.
    exit 1
fi

./bootstrap.sh --with-toolset=clang &&                        \
./b2 --prefix=$PWD/__install                                  \
    --build-dir=$PWD/__build                                  \
    toolset=clang                                             \
    cxxflags="-stdlib=libc++ -I /usr/include/libcxxabi -fPIC" \
    linkflags="-stdlib=libc++"                                \
    link=static                                               \
    threading=multi                                           \
    install -j6 

#`./bootstrap.sh' prepares Boost for building on a few kinds of systems.
#
#Usage: ./bootstrap.sh [OPTION]... 
#
#Defaults for the options are specified in brackets.
#
#Configuration:
#  -h, --help                display this help and exit
#  --with-bjam=BJAM          use existing Boost.Jam executable (bjam)
#                            [automatically built]
#  --with-toolset=TOOLSET    use specific Boost.Build toolset
#                            [automatically detected]
#  --show-libraries          show the set of libraries that require build
#                            and installation steps (i.e., those libraries
#                            that can be used with --with-libraries or
#                            --without-libraries), then exit
#  --with-libraries=list     build only a particular set of libraries,
#                            describing using either a comma-separated list of
#                            library names or "all"
#                            [all]
#  --without-libraries=list  build all libraries except the ones listed []
#  --with-icu                enable Unicode/ICU support in Regex 
#                            [automatically detected]
#  --without-icu             disable Unicode/ICU support in Regex
#  --with-icu=DIR            specify the root of the ICU library installation
#                            and enable Unicode/ICU support in Regex
#                            [automatically detected]
#  --with-python=PYTHON      specify the Python executable [python]
#  --with-python-root=DIR    specify the root of the Python installation
#                            [automatically detected]
#  --with-python-version=X.Y specify the Python version as X.Y
#                            [automatically detected]
#
#Installation directories:
#  --prefix=PREFIX           install Boost into the given PREFIX
#                            [/usr/local]
#  --exec-prefix=EPREFIX     install Boost binaries into the given EPREFIX
#                            [PREFIX]
#
#More precise control over installation directories:
#  --libdir=DIR              install libraries here [EPREFIX/lib]
#  --includedir=DIR          install headers here [PREFIX/include]
#

#=======================================================================

# Boost.Build 2018.02-git
# 
# Project-specific help:
# 
#   Project has jamfile at Jamroot
# 
# Usage:
# 
#   b2 [options] [properties] [install|stage]
# 
#   Builds and installs Boost.
# 
# Targets and Related Options:
# 
#   install                 Install headers and compiled library files to the
#   =======                 configured locations (below).
# 
#   --prefix=<PREFIX>       Install architecture independent files here.
#                           Default; C:\Boost on Win32
#                           Default; /usr/local on Unix. Linux, etc.
# 
#   --exec-prefix=<EPREFIX> Install architecture dependent files here.
#                           Default; <PREFIX>
# 
#   --libdir=<DIR>          Install library files here.
#                           Default; <EPREFIX>/lib
# 
#   --includedir=<HDRDIR>   Install header files here.
#                           Default; <PREFIX>/include
# 
#   stage                   Build and install only compiled library files to the
#   =====                   stage directory.
# 
#   --stagedir=<STAGEDIR>   Install library files here
#                           Default; ./stage
# 
# Other Options:
# 
#   --build-type=<type>     Build the specified pre-defined set of variations of
#                           the libraries. Note, that which variants get built
#                           depends on what each library supports.
# 
#                               -- minimal -- (default) Builds a minimal set of
#                               variants. On Windows, these are static
#                               multithreaded libraries in debug and release
#                               modes, using shared runtime. On Linux, these are
#                               static and shared multithreaded libraries in
#                               release mode.
# 
#                               -- complete -- Build all possible variations.
# 
#   --build-dir=DIR         Build in this location instead of building within
#                           the distribution tree. Recommended!
# 
#   --show-libraries        Display the list of Boost libraries that require
#                           build and installation steps, and then exit.
# 
#   --layout=<layout>       Determine whether to choose library names and header
#                           locations such that multiple versions of Boost or
#                           multiple compilers can be used on the same system.
# 
#                               -- versioned -- Names of boost binaries include
#                               the Boost version number, name and version of
#                               the compiler and encoded build properties. Boost
#                               headers are installed in a subdirectory of
#                               <HDRDIR> whose name contains the Boost version
#                               number.
# 
#                               -- tagged -- Names of boost binaries include the
#                               encoded build properties such as variant and
#                               threading, but do not including compiler name
#                               and version, or Boost version. This option is
#                               useful if you build several variants of Boost,
#                               using the same compiler.
# 
#                               -- system -- Binaries names do not include the
#                               Boost version number or the name and version
#                               number of the compiler. Boost headers are
#                               installed directly into <HDRDIR>. This option is
#                               intended for system integrators building
#                               distribution packages.
# 
#                           The default value is 'versioned' on Windows, and
#                           'system' on Unix.
# 
#   --buildid=ID            Add the specified ID to the name of built libraries.
#                           The default is to not add anything.
# 
#   --python-buildid=ID     Add the specified ID to the name of built libraries
#                           that depend on Python. The default is to not add
#                           anything. This ID is added in addition to --buildid.
# 
#   --help                  This message.
# 
#   --with-<library>        Build and install the specified <library>. If this
#                           option is used, only libraries specified using this
#                           option will be built.
# 
#   --without-<library>     Do not build, stage, or install the specified
#                           <library>. By default, all libraries are built.
# 
# Properties:
# 
#   toolset=toolset         Indicate the toolset to build with.
# 
#   variant=debug|release   Select the build variant
# 
#   link=static|shared      Whether to build static or shared libraries
# 
#   threading=single|multi  Whether to build single or multithreaded binaries
# 
#   runtime-link=static|shared
#                           Whether to link to static or shared C and C++
#                           runtime.
# 
# 
# General command line usage:
# 
#     b2 [options] [properties] [targets]
# 
#   Options, properties and targets can be specified in any order.
#       
# Important Options:
# 
#   * --clean Remove targets instead of building
#   * -a Rebuild everything
#   * -n Don't execute the commands, only print them
#   * -d+2 Show commands as they are executed
#   * -d0 Suppress all informational messages
#   * -q Stop at first error
#   * --reconfigure Rerun all configuration checks
#   * --debug-configuration Diagnose configuration
#   * --debug-building Report which targets are built with what properties
#   * --debug-generator Diagnose generator search/execution
# 
# Further Help:
# 
#   The following options can be used to obtain additional documentation.
# 
#   * --help-options Print more obscure command line options.
#   * --help-internal Boost.Build implementation details.
#   * --help-doc-options Implementation details doc formatting.
# 
# ...found 1 target...
