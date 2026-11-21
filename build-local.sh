#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf build-dir repo
mkdir -p repo
flatpak-builder --force-clean --user --install-deps-from=flathub \
  --repo=repo build-dir com.cocotecnico.cactustv.linux.yml
flatpak build-bundle repo \
  repo/com.cocotecnico.cactustv.linux.flatpak \
  com.cocotecnico.cactustv.linux
