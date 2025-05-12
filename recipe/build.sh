#!/usr/bin/env bash
set -ex

mkdir -p build
pushd build

meson --wrap-mode=nofallback \
      -Dtests=disabled \
      -Ddoc=disabled \
      ${MESON_ARGS} \
      ..
ninja -j${CPU_COUNT}
ninja install

popd
