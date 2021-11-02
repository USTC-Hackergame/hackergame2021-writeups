#!/bin/bash

mapdevice="/dev/mapper/$(sudo kpartx -va day1.img | sed -E 's/.*(loop[0-9]+p[0-9]+).*/\1/g' | head -1)"
sudo cryptsetup luksDump --dump-master-key $mapdevice
sudo kpartx -d $mapdevice
