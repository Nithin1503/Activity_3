#!/bin/bash
sudo apt-get update
sudo apt install qemu-system-arm
sudo apt install libncurses-dev flex bison
sudo apt install libssl-dev
sudo apt install gcc-arm-linux-gnueabi

#Download Rootfs and Resize
wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/machines/qemu/qemuarm/core-image-minimal-qemuarm.ext4
mv core-image-minimal-qemuarm.ext4 rootfs.img
e2fsck -f rootfs.img
resize2fs rootfs.img 16M


#For downloading the file
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.17.3.tar.xz

#For Unzipping the file
tar xvf linux-5.17.3.tar.xz
mkdir 03_Custom
mv rootfs.img 03_Custom
cd linux-5.17.3

make ARCH=arm vexpress_defconfig
make ARCH=arm menuconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- zImage vexpress-v2p-ca9.dtb
cd ..
mv linux-5.17.3/arch/arm/boot/zImage 03_Custom
mv linux-5.17.3/arch/arm/boot/dts/vexpress-v2p-ca9.dtb 03_Custom
cd 03_Custom
qemu-system-arm -M vexpress-a9 -m 1024 -serial stdio -kernel zImage -dtb vexpress-v2p-ca9.dtb -sd rootfs.img -append "console=ttyAMA0 root=/dev/mmcblk0 rw" &
exit 0
