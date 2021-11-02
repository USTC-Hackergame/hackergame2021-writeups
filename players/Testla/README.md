# WriteUp

## 签到

一看就是 [Epoch time](http://en.wikipedia.org/wiki/Unix_time)。点一下 Next，发现时间加了 1s，同时 URL 里的 page 增加一。修改 page 的值为当前时间即可。

```python
>>> import time
>>> time.time()
```

`flag{HappyHacking2021-<Redacted>}`

## 进制十六——参上

十六进制转文本，编码用 ASCII 就可以。不长所以直接手抄了。当时不知道 xxd 的 -p 开关，输出老是不对，所以是手动拼接的，早知道直接 python。

```shell
$ cat a.txt
59 30
55 5F 53 48 30 55 31 44 5F 6B 6E 30 77 5F 48 30
57 5F 74 30 5F 43 30 6E 76 33 72 74 5F 48 45 58
5F 74 6F 5F 54 65 78 54
$ xxd -r -p a.txt
Y0U_SH0U1D_kn0w_H0W_t0_C0nv3rt_HEX_to_TexT
```

`flag{flag{Y0U_SH0U1D_kn0w_H0W_t0_C0nv3rt_HEX_to_TexT}`

## 去吧！追寻自由的电波

搜了一下知道是一段用 [NATO phonetic alphabet](http://en.wikipedia.org/wiki/NATO_phonetic_alphabet) 念的录音。虽然知道声调不正常但还是 PotPlayer 减速硬听。太痛苦了，估计折腾了一个多小时。一开始 left/right bracket 听成了 Golf Quebec（虽然知道并不像），看了群里的讨论才知道是 flag 格式里的括号。还有 Charlie 听成了 Mike/Five，看了整体才猜到是 phonetic 的 c。

赛后想起来 MPC 默认的 Audio Renderer 声调会随着播放速度改变，试了一下确实好多了。

`flag{phoneticab}`

## 猫咪问答 Pro Max

1. 一顿搜索，没找到。试了一下 archive.org，没想到[真有](https://web.archive.org/web/20181004003308/http://sec.ustc.edu.cn/doku.php/codes)。答案是 `20150504`。
2. 稍微搜索了一下，也是没找到。因为范围不大，留到最后直接枚举了。答案是 `5`。
3. 在 <https://lug.ustc.edu.cn/news/2016/06/new-activity-room-in-west-library/> 有照片，忘了用的什么关键词了，瞄到可能相关就点开了。答案是 `Development Team of Library`。
4. 可以搜到论文的 [PDF](http://sigbovik.org/2021/proceedings.pdf)，稍微阅读后可知是图 2 - 14。答案是 `14`。
5. 以前读过，IETF 今年的愚人节笑话 <https://tools.ietf.org/html/rfc8962>。答案是 `/dev/null`。

`flag{8804d9f3_<Redacted>}`

## 卖瓜

因为 6 和 9 都是 3 的倍数，就算可以输入负数也没有整数解。第一反应就是溢出，试了一下确实会，但结果有点奇怪。看群里说溢出会变成浮点数，又看到补充说明说浮点数不行，而且题目分类还是 web，于是就往 web 方面考虑，没想到是我想多了。

先看源码和提交内容，b6 和 b9 分别是 6 斤瓜和 9 斤瓜的数量，试试提交负数、分数和小数，不行。尝试使用 b1-b20 作为键值，也不行。看到服务器返回 `<b>Warning</b>:  Undefined array key "b9" in <b>/mnt/app/index.php</b> on line <b>64</b><br />`，知道用的是 PHP 和相应的路径，以为要通过 `/?clear=y` 注入，但是不太会所以先搁置了。

看到通过人数很多，还是回来尝试溢出。试了几次可以知道应该是使用补码的 64 位有符号整数，但是又像 IEEE 754 double 一样有有效位数的损失。溢出后因为低位会丢失所以绝对值肯定小不了，所以考虑先溢出到一个小的负数，再加回来。

```python
>>> 2 ** 64 // 9
2049638230412172401
```

提交 `0 2049638230412172001` 得到 -4096。

4096 + 20 = 4116  
4116 / 6 = 686

直接提交 `686 2049638230412172001` 得到 0……忘了低位会丢失了。

先提交 `0 2049638230412172001`，再提交 `686 0`，成功。

`flag{HUAQIANG!HUAQIANG!_<Redacted>}`

## 透明的文件

搜了一下（关键词忘了）得到 <https://arduino-forth.com/article/FORTH_FlashForth_installation_gererEcranTeraTerm>，知道是 VT100 终端的 [ANSI Mode Control Sequence](https://vt100.net/docs/vt100-ug/chapter3.html#S3.3.3)，根据格式在每个 `[` 前插入一个 ESC，试着在 WSL 里 cat 了一下，没想到就出来了。记得当时是白色的字，不知道为什么现在尝试重现时变成背景色了，实在不行可以先 `print('*' * 2 ** 14)`。

```python
with open('transparent.txt', 'rb') as f:
    b = f.read()
with open('translated.txt', 'wb') as f:
    f.write(b.replace(b'[', b'\x1b[')
```

`flag{abxnniohkalmcowsayfiglet}`

## 旅行照片

这题耗了比较多时间。

首先当然是看看 EXIF，毕竟 Hackergame，发现都被删掉了。

然后是题目里涉及到的 KFC，配色非常特别，搜索`绿色 KFC`找到 KPRO。发现 KPRO 数量很少，就一家家看。感觉 北京环球城市大道店 很像，有停车场也有水，但是从官网地图和各种地图来看都对不上。

这时有点怀疑是不是外国的 KPRO，一顿搜索无果。回去看图，左边中间有一个`活海?`，靠右行驶，车牌也像是蓝底白字，电话号码格式也是熟悉的区号加电话号码，应该还是在中国。

剩下比较强的特征就是海边了，照片里旁边直接就是一望无垠的海，于是沿着海岸线开始找。找到 肯德基(小径湾店)，已经挺像的了，可惜并不是。

又一顿搜索，在[一篇小红书笔记](https://www.xiaohongshu.com/discovery/item/610d448f00000000210377ac)看到原来是 河北省秦皇岛市海港区河滨路81号 的 新澳海底世界店。确定了地点，剩下的就好办了。

1. 视线比海岸线垂线偏左，所以是东南。
2. 从大楼的影子看到太阳很偏西，应该是傍晚或下午，结果是傍晚。
3. 俯角比较小，估计 10-14 层，枚举一下结果是 14。
4. 地图或美团上可以看到电话是 0335-7168800。写题解时看到[大众点评](http://ctc.www.dianping.com/shop/1334089120)隐藏了后两位，要求登录才能看，实在是屑。
5. 用百度地图街景可以看到是海豚馆。

`flag{D0n7-5hare-ph0t05-ca5ua11y}`

## FLAG 助力大红包

一看题目顿觉不妙，以为是 PDD 级数，就先跳过了。后来看到通过人数很多而且群里讨论说只要点 256 次，又回来做了。

一开始搜狐的接口被 uBlock Origin 拦截了，关掉。看源码和助力时的请求数据，发送的是公网 IP 地址。尝试直接提交被拒绝，说后端地址不匹配。因为提示需要不同的 /8 地址，而 10.0.0.0/8 是内网地址，正常手段不太可能用这个地址成功建立 TCP 连接，就想到了 HTTP 的 X-Forwarded-For。试了一下确实可以，延迟随便取的 1.1 结果很顺利。

`flag{r3d-enve10p3-<Redacted>}`

## Amnesia

因为看了往年题解还有点印象，第一问直接 putchar。[Amnesia-1.c](./09-Amnesia/Amnesia-1.c)

`flag{S0_S1mp1e_r1ght_<Redacted>}`

第二问先想到了 [Main is usually a function. So then when is it not?](https://jroweboy.github.io/c/asm/2015/01/26/when-is-main-not-a-function.html)。先稍作修改改成可以运行的 [relative_addressing-x86_64.c](./09-Amnesia/relative_addressing-x86_64.c)。因为 x86 32 上不支持相对寻址，先写了 [normal.c](./09-Amnesia/normal.c) 看看普通情况下编译器怎么处理（调用一个叫 __x86.get_pc_thunk.ax 的函数，在里面读栈上的返回地址），用 GCC 内联汇编移植到 32 位（[inline_asm-x86_32.c](./09-Amnesia/inline_asm-x86_32.c)）。然后把字符串放在后面将 main 改成 const char \[\]（[array_main.c](./09-Amnesia/array_main.c)），结果段错误了。还没查清楚段错误的原因，发现用题目的脚本编译时根本到不了 main，刚跑过 .text 就挂了，没找到解决方法。

## 图之上的信息

打开开发者工具登录，可以看到向 <http://202.38.93.111:15001/graphql> 发送了请求。猜了一下，得到 admin 的 id 是 1。但是不知道邮箱的字段名还是不行。一边读官网的文档一边实验，在 <https://graphql.org/learn/introspection/> 就有查看 schema 的方法，改改名字执行即可。

```python
'query': '{ users { id\n } }'
# {"errors":[{"message":"Cannot query field 'users' on type 'Query'. Did you mean 'user'?","locations":[{"line":1,"column":3}],"path":null}]}
'query': '{ user(id: 2) { id,username } }'
'query': '{ user(id: 1) { id,username } }'
'query': '{ __schema { types { name } } }'
'query': '{ __type(name: "GUser") { name,kind } }'
'query': '{ __type(name: "GUser") { name,fields { name,type { name,kind } } } }'
'query': '{ user(id: 1) { privateEmail } }'
```

`flag{dont_let_graphql_l3ak_data_<Redacted>@hackergame.ustc}`

## 加密的 U 盘

初看以为 LUKS 的 anti-forensic 出问题了，又一想那可是大新闻不应该不知道。然后猜测是没有删掉旧的 key-slot。打开压缩包一看，原来是保留了旧的镜像。通常磁盘加密软件在更改密码时不会更改加密用的密钥，因为那样需要解密再加密所有内容。我们只需要用弱密码配合旧镜像得到 master key，再用 master key 直接打开新镜像就可以。

`flag{changing_Pa55w0rD_d0esNot_ChangE_Luk5_ma5ter_key}`

题外话：我装系统的时候也读了很多 ArchWiki 和 LUKS 的相关内容，感觉题目很真实哈哈。推荐阅读 [cryptsetup FAQ](https://gitlab.com/cryptsetup/cryptsetup/-/wikis/FrequentlyAskedQuestions)，写得很详细很有趣。

## 赛博厨房

第一关比较简单，主要限制是程序保存后要第二天才能用，而且每次执行时状态会被清空不能组合。观察可知菜谱是两个随机数，把四种组合都填上去就行。为了方便，放下物品后会回到初始位置。

```plain text
0
向右 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品
向上 1 步

1
向右 2 步
拿起 1 个物品
向下 1 步
向左 2 步
放下 1 个物品
向上 1 步
```

`flag{level0_9d132008f193_<Redacted>}`

第二关地图非常简单，只有一种食物。菜谱第一天是 73 个 0，还好第二天也没有变，使用跳转命令即可。

```plain text
向右 1 步
拿起 73 个物品
向下 1 步
向左 1 步
放下 1 个物品
如果手上的物品大于等于 1 向上跳转 1 行
```

`flag{level1_212d794167df_<Redacted>}`

先打开开发者工具看了一下，最后是要把解提交到服务器验证的，不能乱来了。

第三关难度暴增，32 种食物，菜谱看起来是随机的 6 个数。看起来希望不大就没有想，列一下思路：  
A. 找到菜谱生成方式，看能不能通过控制一些输入得到想要的菜谱。  
B. 6 * 5 = 30 bits, 128 = 7 bits, 30 - 7 = 23. 直接填入 127 个程序然后暴力，要看每次生成菜谱耗时是多少。

## Co-Program

第一问先看了一下输入，实际给出的表达式相当一部分很复杂，还有不少重复使用的变量，虽然看到有不少是 0，但感觉要过 90% 的 case 需要大量时间，就没做。

第二问格式说明实在酷炫，一时被唬住了。仔细一想，既然表达式可以任意构造，那么先得到 1，加上加法和乘法就可以构造出任意正整数，判断方面用几个 if 直接匹配 x 和 y 就可以。写出来后通常一题长度大约几 K，还好能过。感觉这题难度不高，可能大家都被第一问吓到了就没做。

`flag{dIdy0uUseCvC5?-<Redacted>}`

## 马赛克

先处理马赛克后的图片，读出已知的像素块和马赛克块的值。一开始只要像素块包含一个 0 或者 255 就认为这个像素块是对应的值，实际上当像素块占马赛克块比例很小时，是有可能在像素块为 1 时取整到 0 的。后来采取的做法是要求整个像素块都是相同颜色才认为是确定的。当时以为马赛克边缘的区域都能解出来，现在再看还真的导致浪费了不少像素块，应该将马赛克范围内外的像素块分开处理。

然后先写一个将矩阵还原回二维码图片输出的函数，调试的时候很好用。

想到二维码里有一些固定区域，一看好像不在马赛克范围里。

算法是遍历每一个马赛克块，对剩余的未知像素块枚举所有可能，筛选出取整后与马赛克块颜色相同的可行情况。如果一个像素块在所有的可行情况中颜色都相同，那么这个像素块的颜色就是确定的。计算的时候直接用了 numpy 整块赋值，可以用面积加权平均和/或格雷码来优化，不过实际运行也很快就没写。

运行后看到第 4 遍以后就没有新的像素块被解出来了，还好用手机的扫码软件可以扫出来，不确定有没有唯一解。万一不行就要开始搜索了。

`flag{QRcodes_are_pixel_arts_EvSwCSAWtP}`

## minecRaft

虽然知道不太可能，但还是先一边观察亮灯情况一边跳了一遍 minecRaft，差点吐了。看来要多玩 3D 游戏锻炼一下（

惯例开发者工具，看到 flag.js，应该就是它了。打开一看代码混淆过。一边读一边重命名，一个函数是返回一个数组的，一个是偏移后根据下标取数组里元素的，第一次函数执行是打乱这个数组。幸好只有这个地方对数组进行了写操作，复制改改在控制台里运行一下，就能得到打乱后的数组。

把数组内容代入进去，又一顿重命名，可以知道 17 行开始定义了一个 encrypt 函数，gyflagh 函数中调用了 encrypt 并检查结果，我们需要求出 encrypt 前的字符串。将 encrypt 和 code 改改变成反函数，在控制台运行即可。

`flag{McWebRE_inMlnCrA1t_3a5y_1cIuop9i}`

## p😭q

图片明显是频谱图，应该是需要把音频还原出来。阅读代码，阅读代码里面用到的库的文档，写代码，profit（。大概就是先逐帧读图片把得到的频域数据拼起来，后面就交给 librosa 了。写的过程中可以随便找个音频文件，修改生成的代码来查看中间的数据，因为矩阵维度的顺序不好确定。

`flag{634971243582}`

## 超 OI 的 Writeup 模拟器

当时网络环境不好，先花半天断断续续地 build 了一个 ghidra。毕竟故意加了混淆，还是用点工具。

找到 __libc_start_main，三个函数里只有第一个参数看起来有料。对照汇编和反编译的代码看，这个函数读入一个 16 位的字符串，调用另一个函数后检查返回值。下一个函数只是加上两个常量后继续调用第三个函数。第三个函数比较复杂，还好有反编译代码。一顿分析，控制流只依赖 local_40，而 local_40 初始值是常数，更新也不依赖其他变量，所以控制流是确定的。

用 gdb 调试，断点先打在 getline，然后 finish 跳出来。可以看到第一个函数是把字符串分成两块 8 字节的数据作为参数传递。第三个函数中 LAB_001011e2 被执行了 13 次，进入 54 行的分支后返回。在 54 行分支后 local_48 的值需要是 0，可以写出几条表达式，还原出 local_38 和 local_48 的值。然后把 LAB_001011e2 也还原回去即可。

第二问下载下来一看，有一个复杂的函数调用了自己，虽然通过群里的聊天猜测只要解一道就行，但还是因为时间不够放弃了。

`flag{ESREVER_<Redacted>}`

## 部分没有通过的题目

### Easy RSA

没通过的题目里通过人数最多的一题。数论和 RSA 不太会，还得学一遍（别骂了别骂了.jpg）。由于不确定能不能做出来就先搁置了。

### 只读文件系统

稍微读了一下，不太了解 mmap，猜测是类似 Heap Spraying（这个我也不太了解）的操作。但构造 payload 被 Amnesia 弄得 PTSD 了，而且通过人数太少，没有尝试。

### 阵列恢复大师

开始做的时候已经是最后一天凌晨了，在剩下的题目里选了通过可能性最大的。看了通过人数先尝试 RAID 5，毕竟 RAID 0 8 个盘要枚举规模有点大。先一顿搜索，结果不多，因为大部分不会直接 superblock 全没。然后 fdisk gdisk xxd mdadm 一顿瞎操作。因为 3RlmViivyG8.img 和 60kE0MQisyY.img 这两个都有 Protective MBR，猜测其中一个是第一个盘，另一个第一段是校验信息。写了个 Python 脚本来枚举所有顺序尝试挂载。一开始脑抽以为可以当成 RAID 0 少一个盘，跑了一顿没出结果才反应过来 RAID 5 是 Rotating Parity。但 mdadm --build 不能用于 RAID 5，这时已经很困了，一顿瞎改，把组合数开到最大就去睡觉了。醒来一看没跑出来，GG。
