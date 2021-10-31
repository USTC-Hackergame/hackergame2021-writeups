# Writeups

## 前言

久仰 Hackergame 大名，虽然今年是预定摸了的，但是有个朋友拉我来打，打着打着我自己上头了，也就认真搞了。

CTF noob 第一次打相关类型的比赛，幸好运气好拿到了 67 名的好成绩（至少对我这个水平来说）。学到很多东西，跟算法竞赛的体验还是不一样的，以后有时间可以多打。

_Fully rendered at: <https://blog.lxdlam.com/post/f37e3945>_

## 签到

点进去玩两下发现是 Unix timestamp，随便 `date +%s` 一下拼回 URL 就有了。

## 进制十六——参上

OCR 然后 `xxd`。或者拿 python 转一下。

## 去吧！追寻自由的电波！

原音频加过速，直接 Audacity（没有 Audition，懒得装了）0.36x 速度重放一下就全能听清了，代表什么可以参考[字母表](https://zh.wikipedia.org/wiki/%E5%8C%97%E7%BA%A6%E9%9F%B3%E6%A0%87%E5%AD%97%E6%AF%8D)。

## 猫咪问答 Pro Max

搜索题，善用 WebArchive。

## 卖瓜

PHP 整数溢出漏洞，玩几个数撞一下就行，我已经忘了我怎么撞出来的了。

撞的时候要注意，过了 int 的范围会被提升为 float，然后就不符合题目要求了。

## 透明的文件

进去一看就两个问题：
- `[` 前面应该拼一个 `\033`；
- 把空格换成任意可显示字符。

然后 `cat flag.txt` 就可以了。

~~我 zsh 的主题下 flag 会一闪而过，我拿 Quicktime 录屏看的。~~

## 旅行照片

社工题。图片里面特征最明显的就是 KFC，搜出来 KFC 店名之后可以在大众点评或者地图网站找到电话，以及能在地图网站上找到。

一个比较坑的点是地图网站显示的是店的地址而不是这个甜品站的地址~~（虽然好像也没啥问题）~~，所以你需要高德或者谷歌，打开卫星图定位到具体位置，然后方位就有了，有了方位看下阳光就能大概知道时间了。

最后楼层是暴力的，提示就是不要猜太高，也不要猜太低。

## FLAG 助力大红包

256 个助力一次都不能少。

进去看一下代码就知道他 Post 的时候会带一个 `ip=x.x.x.x` 的 FormData，直接改掉就 OK。然后就是后端识别 ip，猜了一下是看 X-Forwarded-For Header，试了下果然如此，那就两个都改掉直接发请求就完了。

这个题最坑的地方是有频控，发的太快会被干掉。我 `sleep(2)` 在接近十分钟结束的位置凑够了就过了，但是根据朋友的说法频控条件其实挺简单的，试出来了不需要这么久。~~懒狗过了就行。~~

```python
import requests
from time import sleep

# 助力地址
URL = ""

for i in range(256):
    requests.post(URL,
                  data={"ip": f"{i}.0.0.1"},
                  headers={"X-Forwarded-For": f"{i}.0.0.1"})
    sleep(2)
```

## Amnesia

### 轻度失忆

因为 [Immediate Value](https://en.wikichip.org/wiki/immediate_value) 会把 constant 的 number 直接放指令里，不会存 `.data` 和 `.rodata`，所以直接给 `Hello, world!` 按 ASCII 给 putchar 出去就完事儿了。

### 记忆清除

汇编 noob，靠 [Compiler Explorer](https://godbolt.org/) + Google 过的这个题。

首先先把 docker 拉下来，然后随便写个代码跑一下 `objdump -d`，观察到：

![image](https://user-images.githubusercontent.com/7735691/139191658-7e5d1837-543f-4c59-a390-8d1a93119407.png)

`.text` 之后就直接跳到 `.fini` 了，那么基本思路就是想办法弄段汇编塞到 `.fini` 之前，正确输出就可以了。

汇编比较简单，根据[这篇博客](https://jameshfisher.com/2018/02/20/c-inline-assembly-hello-world/)和 x86 的 syscall [表](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)，实际上就是 call 一下 `write` 就行。

很容易写出来下面这段：

```asm
print:
    mov $4, %eax
    mov $1, %ebx
    mov $.LC0, %ecx
    mov $13, %edx
    int $0x80

.LC0:
    .string "Hello, world!"
```

然后关于放哪儿，一开始想用 `__attribute__((constructor))` 给放到 `.init` 里面去，后面发现好像这玩意儿要过一下 libc 的一些东西，然后 libc 会放到 `.text` 里，这段代码根本跑不到。之后又搜了一下，发现了 `__attribute__((section("name")))` 这个东西，随便搞了搞试了一下好像会放到 `.text` 之前，然后就基本搞定了，写了下面这段代码：

```c
__attribute__((section("SEC"))) void print() {
  asm("mov $4, %eax; mov $1, %ebx; mov $.LC0, %ecx; mov $13, %edx; int $0x80; "
      ".LC0: .string \"Hello, world!\"");
}

int main() {}
```

不负众望的 crash 掉了。

`objdump -d` 了一下：

![image](https://user-images.githubusercontent.com/7735691/139193814-7355c260-6491-456e-84e2-d1da9ece1e04.png)

发现这玩意儿没对齐，接到上一个指令里面去了……，加了个 `.align 2;` 就正常输出了，但还是 crash。gdb 跟了一下，发现没有正常返回，那其实都不用返回，直接退出就完了，在后面补了一个 `exit` 的 system call 就过了。

Solution：


```c
__attribute__((section("SEC"))) void print() {
  asm(".align 2; mov $4, %eax; mov $1, %ebx; mov $.LC0, %ecx; mov $13, %edx; int $0x80; mov $1, %eax; mov $0, %ebx; int $0x80; "
      ".LC0: .string \"Hello, world!\"");
}

int main() {}
```

~~但是看 flag 内容，感觉这个不太像 expected solution 啊？~~

## 图之上的信息

GraphQL 能把 Schema 拿出来，所以先 `__Schema` 把类型查出来，发现目标应该是 `GUser`，然后查一下 `GUser` 的字段，看到邮箱是 `privateEmail`。那么用 `userid: 1` 的 query 把 `privateEmail` 拿出来就过了。

## Easy RSA

好久不打比赛，数论忘得一干二净。

一些预备知识可以参考[From gcd to RSA](https://blog.lxdlam.com/post/42be77f6/)。

### p

[Wilson 定理](https://oi-wiki.org/math/number-theory/wilson/)。

注意到 $x$ 是质数，显然 $(x-1)!\equiv x-1\pmod x$，又由于 $y! < (x-1)!$，那直接拿 $(x-1)$ 乘逆元乘回到 $y$ 就有结果了。

### q

$n$ 的每个质数可以直接通过 `sympy.prevprime()` 把 `value[-1]` 带进去拿出来。

考察解同余方程 $q^e\equiv q'\pmod n$。设 $q^{ke}\equiv q\pmod n$，根据欧拉定理有 $ke\equiv1\pmod{\phi(n)}$，根据欧拉函数性质以及 $n$ 是十个质数积的性质，很容易得到 $\phi(n)=\prod_{i=1}^{10}p_i$，然后针对 $\phi(n)$ 求一下 $e$ 的逆元得到 $k$，最后计算 $(q^{e})^k\mod n$ 就结束了。

Solution:

```python
import sympy

e = 65537


def solve_p():
    x = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391760451
    y = 11124440021748127159092076861405454814981575144744508857178576572929321435002942998531420985771090167262256877805902135304112271641074498386662361391661439

    p = x - 1
    for i in range(1, x - y):
        p = p * pow(x - i, x - 2, x) % x

    # p = 10569944080090591401315432556965818857327680380269154543273468441025963038065648915158194147019839932524599260058098616377893091051396090650574162446875193

    return sympy.nextprime(p)


def solve_q():
    value = [
        80096058210213458444437404275177554701604739094679033012396452382975889905967
    ]
    n = value[-1]
    phi = value[-1] - 1
    for i in range(1, 10):
        value.append(sympy.prevprime(value[-1]))
        n *= value[-1]
        phi *= value[-1] - 1

    k = sympy.mod_inverse(e, phi)

    q = 5591130088089053683141520294620171646179623062803708281023766040254675625012293743465254007970358536660934858789388093688621793201658889399155357407224541324547522479617669812322262372851929223461622559971534394847970366311206823328200747893961649255426063204482192349202005330622561575868946656570678176047822163692259375233925446556338917358118222905050574458037965803154233167594946713038301249145097770337253930655681648299249481985768272321820718607757023350742647019762122572886601905212830744868048802864679734428398229280780215896045509020793530842541217790352661324630048261329493088812057300480085895399922301827190211956061083460036781018660201163819104150988531352228650991733072010425499238731811243310625701946882701082178190402011133439065106720309788819
    q = pow(q, k, n)
    # q = 10477925992460766451892208516181598312750484426056814542870756188277177949099084361476539803367804757559880919838828678145609717295215924948786830953570263

    return sympy.nextprime(q)


if __name__ == "__main__":
    # p = solve_p()
    p = sympy.nextprime(
        10569944080090591401315432556965818857327680380269154543273468441025963038065648915158194147019839932524599260058098616377893091051396090650574162446875193
    )
    # q = solve_q()
    q = sympy.nextprime(
        10477925992460766451892208516181598312750484426056814542870756188277177949099084361476539803367804757559880919838828678145609717295215924948786830953570263
    )

    d = sympy.mod_inverse(e, (p - 1) * (q - 1))

    c = 110644875422336073350488613774418819991169603750711465190260581119043921549811353108399064284589038384540018965816137286856268590507418636799746759551009749004176545414118128330198437101472882906564195341277423007542422286760940374859966152871273887950174522820162832774361714668826122465471705166574184367478
    m = pow(c, d, p * q)
    print("m =", m)
    print(f'flag = {m.to_bytes((m.bit_length() + 7) // 8, byteorder="big")}')
```

## 加密的 U 盘

人生中第一次听说 LUKS，还挺牛逼的这东西。

[官方 FAQ 1.2 节](https://gitlab.com/cryptsetup/cryptsetup/-/wikis/FrequentlyAskedQuestions#1-general-questions)明确指出了同一块盘多次做镜像，master key 是不会变的，所以解密 day1 的镜像，dump 出来 master key 再解密 day2 的就能拿到 flag 了。

~~谁能想到这题最复杂的部分不是思路，而是学习软件操作和配环境呢？~~

## 赛博厨房

### Level 0

模拟，看图写代码。

### Level 1

直接写指令不够，用 `如果手上的物品大于等于 n 向上跳转 m 行` 做一个 `jmp` 就够了。

## 助记词

### 第一顿大餐

读代码看到暂停的位置是 `Phrase::equals()`，然后 `Phrase` 会被放进一个 `LinkedHashMap` 里面去，那也就是说加的词要尽可能多走 `equals`，那就是需要哈希碰撞。

看了下 `Phrase::hashCode()`，稍微审计一下发现 3 个元素只有 `text` 部分是可控的，所以考虑撞一下。

撞的过程比较简单，先笛卡尔积拼出来找到 hash 一样的，这样能把碰撞 double 一下，然后再和笛卡尔积的结果拼起来一起求一下就能找到好几个碰撞了。

之后卡壳了，想了半天这个最长的碰撞就 6 个，跑暴力的话跑到明年比赛结束都不一定跑完啊？

重新仔细读了一下代码：

```java
var before = System.nanoTime();
for (var i = 0; i < input.length() && i < MAX_PHRASES && phrases.size() < MAX_PHRASES; ++i) {
    var text = input.optString(i, "").toLowerCase(Locale.ENGLISH);
    modified += phrases.add(Phrase.create(this.mnemonics, text, token)) ? 1 : 0;
}
var after = System.nanoTime();
var duration = TimeUnit.MILLISECONDS.convert(after - before, TimeUnit.NANOSECONDS);
```

原来一次多传点就行，不是每次只能传一个。随便发个请求就结束了。

~~Token 记得正确 URL 转义，我直接复制粘贴交了好几发都没看到 flag，又读了一边代码。~~

Solution:

```python
import requests

URL = ""
# 预先找到的几个碰撞，其实应该还有更多
ITEMS = [
    "damage official text association", "category attention text association",
    "other income statement pair", "flight cause statement pair",
    "source return lake step", "save past lake step",
    "physical fishing while money", "working cash officer blood",
    "test school officer blood", "system investment management debate",
    "author stock while money", "exam mouse management debate"
]

print(requests.post(URL, data=f'{ITEMS[:32]}').json())
```

## Co-Program

### Co-Login

核心思路就是把 `target` 带进去之后，尽可能用乘 `0` 之类的形式把其他元消掉，只剩 `target`。

首先拉了 100 个 test case 看了一下，大部分都是简单的一元或者二元表达式，基本上就用几个可能的数拿进去 dfs 撞一下就能出结果。

先写个 parser 和 evaluator，evaluator 最基本的 RPN 应该就够了，然后全程该模 $2^{36}$ 的和需要用 $2^{36}$ 减回去的值都正确处理一下，剩下的撞就行。~~我之前抄了个语言，看了下 parser 是对的就直接搞了。

关于构件的 candidate，注意到有 `(j+j)`，`(i/j)` 和 `(i%j)` 这些式子，把 $0, 1, t, 2t, \frac{t}{2}$ 和对应的用 $2^{36}$ 减掉的值都塞进去，xjb 撞一下基本就过了（？。复杂度比较简单，构件总共 10 个，假定 6 个变量，也只需要 10^6 次 operation，看着是指数复杂度其实很快。
