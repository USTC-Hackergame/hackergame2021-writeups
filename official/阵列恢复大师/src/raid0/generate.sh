#!/bin/bash

filesha256() {
    sha256sum "$1" | head -c 64
}

echo "This script may break your system and please run it in snapshoted VM!"
read -r -p "Press any key to continue..." _

# destroying previous contents...
sudo umount mountpoint/
sudo losetup -d /dev/loop0
rm -f tmp/disk.img

mkdir -p tmp
mkdir -p disks
mkdir -p mountpoint

# creating new img structure
dd if=/dev/zero of=tmp/disk.img bs=1 count=0 seek=128M
/sbin/parted tmp/disk.img mklabel gpt mkpart '"My Disk"' xfs 1024KiB 100%
sudo losetup -P /dev/loop0 tmp/disk.img
sudo fdisk -l /dev/loop0
sudo mkfs.xfs /dev/loop0p1
sudo mount /dev/loop0p1 mountpoint/

# filling with contents
sudo cp getflag.py mountpoint/
wget -nc https://static.taoky.moe/disk-GcRDPmqVKOmvYLZ1nvQuWA.zip -O /tmp/disk.zip || :
if [ "$(filesha256 /tmp/disk.zip)" != "b739a4f3b656d369abfbd4989f22bde200fc50f2764b3fc5c8a0f2dbb0694c0f" ]; then
    echo "Wrong sha256"
    exit 255
fi
# sudo mkdir mountpoint/files/
sudo 7z x /tmp/disk.zip '-pATqDORlFrwV2jq90wauzEfHnj-rTviTGhxkr-C6ywzI' -o/tmp/files/
sudo mv /tmp/files/diskfiles-3/ ./mountpoint/files/
sudo chmod -R ugo+r ./mountpoint/files/

# umount and split
sudo umount mountpoint/
sudo losetup -d /dev/loop0
/usr/bin/env python3 split.py
touch -t 202110070000.00 disks/*
