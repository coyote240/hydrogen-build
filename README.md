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

```bash
podman build -t hydrogen-builder .
```

Probably a good idea to mount a directory at `/opt/hydrogen/` for build output
of both binaries and libs?
