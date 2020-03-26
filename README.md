# nvidia-driver
Containerized version of nvidia drivers on RedHat CoreOS for air-gapped environments

## Build Instructions

./build.sh

Note: The container cannot be built in an air-gapped / disconnected environment. It requires yum/dnf and the ability to curl the nvidia tools
