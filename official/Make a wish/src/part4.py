#!/usr/bin/env python3
# perform final game -- find flag
# read keylog2.txt by part2.py
# bumpcount can be found in part3.py writen result file
# flag found at the end of part4.log
# ctrl-c if not end properly
import argparse
import os
import pty
import sys
import time
import string
import datetime

# token = '1:MEUCIQCjK1QcPFro86w3bKPb5zUZZd96ocp3EZDFcwLtJxNNDAIgEPk3Orw0mE+zHLQA7e31kSFupNtG9uepz2H4EqxlKWY=\n'
token = '14:MEYCIQDHcyMVNXSKz0/VnP6vBADt+x6i3KnVIzaGWvktVHiXdAIhAI5j+VjKyMCkESz0zmnirr/rAKy5zn7mUiWoGOmXVx/M\n'
keyin4 = 'keylog2.txt'
filename4 = 'part4.log'
# bumpcount = 104949 # normal
bumpcount = 105369 # lucky

os.system('sudo rm -f /usr/games/lib/nethackdir/save/*.gz')
(pid, fd) = pty.fork()
if pid == 0:
    # exec('os.system(\"/usr/games/nethack\")')
    exec('os.system(\"bash ./runhacknc.sh\")')
    exit()
else:
    # time.sleep(0.1)
    # fout = open(filename3, 'w')
    for i in token[:]:
        os.write(fd, i.encode())
        time.sleep(0.010)
    time.sleep(2)
    cmdlist = open(keyin4).read()
    for i in cmdlist[:-1]:
        os.write(fd, i.encode())
        time.sleep(0.010)
    for i in range(bumpcount):
        os.write(fd, 'j'.encode())
        # if (i % 10 == 0):
        time.sleep(0.00001)
    time.sleep(0.001)
    os.write(fd, 'q'.encode())
    time.sleep(0.001)
    os.write(fd, 'y'.encode())
    time.sleep(0.001)
    os.write(fd, ' '.encode())
    time.sleep(0.001)
    os.write(fd, ' '.encode())
    time.sleep(0.001)
    os.write(fd, ' '.encode())
    time.sleep(0.001)
    os.write(fd, 'flag'.encode())
    time.sleep(0.001)
    os.write(fd, '\n'.encode())
    time.sleep(0.001)
    os.write(fd, ' '.encode())
    time.sleep(0.301)
    print('dump done. ')
    os.system('kill -9 ' + str(pid))
    # while True:
        # found = os.system('ps -eLF| grep -v grep | grep ' + str(pid) + ' | grep runhack >/dev/null 2>/dev/null')
        # if found != 0:
            # break

    fout = open(filename4, 'w')
    try:
        nout = os.read(fd, 1024)
        while nout != None:
            nout = nout.rstrip(b'\033')
            fout.write(nout.decode('ascii'))
            nout = os.read(fd, 1024)
    except OSError:
        print('nethack ended successfully.')

