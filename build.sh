#!/bin/bash

# May need to disable SELinux?

KERNEL_VERSION=4.18.0-147.5.1.el8_1.x86_64
DRIVER_VERSION=440.64.00

podman build -t quay.io/danclark/nvidia-driver:${DRIVER_VERSION}-1.0.0-custom-rhcos4.3 -f Dockerfile .

exit 0
