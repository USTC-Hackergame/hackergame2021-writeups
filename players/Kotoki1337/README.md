# Write-up

纯萌新，第一次玩 CTF，只会一点 Python。

本 Writeup 很少使用代码，使用了各种外部工具，欢迎参考解题过程及思路。

- [Write-up](#write-up)
  - [签到](#签到)
  - [进制十六——参上](#进制十六参上)
  - [去吧！追寻自由的电波](#去吧追寻自由的电波)
  - [猫咪问答 Pro Max](#猫咪问答-pro-max)
    - [2017 年，中科大信息安全俱乐部（SEC@USTC）并入中科大 Linux 用户协会（USTCLUG）。目前，信息安全俱乐部的域名（`sec.ustc.edu.cn`）已经无法访问，但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗？](#2017-年中科大信息安全俱乐部secustc并入中科大-linux-用户协会ustclug目前信息安全俱乐部的域名secustceducn已经无法访问但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗)
    - [中国科学技术大学 Linux 用户协会在近五年多少次被评为校五星级社团？](#中国科学技术大学-linux-用户协会在近五年多少次被评为校五星级社团)
    - [中国科学技术大学 Linux 用户协会位于西区图书馆的活动室门口的牌子上“LUG @ USTC”下方的小字是？](#中国科学技术大学-linux-用户协会位于西区图书馆的活动室门口的牌子上lug--ustc下方的小字是)
    - [在 SIGBOVIK 2021 的一篇关于二进制 Newcomb-Benford 定律的论文中，作者一共展示了多少个数据集对其理论结果进行验证？](#在-sigbovik-2021-的一篇关于二进制-newcomb-benford-定律的论文中作者一共展示了多少个数据集对其理论结果进行验证)
    - [不严格遵循协议规范的操作着实令人生厌，好在 IETF 于 2021 年成立了 Protocol Police 以监督并惩戒所有违背 RFC 文档的行为个体。假如你发现了某位同学可能违反了协议规范，根据 Protocol Police 相关文档中规定的举报方法，你应该将你的举报信发往何处？](#不严格遵循协议规范的操作着实令人生厌好在-ietf-于-2021-年成立了-protocol-police-以监督并惩戒所有违背-rfc-文档的行为个体假如你发现了某位同学可能违反了协议规范根据-protocol-police-相关文档中规定的举报方法你应该将你的举报信发往何处)
  - [卖瓜](#卖瓜)
  - [透明的文件](#透明的文件)
  - [旅行照片](#旅行照片)
  - [FLAG 助力大红包](#flag-助力大红包)
  - [图之上的信息](#图之上的信息)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

---

## 签到

进入链接，点了下 `Next`，看到链接 `?page=1`，打了个 `?page=1000000` 试了下，时间来到 `1970-01-12 21:46:40 +08:00`。一眼 timestamp，谷歌 `timestamp now`，随便找个能用的拿到当时的时间戳输入进链接，拿到 Flag。

## 进制十六——参上

看到 `十六进制编辑器`，以及右面的明文。得知需要从 HEX 转为明文，打开了 VS Code 安装了我最喜欢的十六进制编辑器插件。

![HEX Editor](image/HEX%20Editor.png)

1. [Hex Editor by Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor)

## 去吧！追寻自由的电波

下载了一个音频文件，听一遍发现加速了。打开开始菜单寻找可以修改音频的软件，只有 Aodobe PR，拖进去减速，明显听到类似 `Alpha`，`Bravo`，参考题目中的 `X 同学使用了无线电中惯用的方法来区分字符串中读音相近的字母`，得知是无线电通话拼写字母。不过我并没有对照字母表，我直接靠听力识别了大部分字母，所以音频中的 `left-bracket` 和 `right-bracket` 直接给我干懵逼了。但我回过头来尝试识别拼写出来的单词时看到了 `flag`，于是两个括号也迎刃而解。

1. [北约音标字母 - 维基百科](https://zh.wikipedia.org/wiki/%E5%8C%97%E7%BA%A6%E9%9F%B3%E6%A0%87%E5%AD%97%E6%AF%8D)
2. [NATO phonetic alphabet - Wikipedia](https://en.wikipedia.org/wiki/NATO_phonetic_alphabet)

## 猫咪问答 Pro Max

社工？这我熟啊

##### 2017 年，中科大信息安全俱乐部（SEC@USTC）并入中科大 Linux 用户协会（USTCLUG）。目前，信息安全俱乐部的域名（`sec.ustc.edu.cn`）已经无法访问，但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗？

丢进 [Wayback Machine](https://web.archive.org/) 找到最近快照，显示 `HTTP 302` 跳转到了 `doku.php`。

找到 `信息安全俱乐部社团章程`，得到答案

![](image/Meow%20Q&A%201.png)

##### 中国科学技术大学 Linux 用户协会在近五年多少次被评为校五星级社团？

谷歌 `中国科学技术大学 Linux 用户协会`，来到 [LUG @ USTC 官网](https://lug.ustc.edu.cn)。

点击 `了解更多` 来到 `wiki/intro`，找到相关内容

![](image/Meow%20Q&A%202.png)

近五年应是 4 次，但是 4 不对，5 才是正确答案。

- _为什么是 5？请参见：[猫咪问答 Pro Max - 第二题（官方题解）](https://github.com/USTC-Hackergame/hackergame2021-writeups/tree/master/official/%E7%8C%AB%E5%92%AA%E9%97%AE%E7%AD%94%20Pro%20Max#%E7%AC%AC%E4%BA%8C%E9%A2%98)_

##### 中国科学技术大学 Linux 用户协会位于西区图书馆的活动室门口的牌子上“LUG @ USTC”下方的小字是？

其他人的解法是通过谷歌图片搜索，而我直接干到了 LUG 的 [FTP 服务器](http://ftp.lug.ustc.edu.cn/)里。

确实是绕了弯路，当时在想，什么活动能拍到门牌板呢？于是我看到了 `2016.06.16_活动室搬迁`，成功找到了包含社团活动室门牌版的图片 `IMG_20160616_133655`：

![](image/Meow%20Q&A%203.png)

##### 在 SIGBOVIK 2021 的一篇关于二进制 Newcomb-Benford 定律的论文中，作者一共展示了多少个数据集对其理论结果进行验证？

谷歌搜索 `SIGBOVIK 2021`，在 PDF 中找到 `Newcomb-Benford` 的文章。

找到一共 13 张数据集的图，答案为 13。

##### 不严格遵循协议规范的操作着实令人生厌，好在 IETF 于 2021 年成立了 Protocol Police 以监督并惩戒所有违背 RFC 文档的行为个体。假如你发现了某位同学可能违反了协议规范，根据 Protocol Police 相关文档中规定的举报方法，你应该将你的举报信发往何处？

谷歌 `RFC protocol police`，可以找到 `RFC 8962: Establishing the Protocol Police` 这篇文章。

开始我还以为答案是个邮箱之类的，但这篇文章里没有符合答案九位的邮箱。我一开始以为找错了，直到我认真读了一遍这文章才发现是愚人节搞笑 RFC 题。

`Ctrl` + `F` 全文搜索 report，找到答案 `/dev/null`。

## 卖瓜

看到有效时间 10 分钟，以为是爆破题。看了一下接口感觉不太对劲，读了读题看到了 `补充说明` 里的 `整数` 二字。谷歌了一下 php 的整形溢出，发现思路没错，可以溢出到负数。

于是用科学计数法给他干到溢出，然后我选择从 6 下手，把溢出的数字拿去谷歌除以 6，肯定会余数，接着检查余数是否满足 `(x-2) 被 3 整除`。

然后一个一个试把这题拿下了= =

## 透明的文件

拿到一个乱码文件，读题说是 `用于在终端中展示一个五颜六色的 flag`，以及 `可能是在 cmd.exe 等劣质终端中被长期使用的原因`。于是我想到应该不能在 `PowerShell` 里使用，仔细观察文件，可以看出规律，应该是什么特殊符号代码，谷歌 `linux color text`，找到了一个 `stackoverflow` 的链接，得知这些代码是 `ANSI escape codes`，文件中缺少了控制符 `\x1b`（也可以是十进制的 `\x033`）。

使用 VS Code 处理文件，`Ctrl` + `F` 并切换为替换模式，将所有 `[` 替换为 `\x1b[`，效果等同于以下 Python 代码：

```python
text.replace("[", "\x1b[")
```

但经过我之前的仔细观察，发现这些颜色代码尝试给空格添加颜色，我随手写了一个 Python 文件尝试 Liunx 输出能否给空格添加颜色，结果是不行。

所以我再次通过 VS Code 的替换把所有的空格替换为了易读的正方形方框。

最后丢进 Linux 里输出，得到 flag。

![](image/Invisible%20file.png)

- [1] [How to change the output color of echo in Linux - Stack Overflow](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)
- [2] [ANSI转义序列 - 维基百科](https://zh.wikipedia.org/wiki/ANSI%E8%BD%AC%E4%B9%89%E5%BA%8F%E5%88%97)
- [3] [ANSI escape code - Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code)

## 旅行照片

京津冀本地玩家优势，标志性蓝色装潢 KFC，标志性三色像素标志物，一眼秦皇岛。

在地图上找到了这片熟悉的沙滩，熟悉的新澳海底世界，熟悉的停车场。。。

沙滩朝向微偏向东南，所以拍摄者面向东南。

通过影子和太阳东升西落的原理判断拍摄时间位下午，但不确定是答案中的 `下午` 还是 `傍晚`。

楼层参考照片中的右侧建筑物楼层，最高层为 16，所以我准备从 18 开始往下尝试。

KFC 分店电话，地图里就有，其实在高德地图中搜索 `秦皇岛 KFC` 就可以在列表中找到这家非常显眼的浅蓝色装潢 KFC。

肯德基左侧的三个汉字，由于网络上的图片残次不齐，时间相差甚远，最后还是在百度街景中找到了那三个字。

所以带着第三题的 `下午` 和 `傍晚`，我开始从 18 层往下手动遍历，最后答案停留在了 `傍晚`，和第 14 层。

## FLAG 助力大红包

_我曾有过打开 OpenBullet 直接用代理池干烂的冲动。_

观察一波接口，可以通过修改按钮的 HTML 值或请求接口的 Body 来修改前端 IP。

```html
<div class="alert alert-warning row" role="alert">
    失败！检测到前后端检测 IPv4 地址不匹配，前端地址： 1.1.1.1 ，后端地址： *.*.*.* 。疑似地址伪造！
</div>
```

那后端呢？

百度了一下，发现可以通过修改 HTTP 头内 `X-Forwarded-For` 的方式来伪造 IP。

奈何计算机网络课是睡过去的，谷歌了一下 /8 网段相关知识，所以理论上只有 256 个可用的 /8 网段，也就是从 0-255 共 256 个 IP。

为什么我知道是 256 个，因为我到 255 个的时候给我来了一波拼多多操作。

打开 Postman，设置 Body 和 HTTP Headers。

Postman 可以使用变量，让我接下来的遍历更加方便。

![](image/FLAG%20Booster%201.png)
![](image/FLAG%20Booster%202.png)
![](image/FLAG%20Booster%203.png)

接下来将 256 个 IP format 为一个文件导入到 Postman 中，设置运行间隔，开始遍历。

![](image/FLAG%20Booster%204.png)

![](image/FLAG%20Booster%205.png)

待 256 次遍历完成后，提现，获得 flag。

## 图之上的信息

谢谢，我现在学会 GraphQL 了。

进网站，登陆，还是先看接口。

找到一个带着 json 的请求：

```json
{"query":"{ notes(userId: 2) { id\ncontents }}"}
```

丢进 Postman 随便试了试，发现 `notes` 可能是个函数，出门谷歌 GraphQL，找到 docs。

通读过后发现了一个 Introspection（内省）系统，复制 example 到 Postman。

```json
{"query":"{ __schema { types { name } } }"}
```

返回了接口内所有的类型：

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

猜测 `GNote` 就是 notes 函数所在的地方，`GUser` 应该就是我们要找的东西。

继续阅读官方文档，使用 `__type` 查询 `GUser` 里面有啥玩意：

```json
{"query":"{ __type(name: \"GUser\") { name fields { name type { name kind } } } }"}
```

```json
{
    "data": {
        "__type": {
            "name": "GUser",
            "fields": [
                {
                    "name": "id",
                    "type": {
                        "name": "Int",
                        "kind": "SCALAR"
                    }
                },
                {
                    "name": "username",
                    "type": {
                        "name": "String",
                        "kind": "SCALAR"
                    }
                },
                {
                    "name": "privateEmail",
                    "type": {
                        "name": "String",
                        "kind": "SCALAR"
                    }
                }
            ]
        }
    }
}
```

现在需要查询的 `type` 找到了，那么调用查询的函数呢？用什么来替换 `notes`？

继续阅读官方文档：

```
这和我们在类型系统那章里说的一样，Query 类型是我们开始的地方！
注意这里的命名只是一个惯例，我们也可以把 Query 取成别的名字，只要我们把它定义为所有查询出发的地方，它也依然会在这里被返回。
尽管如此，还是把它命名为 Query 吧，这是一个有用的惯例。
```

那不如来看看 `Query` 里有什么：

```json
{"query":"{ __type(name: \"Query\") { name fields { name type { name kind } } } }"}
```

```json
{
    "data": {
        "__type": {
            "name": "Query",
            "fields": [
                {
                    "name": "note",
                    "type": {
                        "name": "GNote",
                        "kind": "OBJECT"
                    }
                },
                {
                    "name": "notes",
                    "type": {
                        "name": null,
                        "kind": "LIST"
                    }
                },
                {
                    "name": "user",
                    "type": {
                        "name": "GUser",
                        "kind": "OBJECT"
                    }
                }
            ]
        }
    }
}
```
Here we go.

直接照葫芦画瓢，把需要的抄下来：

```json
{"query":"{ user(id: 1) { username\nprivateEmail }}"}
```

```json
{
    "data": {
        "user": {
            "username": "admin",
            "privateEmail": "flag{dont_let_graphql_l3ak_data_8b4a433f52@hackergame.ustc}"
        }
    }
}
```

- [1] [内省 | GraphQL 官方文档](https://graphql.cn/learn/introspection/)
- [2] [Introspection | Learn GraphQL](https://graphql.org/learn/introspection/)

---

以上

谢谢，真的学到很多。
