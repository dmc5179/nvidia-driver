# nvidia-driver
Containerized version of nvidia drivers on RedHat CoreOS for air-gapped environments

## Build Instructions

./build.sh

Note: The container cannot be built in an air-gapped / disconnected environment. It requires yum/dnf and the ability to curl the nvidia tools

| Variable Name  | Default Value                 | Comments                           |
| :---           | :---                          | :---                               |
| KERNEL_VERSION | '4.18.0-147.3.1.el8_1.x86_64' | Kernel version of the RHCOS system |
| DRIVER_VERSION | '440.64.00'                   | Nvidia Driver Version              |
| RHCOS_VERSION  | '4.3.0'                       | Red Hat CoreOS Version             |
| REGISTRY       | 'quay.io'                     | Docker Registry                    |
| REPO           | 'danclark'                    | Docker Registry Repo               |


- RHCOS version to kernel version mapping

| RHCOS Version  | Kernel Version               |
| :---           | :---                         |
| 4.3.0-x86_64   | 4.18.0-147.3.1.el8_1.x86_64  |
| 4.3.8-x86_64   | 4.18.0-147.5.1.el8_1.x86_64  |
| 4.3.33-x86_64  | 4.18.0-193.14.3.el8_2.x86_64 |
| 4.4.3-x86_64   | 4.18.0-147.8.1.el8_1.x86_64  |
| 4.4.17-x86_64  | 4.18.0-193.14.3.el8_2.x86_64 |
| 4.5.1-x86_64   | 4.18.0-193.12.1.el8_2.x86_64 |
| 4.5.2-x86_64   | 4.18.0-193.13.2.el8_2.x86_64 |
| 4.5.6-x86_64   | 4.18.0-193.14.3.el8_2.x86_64 |
