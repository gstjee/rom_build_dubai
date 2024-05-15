#!/bin/bash

# run this script in where you you want to create rom source dir

mkdir -p rom && cd rom

# rom you  want to build
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs

# devices trees
mkdir -p .repo/local_manifests
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/main/local_manifests/extras.xml > .repo/local_manifests/extras.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/main/local_manifests/motorola-common.xml > .repo/local_manifests/motorola-common.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/main/local_manifests/motorola-sm7325.xml > .repo/local_manifests/motorola-sm7325.xml

repo sync -j$(nproc --all)

#repo sync -j4 --fail-fast

echo "repo init, rom sources and devices trees sync complete!!"

