#!/bin/bash -xe

# May need to disable SELinux?

#KERNEL_VERSION=4.18.0-147.5.1.el8_1.x86_64
KERNEL_VERSION=4.18.0-147.8.1.el8_1.x86_64
DRIVER_VERSION=440.64.00
RHCOS_VERSION=4.4
REGISTRY="quay.io"
REPO="danclark"

sudo podman build -t ${REGISTRY}/${REPO}/nvidia-driver:${DRIVER_VERSION}-1.0.0-custom-rhcos${RHCOS_VERSION} -f Dockerfile .

exit 0
