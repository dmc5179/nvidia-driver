FROM registry.access.redhat.com/ubi8/ubi:8.1

ARG BASE_URL=https://us.download.nvidia.com/tesla
#ARG DRIVER_VERSION=440.33.01
ENV DRIVER_VERSION=440.64.00
ENV BASE_URL=https://us.download.nvidia.com/tesla
ARG PUBLIC_KEY=empty
ARG PRIVATE_KEY
ARG KERNEL_VERSION=4.18.0-147.5.1.el8_1.x86_64


RUN yum install --setopt tsflags=nodocs -y ca-certificates curl gcc glibc.i686 make cpio kmod \
    elfutils-libelf.x86_64 elfutils-libelf-devel.x86_64 \
    && rm -rf /var/cache/yum/*

RUN curl -fsSL -o /usr/local/bin/donkey https://github.com/3XX0/donkey/releases/download/v1.1.0/donkey \
    && curl -fsSL -o /usr/local/bin/extract-vmlinux https://raw.githubusercontent.com/torvalds/linux/master/scripts/extract-vmlinux \
    && chmod +x /usr/local/bin/donkey /usr/local/bin/extract-vmlinux

RUN ln -s /sbin/ldconfig /sbin/ldconfig.real

RUN cd /tmp \
    && curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run \
    && sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run -x \
    && cd NVIDIA-Linux-x86_64-$DRIVER_VERSION \
    && ./nvidia-installer --silent --no-kernel-module --install-compat32-libs --no-nouveau-check --no-nvidia-modprobe \
       --no-rpms --no-backup --no-check-for-alternate-installs --no-libglx-indirect --no-install-libglvnd --x-prefix=/tmp/null \
       --x-module-path=/tmp/null --x-library-path=/tmp/null --x-sysconfig-path=/tmp/null \
    && mkdir -p /usr/src/nvidia-$DRIVER_VERSION \
    && mv LICENSE mkprecompiled kernel /usr/src/nvidia-$DRIVER_VERSION \
    && sed '9,${/^\(kernel\|LICENSE\)/!d}' .manifest > /usr/src/nvidia-$DRIVER_VERSION/.manifest \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum

COPY nvidia-driver /usr/local/bin
COPY nvidia-driver-disconnected /usr/local/bin

WORKDIR /usr/src/nvidia-$DRIVER_VERSION

COPY ${PUBLIC_KEY} kernel/pubkey.x509

RUN mkdir -p /run/nvidia \
 && touch /run/nvidia/nvidia-driver.pid

ENTRYPOINT ["nvidia-driver-disconnected" "init"]

