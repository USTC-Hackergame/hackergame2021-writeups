#!/usr/bin/env python3
# brute force the count of bumping into wall until wish found
# read keylog2.txt by part2.py
import argparse
import os
import pty
import sys
import time
import string
import datetime

bumparray = [int(i) for i in open('bumplist.txt').readlines()]
bumpcount = int(sys.argv[1])

keyin3 = 'keylog2.txt'
# filename3 = 'part3.log'
filename3 = 'stderr.txt' + str(os.getpid()) + str(time.time())
# nethack = '\'su ' + str(sys.argv[3]) + ' -c \" stdbuf -o0 /usr/games/nethack 2>' + filename3 + '\"\''
# nethack = '\'stdbuf -o0 /usr/games/nethack 2>' + filename3 + '\''
fileretval = 'ret.txt'
# nethack = '\'bash -c \"/usr/games/nethack ' + str(bumparray[bumpcount]) + ' 2>/dev/null; echo $? > ' + fileretval + '\"\''
nethack = './runhack.sh '
print(nethack)

# str2find = 'grants you a wish!'
# str2find = 'wish'
# str2find = 'drink'
# str2find = 'wish'
retvalgood = 232 # a wish without further guarentees
cmdbumpwall = b'j' # user customize this!
cmdtofountain = b'h'
cmdquarf = b'q'
cmdyes = b'y'
cmdctrlc = b'\x03'
cmdq = b'q'
cmdspace = b' '

os.system('sudo rm -f /usr/games/lib/nethackdir/save/*.gz')
wishfound = 0

while bumpcount < int(sys.argv[1]) + int(sys.argv[2]):
    # print(bumparray[bumpcount - sysargv1])
    (pid, fd) = pty.fork()
    if pid == 0:
        exec('os.system(\''+ nethack + ' ' + str(bumparray[bumpcount]) + '\')')
        exit()
    else:
        # time.sleep(0.1)
        # fout = open(filename3, 'w')
        cmdlist = open(keyin3).read()
        for i in cmdlist[:-1]:
            os.write(fd, i.encode())
            time.sleep(0.001)
        # for i in range(bumparray[bumpcount]):
            # os.write(fd, 'j'.encode())
            # # if (i % 10 == 0):
            # time.sleep(0.00001)
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
        while True:
            found = os.system('ps -eLF| grep -v grep | grep ' + str(pid) + ' | grep runhack >/dev/null 2>/dev/null')
            if found != 0:
                break
        os.system('sudo rm -f /usr/games/lib/nethackdir/save/*.gz /usr/games/lib/nethackdir/alock*')
        # os.write(fd, cmdspace)
        # time.sleep(0.001)
        # os.write(fd, cmdspace)
        # time.sleep(0.001)
        # # # time.sleep(0.010)
        # os.system('kill -INT ' + str(pid))
        # time.sleep(0.010)
        # os.write(fd, 'y'.encode())
        # time.sleep(0.010)
        # os.write(fd, 'q'.encode())
        # time.sleep(0.010)
        # os.write(fd, cmdq)
        # time.sleep(0.010)
        # os.system('kill -9 ' + str(pid))
        # time.sleep(0.1)

        # print(cmdlist)
        # os.write(fd, cmdlist)

        # os.write(fd, "nahml      i #quit\nyq".encode())
        # try:
            # nout = os.read(fd, 1024)
            # while nout != None:
                # nout = nout.rstrip(b'\033')
                # fout.write(nout.decode('ascii'))
                # nout = os.read(fd, 1024)
        # except OSError:
            # print('nethack ended successfully.')
        # fout.close()


    # # ftofind = open(targetin1, 'r')
    # flog3   = open(filename3, 'r')
    # strall = flog3.read().encode('ascii')
    # # strtofind = ftofind.readlines()
    # # ftofind.close()
    # flog3.close()
    # # os.system('rm ' + filename3)
    retval = 0
    try:
        retval = int(open(fileretval).read())
    except ValueError:
        print('RETVAL ERR!')
    # if strall.find(str2find.encode('ascii')) != -1:
    if retval == retvalgood:
        wishfound = wishfound + 1
        print('Found a wish -- ' + str(bumparray[bumpcount]) + ' bumps ' + str(wishfound))
        # sys.exit(0)
    elif retval == 233: # should meet with modified nethack
        print('Final wish!' + str(bumparray[bumpcount]))
        os.system('echo ' + str(bumparray[bumpcount]) + ' > result_' + str(time.time()))
        sys.exit(0)
    else:
        print('.')
        pass
        # print('Nope')

        
    bumpcount = bumpcount + 1
    # # print(strall)
    # hit = 1
    # for i in strtofind:
        # # print(i)
        # if strall.find(i[:-1].encode('ascii')) != -1:
            # print('Found ' + i[:-1])
        # else:
            # print('NOT   ' + i[:-1])
            # hit = 0
    # if (hit == 1):
        # print('Hit: seed for this run is ' + str(seed))
        # exit()
    # else:
        # print('Pass, next')
        # if seed2try >= 0:
            # seed2try = - seed2try - 1
        # else:
            # seed2try = - seed2try
        # if seed2try >= 200:
            # print('+- 200 seconds tried but no luck')
            # exit()
        # # input()


# open ./part1_in.txt and if all lines appears in part1.log, 
# we get a hit

