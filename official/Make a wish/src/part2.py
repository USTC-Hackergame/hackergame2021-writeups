#!/usr/bin/env python3
# used to record user keystrokes in nethack
# user plays until a fountain next to wall is found
import argparse
import os
import pty
import sys
import time
import string
import datetime

nethack = './runhack1.sh'
filename1 = 'part1.log'
targetin1 = 'part1_in.txt'
seedfile = 'time.txt'

userkeystr = ''
userkeys = open("keylog2.txt", "w")
nhoutput = ''
# klog2 = open("keylog1.txt", "w")
def userread(fd):
    global userkeys
    global userkeystr
    data = os.read(fd, 1024)
    userkeystr = userkeystr + data.decode('ascii')
    userkeys.write(data.decode('ascii'))
    return data
    # print(data)
def nhread(fd):
    data = os.read(fd, 1024)
    global nhoutput
    nhoutput = nhoutput + data.decode('ascii')
    return data
    # print(data)
pty.spawn(nethack, nhread, userread)
userkeys.close()
print(userkeystr)
# open("keylog2.txt", "w").write(userkeys);
# open("nhlog2.txt", "w").write(nhoutput);
# print(userkeys)
# pty.spawn(nethack, nhread)

