import hashlib
import random
import requests
from tqdm import tqdm
from Crypto.Cipher import ARC4

programs = []
for i in range(4):
    for j in range(32):
        programs.append(f"向右 1 步\n拿起 4 个物品\n向左 100 步\n放下 1 个物品\n放下 1 个物品\n放下 1 个物品\n放下 1 个物品\n向右 {i+1} 步\n拿起 1 个物品\n向左 100 步\n放下 1 个物品\n向右 {j+1} 步\n拿起 1 个物品\n向左 100 步\n放下 1 个物品")

programs = programs[:-1]
programs = [x.strip() for x in programs]

print(len(programs)) # 127

hash = lambda s: hashlib.sha256(s.encode()).hexdigest()
nextint = lambda rng: int.from_bytes(rng.encrypt(b"\x00" * 4), "big") % 32

fixed_hashes = '\n'.join(list(map(hash, programs)))
s = None
for _ in tqdm(range(9000000)):
    nonce = random.randint(0, 99999999999)
    s = '# nonce = ' + str(nonce)
    program_hashes = fixed_hashes + '\n' + hash(s)
    seed = hash(program_hashes)
    rng = ARC4.new(seed.encode(), drop=256)
    if any(nextint(rng) != 0 for _ in range(4)):
        continue
    if nextint(rng) >= 4:
        continue
    else:
        print(s, seed)
        break

all_programs = programs + [s]
program_hashes = '\n'.join(map(hash, all_programs))
seed = hash(program_hashes)
rng = ARC4.new(seed.encode(), drop=256)
recipe = [nextint(rng) for _ in range(6)]
exe_id = recipe[4] * 32 + recipe[5]
print(recipe, exe_id, programs[exe_id])

# 直接调用验证接口
TOKEN = "11:..."
ret = requests.post("http://202.38.93.111:12077/verify", json={'token': TOKEN,'level':2, 'seed': seed, 'programs': all_programs,'executions': [exe_id]})
print(ret.text)
