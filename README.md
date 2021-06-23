# nvidia-driver
Containerized version of nvidia drivers on RedHat CoreOS for air-gapped environments

## Build Instructions

- Make sure to update the options in the build.sh to match your RHCOS and nvidia driver version.

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

| RHCOS Version  | Kernel Version                   |
| :---           | :---                             |
| 4.3.0          | 4.18.0-147.3.1.el8_1      |
| 4.3.8          | 4.18.0-147.5.1.el8_1      |
| 4.3.33         | 4.18.0-193.14.3.el8_2     |
| 4.4.3          | 4.18.0-147.8.1.el8_1      |
| 4.4.17         | 4.18.0-193.14.3.el8_2     |
| 4.5.1          | 4.18.0-193.12.1.el8_2     |
| 4.5.2          | 4.18.0-193.13.2.el8_2     |
| 4.5.6          | 4.18.0-193.14.3.el8_2     |
| 4.6.1          | 4.18.0-193.24.1.el8_2.dt1 |
| 4.6.8          | 4.18.0-193.29.1.el8_2     |
| 4.7.0          | 4.18.0-240.10.1.el8_3     |
| 4.7.7          | 4.18.0-240.15.1.el8_3     |
| 4.7.13         | 4.18.0-240.22.1.el8_3     |
