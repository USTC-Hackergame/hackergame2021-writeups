#!/bin/bash
set -e

function zeroout()
{
	objcopy --dump-section "$1"=/dev/play/sec.bin /dev/play/a.out
	xxd -p /dev/play/sec.bin  | sed 's/[0-9a-f]/0/g' | xxd -r -p > /dev/play/seczero.bin
	objcopy --update-section "$1"=/dev/play/seczero.bin /dev/play/a.out
	rm -f /dev/play/sec.bin
	rm -f /dev/play/seczero.bin
}

cd /dev/play; gcc -O /dev/play/code1.c -m32 -o /dev/play/a.out
zeroout ".data"
zeroout ".rodata"
