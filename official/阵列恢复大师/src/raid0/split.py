import random

disks = [
    "./disks/wlOUASom2fI.img",
    "./disks/jCC60mutgoE.img",
    "./disks/1GHGGrmaMM0.img",
    "./disks/5qiSQnlrA4Y.img",
    "./disks/d3Be7V0EVKo.img",
    "./disks/eRL2MQSdOjo.img",
    "./disks/RApjvIxRlu0.img",
    "./disks/ID7sM2RWkyI.img",
]
stripe = 128 * 1024  # 128kb
ptr = 0

for i in range(len(disks)):
    disks[i] = open(disks[i], "wb")

with open("tmp/disk.img", "rb") as f:
    while True:
        c = f.read(stripe)
        if c:
            disks[ptr].write(c)
        else:
            break
        ptr = (ptr + 1) % len(disks)

if ptr != 0:
    print("Wrong disk size?")

random.shuffle(disks)

for i in disks:
    i.close()
