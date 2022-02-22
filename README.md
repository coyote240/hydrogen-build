---
title: Building Hydrogen AppImage in Docker
keywords:
- hydrogen
- linux
- podman
- docker
- build
- appimage
---
# Building Hydrogen AppImage in Docker

Installation instructions based upon those found
[here](https://github.com/hydrogen-music/hydrogen/blob/master/INSTALL.md#build-and-install-from-source).

AppImage packaging instructions
[here](https://docs.appimage.org/packaging-guide/from-source/native-binaries.html)

## Build the image

```bash
podman build -t hydrogen-builder .
```

## Build Hydrogen

```bash
podman run --privileged -v "$(pwd)/out:/out" hydrogen-build:latest
```

After the build has complete, the AppImage file will be found in `/out`

## Testing the image

Running the image in an interactive session allows for easier debugging of the
build process.

```bash
podman run --privileged -it hydrogen-build:latest bash
```

Running the build script at the root of the container filesystem initiates
the build.

```bash
./build.sh
```

You may attach to an exited container by using podman start.

```bash
podman start --interactive --attach <containerid>
```

Rebuild the AppImage using `linuxdeploy`.

```bash 
cd hydrogen/build
/linuxdeploy-x86_64.AppImage --appdir AppDir -e Hydrogen --output appimage
```

## Issues

### Fatal failure during check_permissions

```bash
(main) $ out/Hydrogen-efd25a37-x86_64.AppImage

Hydrogen 1.1.1-'efd25a37' [Feb 22 2022]  [http://www.hydrogen-music.org]
Copyright 2002-2008 Alessandro Cominu
Copyright 2008-2022 The hydrogen development team
Hydrogen comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it under certain conditions. See the file COPYING for details.
Error: can't open log file for writing...
(E) Filesystem::check_permissions /usr/share/hydrogen/data/ is not a directory
(E) Filesystem::bootstrap will use local data path : /tmp/.mount_HydrogXmpSGo/usr/bin/data/
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/click.wav is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/demo_songs/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/drumkits/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/emptySample.wav is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/hydrogen.default.conf is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/i18n/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/img/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/themes/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/xsd/ is not a directory
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/xsd/drumkit_pattern.xsd is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/xsd/drumkit.xsd is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/xsd/playlist.xsd is not a file
(E) Filesystem::check_permissions /home/signal9/.hydrogen/data/emptySong.h2song is not a file
(E) Filesystem::check_permissions /tmp/.mount_HydrogXmpSGo/usr/bin/data/hydrogen.default.conf is not a file
(E) Filesystem::check_permissions /home/signal9/.hydrogen/hydrogen.conf is not a file
(E) ::void handleFatalSignal(int) Fatal signal 11
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x214ed6) [0x561358954ed6]
(E) ::void handleFatalSignal(int) /lib/x86_64-linux-gnu/libc.so.6(+0x3bd60) [0x7f682ba5bd60]
(E) ::void handleFatalSignal(int) /tmp/.mount_HydrogXmpSGo/usr/bin/../lib/libQt5Gui.so.5(_ZNK6QColor3redEv+0x18) [0x7f682c7b7d18]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x315727) [0x561358a55727]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x363cf4) [0x561358aa3cf4]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x35b0fe) [0x561358a9b0fe]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x3512d4) [0x561358a912d4]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x34fe4d) [0x561358a8fe4d]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(main+0x168d) [0x561358956c87]
(E) ::void handleFatalSignal(int) /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea) [0x7f682ba46d0a]
(E) ::void handleFatalSignal(int) out/Hydrogen-efd25a37-x86_64.AppImage(+0x6457a) [0x5613587a457a]
Segmentation fault
```

### Cannot find dependency during AppImage build - **SOLVED!!!**

Solution: `-DWANT_SHARED=OFF` allows Hydrogen to be build portable.

```bash
root@75c0d9a7e601:/hydrogen/build# /linuxdeploy-x86_64.AppImage --appdir AppDir/ -e Hydrogen --output appimage
linuxdeploy version 1-alpha (git commit ID 4c5b9c5), GitHub actions build 57 built on 2022-01-12 09:53:03 UTC

-- Creating basic AppDir structure --
Creating directory AppDir/usr/bin/
Creating directory AppDir/usr/lib/
Creating directory AppDir/usr/share/applications/
Creating directory AppDir/usr/share/icons/hicolor/
Creating directory AppDir/usr/share/icons/hicolor/16x16/apps/
Creating directory AppDir/usr/share/icons/hicolor/32x32/apps/
Creating directory AppDir/usr/share/icons/hicolor/64x64/apps/
Creating directory AppDir/usr/share/icons/hicolor/128x128/apps/
Creating directory AppDir/usr/share/icons/hicolor/256x256/apps/
Creating directory AppDir/usr/share/icons/hicolor/scalable/apps/

-- Deploying dependencies for existing files in AppDir --
Deploying dependencies for ELF file AppDir/usr/bin/h2cli
ERROR: Could not find dependency: libhydrogen-core-1.1.1.so
ERROR: Failed to deploy dependencies for existing files
```
