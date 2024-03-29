FROM registry.access.redhat.com/ubi8/ubi:8.1

ARG DRIVER_VERSION
ENV DRIVER_VERSION=${DRIVER_VERSION:-440.64.00}

ARG BASE_URL
ENV BASE_URL=${BASE_URL:-https://us.download.nvidia.com/tesla}

ARG PUBLIC_KEY
ENV PUBLIC_KEY=${PUBLIC_KEY:-empty}

#ARG PRIVATE_KEY

ARG KERNEL_VERSION
ENV KERNEL_VERSION=${KERNEL_VERSION:-4.18.0-147.3.1.el8_1.x86_64}

ARG ARCH
ENV ARCH=${ARCH:-x86_64}

ARG RHEL_VERSION
ENV RHEL_VERSION=${RHEL_VERSION:-8.4}


COPY nvidia-driver-disconnected /usr/local/bin/nvidia-driver-disconnected

RUN dnf config-manager --set-enabled rhocp-4.9-for-rhel-8-x86_64-rpms \
 && dnf install --setopt tsflags=nodocs -y elfutils-libelf.x86_64 elfutils-libelf-devel.x86_64 curl make kmod \
 && dnf -y --releasever=${RHEL_VERSION} install --setopt tsflags=nodocs kernel-headers-${KERNEL_VERSION} kernel-devel-${KERNEL_VERSION} \
 && dnf -y --releasever=${RHEL_VERSION} install --setopt tsflags=nodocs kernel-core-${KERNEL_VERSION} \
 && gcc_version=$(grep -Eo 'Compiler: gcc \(GCC\) ([0-9\.]+)' /lib/modules/${KERNEL_VERSION}.x86_64/config | grep -Eo "([0-9\.]+)") \
 && dnf install --setopt tsflags=nodocs -y --releasever=${RHEL_VERSION} "gcc-${gcc_version}" \
 && rm -rf /var/cache/dnf

#RUN dnf install --setopt tsflags=nodocs -y ca-certificates curl gcc glibc.i686 make cpio kmod \
#    elfutils-libelf elfutils-libelf-devel \
#    "kernel-headers-${KERNEL_VERSION}" "kernel-devel-${KERNEL_VERSION}" \
#    && rm -rf /var/cache/yum/*

RUN curl -fsSL -o /usr/local/bin/donkey https://github.com/3XX0/donkey/releases/download/v1.1.0/donkey \
    && curl -fsSL -o /usr/local/bin/extract-vmlinux https://raw.githubusercontent.com/torvalds/linux/master/scripts/extract-vmlinux \
    && chmod +x /usr/local/bin/donkey /usr/local/bin/extract-vmlinux

RUN ln -s /sbin/ldconfig /sbin/ldconfig.real \
 && chmod +x /usr/local/bin/nvidia-driver-disconnected \
 && ln -sf /usr/local/bin/nvidia-driver-disconnected /usr/local/bin/nvidia-driver

RUN cd /tmp \
    && curl -fSslL -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-${ARCH}-$DRIVER_VERSION.run \
    && sh NVIDIA-Linux-${ARCH}-$DRIVER_VERSION.run -x \
    && cd NVIDIA-Linux-${ARCH}-$DRIVER_VERSION \
    && ./nvidia-installer --silent --no-kernel-module --install-compat32-libs --no-nouveau-check --no-nvidia-modprobe \
       --no-rpms --no-backup --no-check-for-alternate-installs --no-libglx-indirect --no-install-libglvnd --x-prefix=/tmp/null \
       --x-module-path=/tmp/null --x-library-path=/tmp/null --x-sysconfig-path=/tmp/null \
    && mkdir -p /usr/src/nvidia-$DRIVER_VERSION \
    && mv LICENSE mkprecompiled kernel /usr/src/nvidia-$DRIVER_VERSION \
    && sed '9,${/^\(kernel\|LICENSE\)/!d}' .manifest > /usr/src/nvidia-$DRIVER_VERSION/.manifest \
    && rm -rf /tmp/* \
    && dnf download -y kernel-core-${KERNEL_VERSION} --downloaddir=/tmp/ \
    && rm -rf /var/cache/yum

WORKDIR /usr/src/nvidia-$DRIVER_VERSION

COPY ${PUBLIC_KEY} kernel/pubkey.x509

RUN mkdir -p /run/nvidia \
 && touch /run/nvidia/nvidia-driver.pid

# This will really run the disconnected version
ENTRYPOINT ["nvidia-driver, "init"]

