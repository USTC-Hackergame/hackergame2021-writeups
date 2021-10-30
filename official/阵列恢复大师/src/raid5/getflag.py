#!/usr/bin/env python3

# Flag is here.
# Don't peek in my file, as they are my privacy.
# Just execute me to get flag please!

import hashlib
import os
import sys

ans = ""
paths = []

if __name__ == '__main__':
    path = os.environ.get("FILES", "./files/")
    if not os.path.exists(path):
        print("files folder not found: set FILES environment variable if you are not in the root of my disk image.")
        sys.exit(-1)
    for root, dirs, files in os.walk(path):
        for filename in files:
            if filename == '.DS_Store':
                continue
            filepath = os.path.join(root, filename)
            paths.append(filepath)
    paths.sort()
    for filepath in paths:
        h = hashlib.sha256()
        with open(filepath, 'rb') as f:
            while True:
                chunk = f.read(h.block_size)
                if not chunk:
                    break
                h.update(chunk)
        hexdigest = h.hexdigest()
        print(filepath, hexdigest)
        ans += hexdigest
    check = hashlib.sha256(ans.encode("utf-8")).hexdigest()
    if check == "df81eca70a025e5f2b5d3ba56ac1289b2112a1c041cbe1b199ac5a8049fbf9d7":
        print("Flag:", f"flag{{{hashlib.md5(ans.encode('utf-8')).hexdigest()}}}")
    else:
        print("Did you recover my data correctly?")
