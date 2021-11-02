#!/bin/bash

mapdevice="/dev/mapper/$(sudo kpartx -va day2.img | sed -E 's/.*(loop[0-9]+p[0-9]+).*/\1/g' | head -1)"
sudo cryptsetup luksOpen --master-key-file mk $mapdevice day2
sudo mount -o ro /dev/mapper/day2 /mnt
cat /mnt/flag.txt
sudo umount /mnt
sudo cryptsetup luksClose day2
sudo kpartx -d $mapdevice
