#!/usr/bin/env bash
set -ex

mkdir -p build
pushd build

meson --prefix=${PREFIX} \
      --buildtype=release \
      --libdir=$PREFIX/lib \
      --wrap-mode=nofallback \
      -Dtests=disabled
      ..
ninja -j${CPU_COUNT}
ninja install

popd
