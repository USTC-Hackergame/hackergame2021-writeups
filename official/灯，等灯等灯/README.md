# 灯，等灯等灯

题解作者： [djh](https://github.com/emc2314)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：math

- 题目分值：Level 0（150）+ Level 1（200）+ Level 2（300）

- 题目链接：[http://202.38.93.111:12768/login?token={token}](http://202.38.93.111:12768/login)

没有听到吗？在耳边回荡着的钟声。

传闻中，远古文明能够捕猎闪电，将其封印在蜿蜒曲折的法阵中，用以驱动炼金术的最高成就——机械之心。

而在诸多机械之心的流派里，蔚蓝是曾经的王者。无信者窃取神明的奇迹，沉湎于蔚蓝创造出来的虚幻之间，得以逃避残酷的现实。

只是，火已渐熄，位不见王影。那一抹纯净的蔚蓝也逐渐染上铜锈和铁锈的颜色。破落的圣殿中只剩无名的巡礼者，还在追寻当年先知摩尔留下的足迹。

此时才明白，那则预言的含义：火焰熄灭之时，钟声响起，余灰纷沓而来，解开沉寂千年的机关，点亮传承的图腾。无火的余灰不能成为柴薪，可也许正因这样，才会如此向往光明吧。

还没有听到吗？那回荡在耳边的，古老而熟悉的，钟声——

灯，等灯等灯

## 题解
本题思路来源于 [Lights Out](https://www.wikiwand.com/en/Lights_Out_(game)) 游戏，只不过把灯的亮度从只有 “开-关” 的两级改成了 256 级。以类似的做法，每一个灯的点击次数对其他灯的亮度的影响都是线形的，故而可以用一个模 256 的 $144 \times 144$ 矩阵-向量乘法表示。第一问很简单，只需求解一个模 256 的线性方程组即可。以下代码需要在 [Sagemath](https://www.sagemath.org/) 中运行。（SageMath 是一个非常强大的开源符号计算软件，也常见于诸多学术论文中）
```python
N = 12
F = Zmod(256) # 模 256 的整数环

def id2rc(i):
    assert i >= 0
    assert i < N^2
    return (i//N, i%N)

def rc2id(r,c):
    if r < 0 or r >= N or c < 0 or c >= N:
        return -1
    return r*N + c

def vec2matrix(v):
    M=Matrix(F,N,N)
    for i in range(N):
        for j in range(N):
            M[i,j] = v[rc2id(i,j)]
    return M

def matrix2vec(M):
    v = []
    for i in range(N):
        for j in range(N):
            v.append(M[i,j])
    return v

weightMatrix = [
                  [0, 0, 1, 0, 0],
                  [0, 0, 2, 0, 0],
                  [1, 2, 3, 2, 1],
                  [0, 0, 2, 0, 0],
                  [0, 0, 1, 0, 0]
                ]

target = [[189, 189, 189, 189, 189 , 33 , 33 , 33, 189, 189, 189, 189],
          [189, 189, 189 , 33 , 33 , 33, 189 , 33 , 44, 189, 189, 189],
          [189, 189, 189, 189, 189 , 33 , 33 , 33 , 33, 189, 189, 189],
          [189, 189, 189, 189, 189 , 33, 189 , 33 , 33, 189, 189, 189],
          [189, 189, 189 , 33 , 33, 189, 189 , 33 , 33 , 33, 189, 189],
          [189, 134 , 33 , 33, 189, 189, 189, 189 , 33 , 33, 189, 189],
          [189, 144 , 33 , 33, 189, 189, 189, 189 , 33, 189, 189, 189],
          [189, 142 , 33 , 33, 189, 189, 189, 189 , 33 , 33 , 33, 189],
          [189, 100, 142 , 33, 189, 189, 189, 189 , 33 , 33 , 33, 189],
          [189, 142, 142, 189, 189, 189, 189, 189, 189 , 33, 189, 189],
          [189 , 59, 142 , 33, 189, 189, 189, 189 , 33, 189, 189, 189],
          [189, 189 , 33 , 33, 189, 189, 189, 189, 189, 189, 189, 189]]

L=Matrix(F,N^2,N^2) # 144 x 144 的矩阵
for i in range(N):
    for j in range(N):
        index = rc2id(i,j)
        for i2 in range(-2,3):
            for j2 in range(-2,3):
                if rc2id(i2+i,j2+j) >= 0:
                    L[index,rc2id(i2+i,j2+j)] = weightMatrix[2+i2][2+j2]

# 一行代码即可求解模 256 下的线性方程组
print(vec2matrix(L.solve_left(vector(F,target))))
'''
[127  98 128 120 232 117 161  82  41 141 137 137]
[ 54 109  93   9  44  57  86 153 197  16 123 252]
[144  71 104 156 178 116 243  99 208 183 215 139]
[198 245 136  38  50 254 254 109 200 240 175 155]
[160  54  51  36 136 153 207 233 112 207   7   0]
[ 99 181 100  91 185 225  25  47  29 219 155 140]
[ 92 182   8 210 133   5  51 229 241 144  47   7]
[  8 177 187  46  81 178 122 255 120 183 230  95]
[191 210 167 160 169 200 229 236 104 238   8 228]
[239   2  23 221 192 105 219 162  30  11 194 187]
[235 102 161  31 191 130 184 130  43 147 126 216]
[121 126 145  97 222 135 132 150 206  42 219  38]
'''
```
注意到有同学表示不知如何获取目标图案的亮度信息，一个有趣的方法是通过截图，每一个方块的像素值恰好等于其亮度。另外有些同学抱怨自己的鼠标不好，一个方块点错之后就需要再度点击 255 次。解决这个问题的方法是使用 Python 帮你提交：```sess.post(url+"/submit", data={"level":0,"solution":str(sol0)}).text```。

由于出题人的失误，第三问的正确做法会完美覆盖第二问的要求。使得几乎所有做出来第二问的同学都顺利通过了第三问（在此感谢几位因为各种原因卡在第三关的同学）。第二问的预期方法是通过一些传统的机器学习或者神经网络训练的算法，在此感谢 @豆豆 同学和 @zzh。下面给出使用模拟退火方法的解题脚本，这个脚本最多大概能到 300 左右。
```python
import numpy as np
import scipy.signal
import random
import math
import time

target = np.array([[189,189,189,189,189,33,33,33,189,189,189,189],
[189,189,189,33,33,33,189,33,44,189,189,189],
[189,189,189,189,189,33,33,33,33,189,189,189],
[189,189,189,189,189,33,189,33,33,189,189,189],
[189,189,189,33,33,189,189,33,33,33,189,189],
[189,134,33,33,189,189,189,189,33,33,189,189],
[189,144,33,33,189,189,189,189,33,189,189,189],
[189,142,33,33,189,189,189,189,33,33,33,189],
[189,100,142,33,189,189,189,189,33,33,33,189],
[189,142,142,189,189,189,189,189,189,33,189,189],
[189,59,142,33,189,189,189,189,33,189,189,189],
[189,189,33,33,189,189,189,189,189,189,189,189]], dtype=np.uint8)

disabled = [(2, 2), (3, 2), (4, 2), (3, 3), (3, 4), (4, 4), (2, 4), (9, 7), (9, 8), (9, 9), (8, 9), (8, 7), (7,7), (6, 7), (6, 8), (6, 9)]


kernel = np.array([
    [0, 0, 1, 0, 0],
    [0, 0, 2, 0, 0],
    [1, 2, 3, 2, 1],
    [0, 0, 2, 0, 0],
    [0, 0, 1, 0, 0],
], np.uint8)


def score(clicks):
    clicks = clicks.copy()
    # for x, y in disabled:
    #     clicks[x, y] = 0
    r = scipy.signal.convolve2d(clicks, kernel, 'same')
    return np.abs(r.astype(np.int32) - target).sum()


last_time = time.time()

r = 0.9999999

def run(i):
    while True:
        c = np.zeros((12, 12), np.uint8)
        T = 100
        best = 100000
        all_best = 100000
        all_best_c = None

        for t in range(1000000000):
            backup = c.copy()

            x = random.randrange(12)
            y = random.randrange(12)

            if (x, y) not in disabled:
                c[x, y] = random.randrange(256)

            s = score(c)
            T *= r
            if s < best or math.exp((best - s) / T) > random.random():
                best = s
                #if time.time() > last_time + 5:
                #    print()
                #    print(repr(all_best_c))
                #    print(scipy.signal.convolve2d(c, kernel, 'same').astype(np.int32) - target)
                #    print(c)
                #    print(s, all_best, t, T)
                #    last_time = time.time()
                if best < all_best:
                    all_best = best
                    all_best_c = c.copy()
            else:
                c = backup
            if T < 0.1:
                with open('lights_up_result.txt', 'a') as f:
                    print(all_best, file=f)
                    print(repr(all_best_c), file=f)
                    print(file=f)
                break

def reseed(i):
    random.seed()

from multiprocessing import Pool
pool=Pool(processes=16)
pool.map(reseed,range(16))
pool.map(run,range(16))
pool.close()
pool.join()
```

第三问的预期解法是格基归约。注意到禁止了几个点击处之后，几个线性基和模 256 的向量组成了一个格。而找到分数最低的图案相当于求解格上的 CVP 问题。但是由于出题人的失误，构造格时额外增加了 100 多个维度，使得 CVP 的结果远低于正确做法的水平。此处仅给出出题时参考代码，请选手移步阅读非官方的 Writeup。
```python
N = 12
F = Zmod(256)
def id2rc(i):
    assert i >= 0
    assert i < N^2
    return (i//N, i%N)

def rc2id(r,c):
    if r < 0 or r >= N or c < 0 or c >= N:
        return -1
    return r*N + c

def vec2matrix(v):
    M=Matrix(F,N,N)
    for i in range(N):
        for j in range(N):
            M[i,j] = v[rc2id(i,j)]
    return M

def matrix2vec(M):
    v = []
    for i in range(N):
        for j in range(N):
            v.append(M[i,j])
    return v

def calc_diff(target, current, norm=1):
    result = 0
    for i in range(N^2):
        result += abs(int(target[i]) - int(current[i]))^norm
    return result

def Babai_closest_vector(M, G, target):
    target = vector(target)
    small = target
    for i in reversed(range(M.nrows())):
        c = ((small * G[i]) / (G[i] * G[i])).round()
        small -=  M[i] * c
    return target - small

exclude = [
                  26,
                  28,
                  32,
                  33,
                  38,
                  40,
                  44,
                  50,
                  51,
                  52,
                  55,
                  56,
                  86,
                  87,
                  88,
                  91,
                  92,
                  93,
                  99,
                  103,
                  111,
                  115,
                  116,
                  117
                ]

weightMatrix = [
                  [127, 127, 127, 127, 127],
                  [127, 63, 63, 63, 127],
                  [127, 63, 31, 63, 127],
                  [127, 63, 63, 63, 127],
                  [127, 127, 127, 127, 127]
                ]

target = [[189, 189, 189, 189, 189 , 33 , 33 , 33, 189, 189, 189, 189],
          [189, 189, 189 , 33 , 33 , 33, 189 , 33 , 44, 189, 189, 189],
          [189, 189, 189, 189, 189 , 33 , 33 , 33 , 33, 189, 189, 189],
          [189, 189, 189, 189, 189 , 33, 189 , 33 , 33, 189, 189, 189],
          [189, 189, 189 , 33 , 33, 189, 189 , 33 , 33 , 33, 189, 189],
          [189, 134 , 33 , 33, 189, 189, 189, 189 , 33 , 33, 189, 189],
          [189, 144 , 33 , 33, 189, 189, 189, 189 , 33, 189, 189, 189],
          [189, 142 , 33 , 33, 189, 189, 189, 189 , 33 , 33 , 33, 189],
          [189, 100, 142 , 33, 189, 189, 189, 189 , 33 , 33 , 33, 189],
          [189, 142, 142, 189, 189, 189, 189, 189, 189 , 33, 189, 189],
          [189 , 59, 142 , 33, 189, 189, 189, 189 , 33, 189, 189, 189],
          [189, 189 , 33 , 33, 189, 189, 189, 189, 189, 189, 189, 189]]

target=matrix2vec(Matrix(ZZ,target))

avail = list(set(range(N^2)) - set(exclude))
avail.sort()

L=Matrix(F,len(avail),N^2) # len(avail) x N^2
for i in range(N):
    for j in range(N):
        index = rc2id(i,j)
        if index in avail:
            index = avail.index(index)
            for i2 in range(-2,3):
                for j2 in range(-2,3):
                    if rc2id(i2+i,j2+j) >= 0:
                        L[index,rc2id(i2+i,j2+j)] = weightMatrix[2+i2][2+j2]

mindiff = (F.cardinality()-1)*N^2
minans = []
from multiprocessing import Pool

threads=16

def run(i):
    LL = block_matrix(ZZ, [[L,1],[F.cardinality(),0]])
    for i in range(30):
        ia = randint(0, len(avail)+N^2-1)
        ib = randint(0, len(avail)+N^2-1)
        if ib == ia:
            ib = (ib + 1) % (len(avail)+N^2)
        val = randint(-10, 10)
        LL[ia] += val * LL[ib]

    B = LL.LLL()
    G = B.gram_schmidt()[0]
    ans = Babai_closest_vector(B, G, target+[(F.cardinality()-1)/2 for _ in range(len(avail))])
    diff = calc_diff(ans, target)
    return (ans, diff)

def reseed(i):
    set_random_seed()

pool=Pool(processes=threads)
pool.map(reseed,range(threads))
data = pool.map(run,range(16))
pool.close()
pool.join()
minans, mindiff = sorted(data, key=lambda x: x[1])[0]
```

## 后记
本题还存在资源加载的问题，在使用 SwitchyOmega 时可能触发 CORS。以及可能存在部分同学的网络环境不佳，无法加载字体的情况。在此对给同学们造成的不便致歉。

另外还有同学询问，目标图案究竟是什么，出题人表示这么明显的企鹅看不出来吗（
![USTCLUG LOGO](logo.png)