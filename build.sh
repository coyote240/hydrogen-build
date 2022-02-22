#!/usr/bin/env bash

# Clone & Build
git clone git://github.com/hydrogen-music/hydrogen.git
cd hydrogen
mkdir build && cd build

cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DWANT_SHARED=OFF
make -j$(nproc) && make install DESTDIR=AppDir

# Package
/linuxdeploy-x86_64.AppImage --appdir AppDir --output appimage
mkdir -p /out
mv Hydrogen*.AppImage /out
