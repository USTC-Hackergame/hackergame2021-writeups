import random
import functools

disks = [
    "./disks/3RlmViivyG8.img",
    "./disks/IrYp6co7Gos.img",
    "./disks/3D8qN9DH91Q.img",
    "./disks/QjTgmgmwXAM.img",
    "./disks/60kE0MQisyY.img",
]
stripe = 64 * 1024  # 64kb
ptr = 0

for i in range(len(disks)):
    disks[i] = open(disks[i], "wb")

buffer = []

def xor(p1, p2):
    return bytes(a ^ b for a, b in zip(p1, p2))

with open("tmp/disk.img", "rb") as f:
    # implement left-symmetric layout
    stop = False
    while True:
        c = f.read(stripe)
        if c:
            disks[ptr % len(disks)].write(c)
            buffer.append(c)
            ptr += 1
        else:
            stop = True
        if len(buffer) == len(disks) - 1:
            parity = functools.reduce(xor, buffer)
            disks[ptr % len(disks)].write(parity)
            buffer = []
        if stop:
            print(len(buffer))
            break


if len(buffer) != 0:
    print("Wrong disk size?")

random.shuffle(disks)

for i in disks:
    i.close()
