# nvidia-driver
Containerized version of nvidia drivers on RedHat CoreOS for air-gapped environments

## Build Instructions

./build.sh

Note: The container cannot be built in an air-gapped / disconnected environment. It requires yum/dnf and the ability to curl the nvidia tools


| RHCOS Version  | Kernel Version               |
| :---           | :---                         |
| 4.3.0-x86_64   | 4.18.0-147.3.1.el8_1.x86_64  |
| 4.3.8-x86_64   | 4.18.0-147.5.1.el8_1.x86_64  |
| 4.3.33-x86_64  | 4.18.0-193.14.3.el8_2.x86_64 |

