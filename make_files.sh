#!/bin/sh

rm -rf files

mkdir -p files/linux

mkdir -p files/linux/arm64
unzip KernelUpdate/linux_a72/symlink_update.zip -d files/linux/arm64/
chmod a+x files/linux/arm64/*.ex
chmod a+x files/linux/arm64/*.exa

mkdir -p files/linux/amd64
unzip KernelUpdate/linux_x64/symlink_update.zip -d files/linux/amd64/
chmod a+x files/linux/amd64/*.ex
chmod a+x files/linux/amd64/*.exa
