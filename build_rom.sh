#!/bin/bash

# run this script in rom source dir(ie 'rom')

source build/envsetup.sh &&
breakfast dubai &&
croot &&

if [ "$1" == "clean" ];then
	make -j9 ARCH=arm clean
fi

brunch dubai 2>&1 | tee dubai_rom_make.log


# curl bashupload.com -T out/target/product/dubai/crDroidAndroid-14.0-20240515-dubai-v10.5.zip
