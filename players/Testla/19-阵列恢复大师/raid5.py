#!/usr/bin/python3

import itertools
import subprocess
import time

Image_files = [
    '3D8qN9DH91Q.img',
    '3RlmViivyG8.img',
    '60kE0MQisyY.img',
    'IrYp6co7Gos.img',
    'QjTgmgmwXAM.img',
]


def main() -> None:
    # Just mount it as readwrite.
    # loop_devices = []
    # for image_file in Image_files:
    #     loop_devices.append(
    #         subprocess.check_output(
    #             ['sudo', 'losetup', '-f', '--show', image_file])
    #         .decode().rstrip('\n'))
    # print(loop_devices)
    # exit()

    # ps = list(itertools.permutations(Image_files))
    # print(ps)
    # print(len(ps))

    # for image_file in Image_files:
    #     with open(image_file, 'rb') as f:
    #         b = f.read()
    #         i = 0
    #         while not b[i]:
    #             i += 1
    #         print(image_file, i)
    # 3D8qN9DH91Q.img 262144
    # 3RlmViivyG8.img 448
    # 60kE0MQisyY.img 448
    # IrYp6co7Gos.img 263169
    # QjTgmgmwXAM.img 262144

    pass

    # Exclude the parity disk and assemble a raid0 array

    # Because both 3RlmViivyG8.img and 60kE0MQisyY.img contains a protective-MBR, I guess one of them is the first disk and the other is parity disk

    # first_disk_candidates = [1, 2]
    # subsequent_disks = [0, 3, 4]
    first_disk_candidates = [1]
    # subsequent_disks = [0, 2, 3, 4]
    # When chunk size is less or equal to 256, 1 as the first disk will return "probably corrupted filesystem on /dev/mapper/md0p1", while 2 as first disk always return "wrong fs type, bad option, bad superblock on /dev/mapper/md0p1, missing codepage or helper program, or other error."

    # chunk_size = 4
    chunk_size = 512
    while chunk_size <= 2 ** 20:
        for first_disk in first_disk_candidates:
            # for subsequent_permutation in itertools.permutations(subsequent_disks):
            #     order = [first_disk, *subsequent_permutation]
            for permutation in itertools.permutations(range(5)):
                # order = permutation[:4]
                order = permutation
                print(chunk_size, order)
                # For chunk size of RAID5, the default is 512KB, and should be a power of 2 and not less than 4KB.
                # subprocess.check_call(['sudo', 'mdadm', '--build', '/dev/md0', f'--chunk={chunk_size}K', '--level=raid0', '--raid-devices=4', *(f'/dev/loop{i}' for i in order)])
                # subprocess.check_call(['sudo', 'mdadm', '--create', '/dev/md0', f'--chunk={chunk_size}K', '--level=raid5', '--raid-devices=4', '--spare-devices=1', *(f'/dev/loop{i}' for i in order)])
                subprocess.check_call(['sudo', 'mdadm', '--assemble', '--force', '/dev/md0', f'--chunk={chunk_size}K', '--level=raid5', '--raid-devices=4', '--spare-devices=1', *(f'/dev/loop{i}' for i in order)])
                output = subprocess.check_output(['sudo', 'kpartx', '-va', '/dev/md0'])

                # if len(output) < 2:
                #     # retry
                #     time.sleep(1)
                #     output = subprocess.check_output(['sudo', 'kpartx', '-va', '/dev/md0'])

                if len(output) < 2:
                    print('Failed to read partition')

                done = False
                if len(output) >= 2:
                    try:
                        subprocess.check_call(['sudo', 'mount', '/dev/mapper/md0p1', 'mnt'])
                        print('Mount succeeded')
                        while True:
                            a = input('Continue?')
                            if a == 'n':
                                done = True
                                break
                            elif a == 'y':
                                break
                        subprocess.check_call(['sudo', 'umount', 'mnt'])
                    except subprocess.CalledProcessError:
                        pass

                subprocess.check_call(['sudo', 'kpartx', '-d', '/dev/md0'])
                subprocess.check_call(['sudo', 'mdadm', '--stop', '--scan'])
                time.sleep(0.1)

                # if len(output) < 2:
                #     exit(1)

                if done:
                    return
        chunk_size *= 2

    # subprocess.check_call(['sudo', 'losetup', '-D'])


if __name__ == '__main__':
    main()
