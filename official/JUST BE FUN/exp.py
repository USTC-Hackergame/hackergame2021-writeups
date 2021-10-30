#!/usr/bin/env python3
from pwn import *
from secret import token

remo = 1
archive = 'amd64'

context(os='linux', arch=archive, log_level='debug')
context.terminal = ['gnome-terminal', '-x', 'sh', '-c']

if not remo:
    n = process("files/be_fun.py")
else:
    n = remote("202.38.93.111", 10104)

game_board = [[['@' for i in range(0x100)]
               for j in range(0x100)] for k in range(0x100)]

with open("exp", 'r') as f:
    y = 0
    while 1:
        buf = f.readline()[:-1]
        if not buf:
            break
        buf = buf.ljust(0x100, ' ')
        for i, c in enumerate(buf):
            game_board[i][y][0] = c
        y += 1

if remo:
    n.sendlineafter("Please input your token: ", token)

l = ""
for i in range(0x100):
    for j in range(0x100):
        l += f"({i}, {j}, {0}) -> {ord(game_board[i][j][0])} "
        # n.sendlineafter('>', "({}, {}, {}) {}".format(i, j, 0, ord(game_board[i][j][0])))

l += "END"
n.sendlineafter(">", l)

print(len(l))
n.interactive()
