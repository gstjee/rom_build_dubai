#!/bin/bash

# run this script in rom source dir(ie 'rom')
set +x
if [ -f "sl" ]; then
	bash sl
fi

if [ ! -f "tg.sh" ]; then
	cp -r .repo/.new/* ./
fi 

bash tg.sh "ROM build started at $(TZ='Asia/Kolkata' date +'%r %d %B')"
rm -rf status1
set -x

source build/envsetup.sh
breakfast dubai
croot

if [ "$1" == "clean" ];then
	make -j9 ARCH=arm clean
fi

# workaround for git lfs issue
repo forall -c 'git lfs install && git lfs pull && git lfs checkout'

# apply some uncommited changes/patch from .bak dir
cp -r .repo/.new/* ./

brunch dubai 2>&1 | tee dubai_rom_make.log

set +x
bash tg.sh "Brunch completed at $(TZ='Asia/Kolkata' date +'%r %d %B')"

sudo apt update
sudo apt install nano
echo "1" > status1
sleep 100
if [ -f "log" ]; then
	bash log
fi

bash tg.sh "dubai_rom_make.log"
bash upload.sh "$(cat dubai_rom_make.log | grep 'Package Complete' | awk -F': ' '{print $2}')"
# curl bashupload.com -T out/target/product/dubai/crDroidAndroid-14.0-20240515-dubai-v10.5.zip
