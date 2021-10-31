import numpy as np

words = open('mnemonic-phrase/input.log','r').read().split('\n')

def hash_np(s):
    h = np.int32(0)
    for c in s:
        h = np.int32(31 * h + ord(c))
    return h

hash_dict = {}

for word in words:
    hashcode = str(hash_np(word) * 31)
    if hashcode in hash_dict.keys():
        hash_dict[hashcode].append(word)
    else:
        hash_dict[hashcode] = [word]

import json

with open('mnemonic-phrase/outhash.json','w') as f:
    json.dump(hash_dict, f)
