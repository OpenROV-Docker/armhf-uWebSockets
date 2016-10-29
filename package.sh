#!/bin/bash
set -ex

DIR=${PWD}

# Get arch
ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

# Create version postfix
PACKAGE_VERSION=${VERSION}

# Create package folder
mkdir -p ${DIR}/pkg

# Package as debian package
fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE_NAME}_${GIT_TAG}_${DOCKER_TAG} \
	-v ${PACKAGE_VERSION} \
	--description "uWebSocket mostly-static build" \
	-C ${DIR}/build ./

# Move package to pkg dir
mv *.deb ${DIR}/pkg
