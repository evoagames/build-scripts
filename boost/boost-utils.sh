#===============================================================================
# Functions for boost builders
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

missingParameter()
{
    echo $1 requires a parameter
    die
}

unknownParameter()
{
    if [ -n $2 ]; then
        echo Unknown argument \"$2\" for parameter $1.
    else
        echo Unknown argument $1
    fi
    die
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
    current_dir=$PWD
    version2="$(echo "${1}" | sed 's/\./_/g')"
    boost_tarball="boost_${version2}.tar.bz2"
    src_dir="$current_dir/src"
    boost_src="$src_dir/boost_${version2}"

    print_vars current_dir version2 boost_tarball src_dir boost_src
    doneSection
}

#===============================================================================

downloadBoost()
{
    if [ ! -s "$boost_tarball" ]; then
        echo "Downloading boost ${BOOST_VERSION}"
        download_url="http://sourceforge.net/projects/boost/files/boost/${version}/${boost_tarball}/download"
        wget --no-check-certificate "$download_url" -O $boost_tarball
        doneSection
    fi
}

#===============================================================================

unpackBoost()
{
    [ -f "$boost_tarball" ] || abort "Source tarball missing."

    echo Unpacking boost into "$src_dir"...

    [ -d "$src_dir" ]   || mkdir -p "$src_dir"
    [ -d "$boost_src" ] || ( cd "$src_dir"; tar xjf "$current_dir/$boost_tarball" )
    [ -d "$boost_src" ] && echo "    ...unpacked as $boost_src"

    doneSection
}
