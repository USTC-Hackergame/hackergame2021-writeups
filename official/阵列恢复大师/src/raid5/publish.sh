#!/bin/bash

rm -f raid5.zip
rm -f raid5-encrypted.7z
zip -j raid5.zip disks/*

7za a raid5-encrypted.7z '-p__2SBptdy572q4k90nCHKQ' -mhe=on raid5.zip
