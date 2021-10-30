#!/bin/bash

set -x
set -e

echo "This script may break your system and please run it in snapshoted VM!"
read -r -p "Press any key to continue..." _

# destroying previous contents...
sudo umount mountpoint/ || :
sudo cryptsetup luksClose day1 || :
sudo cryptsetup luksClose day2 || :
sudo losetup -d /dev/loop0 || :
sudo losetup -d /dev/loop1 || :
rm -f day1.img || :
rm -f day2.img || :

mkdir -p mountpoint/

# creating new img structure
DAY1PWD=$(cat day1pwd | tr -d '\n')
DAY2PWD=$(cat day2pwd | tr -d '\n')
dd if=/dev/zero of=day1.img bs=1 count=0 seek=20M
/sbin/parted day1.img mklabel gpt mkpart '"My Disk"' ext4 1024KiB 100%
sudo losetup -P /dev/loop0 day1.img
sudo fdisk -l /dev/loop0
printf "$DAY1PWD" | sudo cryptsetup luksFormat /dev/loop0p1 - --pbkdf pbkdf2
cat day1pwd | sudo cryptsetup luksOpen /dev/loop0p1 day1
sudo mkfs.ext4 /dev/mapper/day1 -L 'My Disk'
sudo mount /dev/mapper/day1 mountpoint/

# filling with contents
sudo cp 随机过程.txt mountpoint/
sudo sync
sudo umount mountpoint/
sudo cryptsetup luksClose day1
sudo losetup -d /dev/loop0

# generate day2 img
cp day1.img day2.img
printf "$DAY1PWD" > /tmp/day1.pwd
sudo losetup -P /dev/loop1 day2.img
printf "$DAY2PWD" | sudo cryptsetup luksChangeKey /dev/loop1p1 --key-file /tmp/day1.pwd --pbkdf pbkdf2
cat day2pwd | sudo cryptsetup luksOpen /dev/loop1p1 day2
sudo mount /dev/mapper/day2 mountpoint/

sudo rm mountpoint/随机过程.txt
sudo cp flag.txt mountpoint/
sudo sync
sudo umount mountpoint/
sudo cryptsetup luksClose day2
sudo losetup -d /dev/loop1