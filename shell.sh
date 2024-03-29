#!/bin/bash
sudo apt-get update
sudo apt install qemu-system-arm

#Download Rootfs and Resize
wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5/machines/qemu/qemuarm/core-image-minimal-qemuarm.ext4
mv core-image-minimal-qemuarm.ext4 rootfs.img
e2fsck -f rootfs.img
resize2fs rootfs.img 16M 

#Download zImage and dtb
wget https://dev.azure.com/GEA-Trainings/5f7e6b5f-ed26-4c16-b1c2-5d48baed8907/_apis/git/repositories/5ba1cb16-b85f-48ac-87ce-ca2eb76679df/items?path=/vexpress-v2p-ca9.dtb&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=main&resolveLfs=true&%24format=octetStream&api-version=5.0&download=true
wget https://dev.azure.com/GEA-Trainings/5f7e6b5f-ed26-4c16-b1c2-5d48baed8907/_apis/git/repositories/5ba1cb16-b85f-48ac-87ce-ca2eb76679df/items?path=/zImage&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=main&resolveLfs=true&%24format=octetStream&api-version=5.0&download=true
mv items?path=%2Fvexpress-v2p-ca9.dtb vexpress-v2p-ca9.dtb 
mv items?path=%2FzImage zImage

#Launch the qemu
qemu-system-arm -M vexpress-a9 -m 1024 -serial stdio -kernel zImage -dtb vexpress-v2p-ca9.dtb -sd rootfs.img -append "console=ttyAMA0 root=/dev/mmcblk0 rw" &
exit 0
