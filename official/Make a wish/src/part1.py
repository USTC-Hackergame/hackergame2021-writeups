#!/usr/bin/env python3
# find nethack seed by start inventory
# searching RNG around specified time
# not required for getting flag
import argparse
import os
import pty
import sys
import time
import string
import datetime

nethack = '\'/usr/local/games/nethack\''
filename1 = 'part1.log'
targetin1 = 'part1_in.txt'
seedfile = 'time.txt'

seed_start = int(datetime.datetime(2021,8,31,22,18,55).timestamp())
seed2try = 0

while True:
    seed = seed_start + seed2try
    fseed = open(seedfile, 'w')
    fseed.write(str(seed))
    fseed.close()
    print('Try seed ', str(seed))
    (pid, fd) = pty.fork()
    if pid == 0:
        exec('os.system('+ nethack + ')')
        exit()
    else:
        time.sleep(0.1)
        fout = open(filename1, 'w')
        os.write(fd, "nahml     i #quit\nyq".encode())
        try:
            nout = os.read(fd, 1024)
            while nout != None:
                nout = nout.rstrip(b'\033')
                fout.write(nout.decode('ascii'))
                nout = os.read(fd, 1024)
        except OSError:
            print('nethack ended successfully.')
        fout.close()

    ftofind = open(targetin1, 'r')
    flog1   = open(filename1, 'r')
    strall = flog1.read().encode('ascii')
    strtofind = ftofind.readlines()
    ftofind.close()
    flog1.close()
    # print(strall)
    hit = 1
    for i in strtofind:
        # print(i)
        if strall.find(i[:-1].encode('ascii')) != -1:
            print('Found ' + i[:-1])
        else:
            print('NOT   ' + i[:-1])
            hit = 0
    if (hit == 1):
        print('Hit: seed for this run is ' + str(seed))
        exit()
    else:
        print('Pass, next')
        if seed2try >= 0:
            seed2try = - seed2try - 1
        else:
            seed2try = - seed2try
        if seed2try >= 200:
            print('+- 200 seconds tried but no luck')
            exit()
        # input()


# open ./part1_in.txt and if all lines appears in part1.log, 
# we get a hit

