# HackerGame 2021 WP

作者：Crabtux / 忧郁沙茶

赛时 ID：呜呜呜 #MUSTC科大音游小栈 群号 44834360

## 正文

### 签到
用类似二分的做法爆破就行。

### 进制十六——参上
网页识图把十六进制字符搞出来，扔进 010 Editor。

### 去吧！追寻自由的电波！
我用的是 Audacity 降速，成功降调了，能直接听出来。

### 猫咪问答 Pro Max
T1：互联网档案馆

T3：USTC LUG 官网，活动室搬迁

T2、T4、T5：Google

### 卖瓜
利用整型溢出，把秤上的重量调到 “与 20 的距离恰好被 3 整除的负数”。

然后再往上加即可。

### 透明的文件
对着 ANSI escape code 的格式改。

### 旅行照片
蓝色的 KFC 是突破口。

百度搜索可以得知具体店铺的信息，百度街景可以获取附近区域的实景信息。这样 T4、T5 的答案就很容易确定了。

T1、T2 是常识，T3 没法确定，只能爆破。

### FLAG 助力大红包
~~欲盖弥彰了属于是~~

~~没错，我说的就是官方题解~~

我对网络一窍不通，如果写得有啥问题，请轻喷。

前后端识别指的是：
- 前端调用一个 API 获取 IP 地址，并在点击链接的时候通过传参数的方式传递给后端
- 后端通过某些玄学方法（草我也不懂，可能跟包的传输有关）获取源 IP 地址
- 前后端获得的 IP 地址进行比较，判断是否助力成功

我的解决方案是用 Python 发送 POST 请求，只需要：
- 在请求头加一个 XFF 头，伪造一个 IP 地址丢进去
- 传参的时候把 IP 地址改成和 XFF 头一样的 IP 地址

按照以上步骤，即可从任意 IP 地址完成助力。

注意到活动规则中提到：
> 每个用户只能够助力一次。为了建设世界一流大砍刀平台，活动要求位于同一 /8 网段的用户将会被视为同一个用户。（比如 IP 地址为 202.38.64.1 和 202.39.64.1 将被视为同一用户。）达到助力次数上限后，将无法再帮助好友助力。

那就把 /8 网段的 IP 地址全跑一遍好了。跑完才能拿到 flag。

附上代码（Python）：
```
import requests
import time

header = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0',
    'X-Forwarded-For': '',
    'Origin': 'http://202.38.93.111:10888',
    'DNT': '1',
    'Connection': 'close',
    'Referer': 'http://202.38.93.111:10888/invite/ba9ebe2b-351d-4c65-8391-db325c13d17b',
    'Cookie': 'eyJ0b2tlbiI6IjEyNjc6TUVVQ0lRQy9mMnFNTUo0Q1dDOXg0N1YvYzdoazAvNDFoQVduSVJvcWNUK0JhUTNUM3dJZ0xONXU1VFRzUHdwQlVKdnBab2NFWFg0UzAySnQ4d09DYy92c3lmUWl3T2c9In0:1me8d6:itN3T7cxY5fL7Vdr6-aaFZmLjW65C_G3N1_k-G6saTU; csrftoken=kGaFCfhHsJPCfSZh2VbRRFyeuqz2b0JNSb9JBkqmZT3raIG7npoMUXVsPxtZIhf7; PHPSESSID=0dc4fb11c21c083de000de7053b20372; session=eyJ0b2tlbiI6IjEyNjc6TUVVQ0lRQy9mMnFNTUo0Q1dDOXg0N1YvYzdoazAvNDFoQVduSVJvcWNUK0JhUTNUM3dJZ0xONXU1VFRzUHdwQlVKdnBab2NFWFg0UzAySnQ4d09DYy92c3lmUWl3T2c9In0.YXPlRA.Dg66QXWVfHaUhTOAzWOYhLUXqkw'
}

urls = 'http://202.38.93.111:10888/invite/ba9ebe2b-351d-4c65-8391-db325c13d17b'

for i in range(0,256):
    header['X-Forwarded-For'] = str(i) + '.222.233.233'
    datas = {"ip": str(i)+'.222.233.233'}
    res = requests.post(headers=header, url=urls, data=datas)
    time.sleep(1)
    print(res.text)
```

### Amnesia
#### 轻度失忆
没查资料，直接用了 putchar 和字符变量进行输出。

### 图之上的信息
Google 一下 GraphQL Hack 就能知道所有能查询的属性。

直接传参查询就行。

### Easy RSA
~~非常抱歉，我实在懒得写这题的题解了，直接上代码算了，反正也没人看~~

显然，这是一道数论题。

求 P 要用到 Wilson 定理的推论和乘法逆元。

求 Q 和最终的 data 要用到离散对数（实际上就是两边取离散对数的操作而已）和乘法逆元。

求 P 的代码（Python）：
```
# -*- coding: UTF-8 –*- 
from Crypto.Util.number import isPrime

def EX_GCD(a,b,arr): #扩展欧几里得
    if b == 0:
        arr[0] = 1
        arr[1] = 0
        return a
    g = EX_GCD(b, a % b, arr)
    t = arr[0]
    arr[0] = arr[1]
    arr[1] = t - int(a / b) * arr[1]
    return g

def ModReverse(a,n): #ax=1(mod n) 求a模n的乘法逆x
    arr = [0,1,]
    gcd = EX_GCD(a,n,arr)
    if gcd == 1:
        return (arr[0] % n + n) % n
    else:
        return -1

# a 大一点
a = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391760451
b = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391661439

niubi = - 1

for i in range(b + 1, a):
    temp = ModReverse(i, a)
    niubi = (niubi * temp) % a

if niubi < 0:
    niubi += a

for i in range(niubi + 1, niubi + 100000):
    if isPrime(i):
        print(i)
        break
```

求 Q 的代码（Python）：
```
# -*- coding: UTF-8 –*- 
from Crypto.Util.number import isPrime

prime_9 = 80096058210213458444437404275177554701604739094679033012396452382975889905967
value_q = 5591130088089053683141520294620171646179623062803708281023766040254675625012293743465254007970358536660934858789388093688621793201658889399155357407224541324547522479617669812322262372851929223461622559971534394847970366311206823328200747893961649255426063204482192349202005330622561575868946656570678176047822163692259375233925446556338917358118222905050574458037965803154233167594946713038301249145097770337253930655681648299249481985768272321820718607757023350742647019762122572886601905212830744868048802864679734428398229280780215896045509020793530842541217790352661324630048261329493088812057300480085895399922301827190211956061083460036781018660201163819104150988531352228650991733072010425499238731811243310625701946882701082178190402011133439065106720309788819
primes = [prime_9]

def EX_GCD(a,b,arr): #扩展欧几里得
    if b == 0:
        arr[0] = 1
        arr[1] = 0
        return a
    g = EX_GCD(b, a % b, arr)
    t = arr[0]
    arr[0] = arr[1]
    arr[1] = t - int(a / b) * arr[1]
    return g

def ModReverse(a,n): #ax=1(mod n) 求a模n的乘法逆x
    arr = [0,1,]
    gcd = EX_GCD(a,n,arr)
    if gcd == 1:
        return (arr[0] % n + n) % n
    else:
        return -1

num = 1
for i in range(prime_9 - 1, prime_9 - 100000, -1):
    if isPrime(i):
        primes.append(i)
        num += 1
    
    if num == 10:
        break

n = 1
nn = 1
primes = primes[::-1]
for i in primes:
    n *= i
    nn *= (i - 1)

expp = ModReverse(65537, nn)
q = pow(value_q, expp, n)

print(q)

for i in range(q + 1, q + 100000):
    if isPrime(i):
        print(i)
        break
```

求 flag 的代码（Python）：
```
# -*- coding: UTF-8 –*- 

# 扩展欧几里得求逆元
def exgcd(a, b):
    if b == 0:
        return 1, 0, a
    else:
        x, y, q = exgcd(b, a % b)
        x, y = y, (x - (a // b) * y)
        return x, y, q

# 扩展欧几里得求逆元
def ModReverse(a,p):
    x, y, q = exgcd(a,p)
    if q != 1:
        raise Exception("No solution.")
    else:
        return (x + p) % p #防止负数


p = 10569944080090591401315432556965818857327680380269154543273468441025963038065648915158194147019839932524599260058098616377893091051396090650574162446875263
q = 10477925992460766451892208516181598312750484426056814542870756188277177949099084361476539803367804757559880919838828678145609717295215924948786830953571811
c = 110644875422336073350488613774418819991169603750711465190260581119043921549811353108399064284589038384540018965816137286856268590507418636799746759551009749004176545414118128330198437101472882906564195341277423007542422286760940374859966152871273887950174522820162832774361714668826122465471705166574184367478
test = 3338241147601905675961845375760830741082637481762357299890556168228051452057836433529928514826

wori = (p - 1) * (q - 1)
expp = ModReverse(65537, wori)
print((expp * 65537) % wori)

m = pow(c, expp, p * q)
print(m)
gg = m.to_bytes(length=200, byteorder="big")
print(gg)
```

### 加密的 U 盘
Google LUKS 可知，改密码并没有什么吊用。

直接把 day1.img 的 LUKS 头换给 day2.img 就可以用原来的密码打开文件了。

~~新时代接头霸王吗~~

反而是如何正常使用 day1.img 费了我绝大多数的时间，毕竟我对 Linux 不太熟悉。

这里附上对此帮助很大的网页：<https://unix.stackexchange.com/questions/504230/mount-encrypted-partition-of-an-image-file>

### minecRaft
~~这题跟 Minecraft 有什么关系吗（~~

F12 翻 JS 代码可以发现，对于输入的字符串：
- 第一个字母如果是大写的 M，可以点亮前两盏灯。
- 如果其长度大于等于 32，并且通过了 gyflash 函数的测试，就可以点亮第三盏灯。

滚去翻 gyflash 函数，这令人不忍直视的函数名和变量名，显然是经过了混淆。

虽然很明显，这些名字都是十六进制数，但是直接翻成 ASCII 貌似不太行。

这里我就直接连蒙带猜外加分析了，最终**猜测** gyflash 的大致流程为：

0. 输入字符串
1. 8 个字符切片，分成两组 4 个字符，转成 Long
2. 对两组 4 个字符同时进行 code 函数的处理
3. 将 code 结果转成两组 8 位 base16 加入进去

绝妙的是，上述步骤完全可逆（虽然 code 函数得好好看看，我那时候哪知道有 TEA 这样的加密方式）。

为了确保不出岔子，我在原 JS 代码的基础上修改了一下，在本地跑出了明文。

因为在同样的 JS 代码上修改了多次，我无法给出解密的代码了。

### 超 OI 的 WriteUp 模拟器
#### 果然还是逆向比较简单（真的逆向了）
~~年轻人的第一次逆向~~

~~年轻人根本没想到还有自动化逆向这种离谱的操作~~

下载文件，用 IDA 打开，直接看 main 函数，汇编不太熟，所以 F5 看伪代码。

总之就是输入一个字符串，并且如果：
- 长度等于 17（实际上不计算末尾的话，输入的字符串长度应该是 16）
- 通过 sub_1420 函数的检验

则这个字符串就是正确的 code。

滚去翻 sub_1420 函数，~~WDNMD，这熟悉的味道~~，显然这玩意也被混淆了。

大胆猜测这个函数的执行顺序与输入无关，拖到 C 语言的 IDE 里面，跑一遍单步调试，结果喜人，函数可以简化如下：
```
unsigned __int64 sub_1160(__int64 a1, __int64 a2, unsigned __int64 a3, unsigned __int64 a4)
{
    unsigned __int64 v4; // rbp
    
    for (int i = 1; i <= 12; i++){
        v4 = a3 ^ ((0xBD7C314368E2199FLL * (a4 | 0xEB0B677FB0D42156LL)) | 1);
        a3 = a4;
        a4 = v4;
        printf("%lld %lld\n", a3, a4);
    }

    a4 = ((0xCAAD5AB28237193DLL * a3) ^ 0x9E67E274EFE555F9LL | a3 & 0xCAAD5AB28237193DLL ^ 0x408910200231012DLL | (0xA00AB088D60E4BA1LL * a4) ^ 0xFC339CFD2A635DA7LL | a4 & 0xA00AB088D60E4BA1LL ^ 0xA900846004001LL) != 0;
    printf("%lld %lld\n", a3, a4);
    return a4;
}
```

现在，只需要让返回的 a4 等于 0 就可以了。

很显然，经过一顿分析我们发现，这个函数的输入的参数 a3 和 a4 分别代表了：输入的字符串的二进制表示，从中间劈开均分成两半，转成 64 位整型数字的结果。

因此，我们必须解出这样的 a3 和 a4，使得函数的返回值等于 0。

第一步，我们显然要解出这样一个方程组：
- a3 * 0xCAAD5AB28237193DLL == 0x9E67E274EFE555F9LL
- a3 & 0xCAAD5AB28237193DLL == 0x408910200231012DLL
- a4 * 0xA00AB088D60E4BA1LL == 0xFC339CFD2A635DA7LL
- a4 & 0xA00AB088D60E4BA1LL == 0xA900846004001LL

以上运算均在 64 位整型域内完成。

~~第二个爆破代码跑了我一个多小时，而且牵扯到我某些不好的回忆~~

爆破代码 1（C 语言）：
```
#include <stdio.h>
#include <stdint.h>
char wokao[105] = "1010000000001010101100001000100011010110000011100100101110100001";
unsigned __int64 origin = 0xA00AB088D60E4BA1LL;
// andresult:0x000A900846004001
char wori[105] = "0000000000001010100100000000100001000110000000000100000000000001";
// multiplyresult
unsigned __int64 fuckyou = 0xFC339CFD2A635DA7LL;
int sign[105] = {0};

void calculate(int layer, unsigned __int64 nima){
    if (layer == 64){
        if (nima * origin == fuckyou){
            printf("%llu\n", nima);
        }
        return;
    }
    unsigned __int64 temp = 1LL;
    temp <<= layer;

    if (wokao[63 - layer] == '0' && wori[63 - layer] == '0'){
        calculate(layer + 1, nima + temp);
        calculate(layer + 1, nima);
    }
    
    else if (wokao[63 - layer] == '1' && wori[63 - layer] == '1'){
        calculate(layer + 1, nima + temp);
    }
    
    else if (wokao[63 - layer] == '1' && wori[63 - layer] == '0'){
        calculate(layer + 1, nima);
    }
}

int main(void){
    int cnt = 0;

    calculate(0, 0LL);
    return 0;
}
```

爆破代码 2 和 爆破代码 1 基本一致，这里就不放了。

这样即可求出在函数中被循环处理之后的 a3 和 a4。

第二步，对上述得到的 a3 和 a4 进行逆处理，代码如下（C 语言）：
```
#include <stdio.h>
#include <stdint.h>

int main(void){
    unsigned __int64 a3, a4, v4;
    a3 = 6979190900151903085;
    a4 = 5935342296973304903;

    for (int i = 1; i <= 12; i++){
        // v4 = a3
        v4 = a4 ^ ((0xBD7C314368E2199FLL * (a3 | 0xEB0B677FB0D42156LL)) | 1);
        a4 = a3;
        a3 = v4;

        printf("%llu %llu\n", a4, a3);
    }

    return 0;
}
```

第三步，把 a3 和 a4 换个编码就行了。

注意一下关于大端法和小端法表示的问题！在 Windows 下求解出来的两个 64 位字符串需要分别逆序输出！

然后本题就结束了。

## 胡扯
感谢 Hackergame 的全体工作人员，让年轻人也能体会到切题的快感~~和整活的乐趣~~。

虽然由于实力有限~~（Python 厨力不够）~~，名次不能说是很好看~~（但也不难看就是了）~~，但我从这次比赛中确实学到了不少东西（不只是技术上的）。

卷子质量很好，明年还来。

~~只要我明年不被退学~~

~~尝试交题解的时候甚至发现自己连 Github 都用不来~~