#===============================================================================
# Functions for ZMQ builders
#===============================================================================

print_var()
{
    v=$1
    eval v=\$$v
    echo ${1} = $v
}

print_vars()
{
    for i in $@
    do
        print_var $i
    done
}

abort()
{
    echo
    echo "Aborted: $@"
    exit 1
}

fail_abort()
{
    if [ $? != 0 ]; then
        abort $@
    fi
}

die()
{
    exit 1
}

doneSection()
{
    echo
    echo "Done ${1}"
    echo "================================================================="
    echo
}

#===============================================================================

init_vars()
{
    version=${1}
    version2="$(echo "${version}" | sed 's/\./_/g')"
    current_dir="$PWD"
    cache_dir="$current_dir/cache"
    src_dir="$cache_dir/src"
    build_dir="$src_dir/zeromq-${version}"
    zmq_tarball="zeromq-${version}.tar.gz"

    print_vars current_dir version version2 zmq_tarball src_dir build_dir
    doneSection "Init vars"
}

#===============================================================================

unpack_zmq()
{
    tarball=${cache_dir}/${zmq_tarball}
    [ -f "$tarball" ] || abort "ZMQ tarball missing. Download from http://zeromq.org/area:download."

    echo Unpacking $zmq_tarball into "$src_dir"...

    [ -d "$src_dir" ]   || mkdir -p "$src_dir"
    [ -d "$src_dir" ]   || ( cd "$src_dir"; tar xzf "$tarball" )
    [ -d "$build_dir" ] && echo "    ...unpacked as $build_dir"

    doneSection "unpack ZMQ"
}
