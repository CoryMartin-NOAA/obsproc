#!/bin/bash

set -eux

# Location of PWD and package source directory.
pkg_root=`dirname $(readlink -f $0)`

INSTALL_TARGET=${INSTALL_TARGET:-"wcoss2"}
INSTALL_PREFIX=${INSTALL_PREFIX:-"$pkg_root/install"}

target=$(echo $INSTALL_TARGET | tr [:upper:] [:lower:])
if [[ "$target" =~ ^(wcoss2|hera|orion)$ ]]; then
  source $pkg_root/versions/build.ver
  set +x
  module purge
  module use $pkg_root/modulefiles
  module load obsproc_$target
  module list
  set -x
fi

# Create a build directory and cd into it.
[[ -d build  ]] && rm -rf build
mkdir -p build && cd build

# build and install.
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DCMAKE_INSTALL_BINDIR=exec ..
make -j ${BUILD_JOBS:-8} VERBOSE=${BUILD_VERBOSE:-}
make install

#############################################################################
# This section to be removed when NCO is comfortable with the typical
# `cmake`, `make` and `make install` process.
# To abide by current NCO working practices,
# manually copy compiled executables and fix files from `$INSTALL_PREFIX/`
# directory to `pkg_root` and then remove `$INSTALL_PREFIX/`
mkdir -p $pkg_root/exec
cp -f $INSTALL_PREFIX/exec/*                                  $pkg_root/exec/
cp -f $INSTALL_PREFIX/fix/prepobs_landc                       $pkg_root/fix/
cp -f $INSTALL_PREFIX/fix/syndat_syndata.slmask.t126.gaussian $pkg_root/fix/
rm -rf $INSTALL_PREFIX
#############################################################################

# Remove build directory upon successfull build and install
cd $pkg_root
rm -rf build

exit 0
