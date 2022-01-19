#!/bin/bash -xe

# See the README file for a description of these variables
BASE_URL="${BASE_URL:-https://us.download.nvidia.com/tesla}"
#KERNEL_VERSION='4.18.0-193.13.2.el8_2.x86_64'
DRIVER_VERSION="${DRIVER_VERSION:-450.51.06}"
RHCOS_VERSION="${RHCOS_VERSION:-4.6.8}"
REGISTRY="${REGISTRY:-quay.io}"
REPO="${REPO:-danclark}"
ARCH="${ARCH:-x86_64}"

# Yes, I use the table in the README. What, am I going to put a table in 2 places?
KERNEL_VERSION=$(grep ${RHCOS_VERSION} README.md | awk -F\| '{print $3}' | tr -d ' ')
RHEL_VERSION=$(echo $KERNEL_VERSION | awk -F\. '{print $NF}' | sed 's|el||' | sed 's|_|.|')

echo "Kernel Version: $KERNEL_VERSION"
echo "RHEL Version: $RHEL_VERSION"

sudo podman build --no-cache \
     --tag ${REGISTRY}/${REPO}/nvidia-driver:${DRIVER_VERSION}-1.0.0-custom-rhcos-${KERNEL_VERSION}-${RHCOS_VERSION} \
     --build-arg=DRIVER_VERSION=${DRIVER_VERSION} \
     --build-arg=BASE_URL=https://us.download.nvidia.com/tesla \
     --build-arg=PUBLIC_KEY=empty \
     --build-arg=KERNEL_VERSION=${KERNEL_VERSION} \
     --build-arg=BASE_URL=${BASE_URL} \
     --build-arg=ARCH=${ARCH} \
     --build-arg=RHEL_VERSION=${RHEL_VERSION} \
     --file Dockerfile .

exit 0
