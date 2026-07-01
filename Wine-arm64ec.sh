#!/bin/bash

apt update
apt --fix-broken install -y

apt install -y \
  autoconf \
  bison \
  bubblewrap \
  debootstrap \
  flex \
  gettext \
  gcc-multilib \
  git \
  locales \
  language-pack-zh-hans \
  mingw-w64 \
  perl \
  xz-utils \
  libasound2-dev \
  libcups2-dev \
  libdbus-1-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libgettextpo-dev \
  libgl-dev \
  libglu-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  libjpeg-dev \
  libmpg123-dev \
  libopenal-dev \
  libosmesa6-dev \
  libpcap-dev \
  libpng-dev \
  libpulse-dev \
  libsdl2-dev \
  libssl-dev \
  libtiff-dev \
  libudev-dev \
  libunwind-dev \
  libvulkan-dev \
  libvulkan1 \
  libxml2-dev \
  libx11-dev \
  libxcomposite-dev \
  libxcursor-dev \
  libxdamage-dev \
  libxext-dev \
  libxfixes-dev \
  libxi-dev \
  libxinerama-dev \
  libxrandr-dev \
  libxrender-dev \
  libxxf86vm-dev \
  mesa-vulkan-drivers \
  vulkan-tools \
  gstreamer1.0-* \
  libfaad-dev \
  libflac-dev \
  libtheora-dev \
  libvorbis-dev \
  libvpx-dev \
  libx264-dev \
  libx265-dev \
  wget \
  unzip \
  zip \
  tar

  wget -qnv https://github.com/mstorsjo/llvm-mingw/releases/download/20260616/llvm-mingw-20260616-ucrt-ubuntu-22.04-x86_64.tar.xz

  tar -xf llvm-mingw-20260616-ucrt-ubuntu-22.04-x86_64.tar.xz

  export PATH=$(pwd)/llvm-mingw-20260616-ucrt-ubuntu-22.04-x86_64/bin:$PATH

git clone https://github.com/ValveSoftware/wine
cd wine

chmod +x autogen.sh

export CROSSCC="arm64ec-w64-mingw32-gcc"
export CROSSCXX="arm64ec-w64-mingw32-g++"

find . -type f \( -name "*.c" -o -name "*.h" -o -name "*.in" -o -name "*.spec" \) -exec grep -l "/tmp" {} \; | xargs sed -i 's|/tmp/|/data/data/com.winlator/files/rootfs/usr/tmp/|g'
            find server -type f \( -name "*.c" -o -name "*.h" \) -exec sed -i 's|"/tmp"|"/data/data/com.winlator/files/rootfs/usr/tmp"|g' {} +
            find . -name "file.c" -exec sed -i 's|"/tmp"|"/data/data/com.winlator/files/imagefs/usr/tmp"|g' {} +
            find . -name "loader.c" -exec sed -i 's|"/tmp"|"/data/data/com.winlator/files/imagefs/usr/tmp"|g' {} +
            find . -name "server.c" -exec sed -i 's|"/tmp"|"/data/data/com.winlator/files/imagefs/usr/tmp"|g' {} +

          
./autogen.sh

mkdir -p build
cd build 

../configure \
              --enable-win64 \
              --enable-archs=aarch64,arm64ec,i386 \
              --prefix=/tmp/wine-install-proton \
              --with-x \
              --with-vulkan \
              --with-alsa \
              --with-pulse \
              --with-freetype \
              --with-fontconfig \
              --with-gstreamer \
              --with-gettext \
              --with-sdl \
              --enable-nls \
              --disable-winemenubuilder \
              --disable-win16 \
              --disable-tests \
              --without-ldap \
              --without-capi \
              --without-oss \
              --without-cups \
              --without-dbus \
              --without-coreaudio \
              --without-gphoto \
              --without-osmesa \
              --without-sane \
              --without-pcap \
              --without-pcsclite \
              --without-udev \
              --without-unwind \
              --without-usb \
              --without-v4l2 \
              --without-wayland \
              --with-mingw=clang

              make -j$(nproc)
              make install
              cd /tmp/wine
              rm -rf include
              cd ..
              tar -cJf wine
              
              
