#!/bin/bash

rm -f raid0.zip
rm -f raid0-encrypted.7z
zip -j raid0.zip disks/*

7za a raid0-encrypted.7z '-p__2SBptdy572q4k90nCHKQ' -mhe=on raid0.zip
