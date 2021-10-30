import glob
import functools

disks = glob.glob("*.img")
disks = [open(i, 'rb') for i in disks]
stripe = 64 * 1024
offset = 0

def xor(p1, p2):
    return bytes(a ^ b for a, b in zip(p1, p2))

for i in disks:
    i.seek(offset)

while True:
    buffer = []
    for idx, i in enumerate(disks):
        if idx != len(disks) - 1:
            c = i.read(stripe)
            if c:
                buffer.append(c)
            else:
                if idx == 0:
                    print("done")
                    exit(0)
                else:
                    print("unexpected end")
                    exit(1)
        else:
            parity = i.read(stripe)
            parity2 = functools.reduce(xor, buffer)
            if parity != parity2:
                print("warn")
