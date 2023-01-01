#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\"" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi

DRV_NAME=$(basename $(pwd))
DRV_VERSION=$(git describe --long).$(date -d "$(git show -s --format=%ci HEAD)" +%Y%m%d)
DKMS_DIR=/usr/src/${DRV_NAME}-${DRV-VERSION}

cp -r . ${DKMS_DIR}
sed -i -e '/^PACKAGE_VERSION=/ s/=.*/=\"$(DRV_VERSION)\"/' ${DKMS_DIR}/dkms.conf
echo "$(DRV_VERSION)" >${DKMS_DIR}/VERSION

dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
RESULT=$?

echo "Finished running dkms install steps."

exit $RESULT
