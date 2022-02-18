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

Cannot find dependency during AppImage build

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
