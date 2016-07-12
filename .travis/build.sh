#!/bin/bash -x

#variable that change build result
BUILDROOT_TGZ=buildroot-2016.05.tar.gz

#get script location
SCRIPTDIR=`dirname $0`
SCRIPTDIR=`(cd $SCRIPTDIR ; pwd)`

#create working directory
WDIR=`mktemp -d` && trap "rm -Rf $WDIR" EXIT

#start build
cd ${WDIR}
wget --no-check-certificate https://buildroot.org/downloads/${BUILDROOT_TGZ}
tar --strip-components=1 -xf ${BUILDROOT_TGZ}
cp ${SCRIPTDIR}/buildroot/defconfig .config
make olddefconfig
make all
mv output/images/rootfs.tar.xz ${SCRIPTDIR}/.
