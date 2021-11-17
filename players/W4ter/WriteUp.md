# [Hackergame 2021](https://hack.lug.ustc.edu.cn/)

## 前言
没啥时间打，周末只打了六个小时，只做出了这些题目，我还是太菜了，老了老了。
完整WP可以参考官方
https://github.com/USTC-Hackergame/hackergame2021-writeups

## 签到

> http://202.38.93.111:10000/?page=1635000000
>
> flag{HappyHacking2021-fbb3d99d2b}

![1635017671988.png](https://cdn.gksec.com/20211024/fOukJ88t/1635017671988.png)

## 进制十六——参上

> flag{Y0U_SH0U1D_kn0w_H0W_t0_C0nv3rt_HEX_to_TexT}

![1635017833930.png](https://cdn.gksec.com/20211024/t3DRCC3C/1635017833930.png)

## 去吧！追寻自由的电波

> flag{phoneticab}

首先把音频放慢到0.35倍，然后根据无线电通信中英语字母读法对照表逐一拼出即可。

![1635019380284.png](https://cdn.gksec.com/20211024/olpakHWD/1635019380284.png)

## 猫咪问答 Pro Max

> flag{8804d9f3_768427b0fe}

1、2017 年，中科大信息安全俱乐部（SEC@USTC）并入中科大 Linux 用户协会（USTCLUG）。目前，信息安全俱乐部的域名（sec.ustc.edu.cn）已经无法访问，但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗？

> 20150504

https://web.archive.org/web/20170515053637/http://sec.ustc.edu.cn/doku.php/codes

2、中国科学技术大学 Linux 用户协会在近五年多少次被评为校五星级社团？

> 5

https://lug.ustc.edu.cn/wiki/intro/

3、中国科学技术大学 Linux 用户协会位于西区图书馆的活动室门口的牌子上“LUG @ USTC”下方的小字是？

> Development Team of Library

https://lug.ustc.edu.cn/news/2016/06/new-activity-room-in-west-library/

4、在 SIGBOVIK 2021 的一篇关于二进制 Newcomb-Benford 定律的论文中，作者一共展示了多少个数据集对其理论结果进行验证？

> 13

http://sigbovik.org/2021/proceedings.pdf  的第212页开始

5、不严格遵循协议规范的操作着实令人生厌，好在 IETF 于 2021 年成立了 Protocol Police 以监督并惩戒所有违背 RFC 文档的行为个体。假如你发现了某位同学可能违反了协议规范，根据 Protocol Police 相关文档中规定的举报方法，你应该将你的举报信发往何处？

> /dev/null

https://datatracker.ietf.org/doc/rfc8962/

## 卖瓜

> flag{HUAQIANG!HUAQIANG!_910557490a}

php整数溢出，首先在放`1024819115206086203`个9斤瓜，使其变为负数，然后再放`9223372036854775008`个9斤瓜。

然后显示网页显示

*电子秤上已有 -16384/20 斤的瓜。*

通过脚本简单计算可得再放`1`个6斤瓜，`1822`个9斤瓜，即可得到20斤的瓜。



## 透明的文件

> flag{abxnniohkalmcowsayfiglet}

给出的文件在每个`[`前面加上\033，得到类似，然后使用echo -e “\033[0;0H\033[20;58H……”

```bash
\033[0;0H\033[20;58H\033[8;34H\033[13;27H\033[4;2H\033[38;2;1;204;177m \033[39m\033[14;10H
……省略n行
```

就能得到以下效果，此方法在mac下的终端测试失败，在Mobaxter终端测试成功。

![1635026714914.png](https://cdn.gksec.com/20211024/U5psLBko/1635026714914.png)



## 旅行照片

>  flag{D0n7-5hare-ph0t05-ca5ua11y}

搜索关键词：蓝色 海边 KFC

得到结果 新澳海底世界肯德基

![1635024738241.png](https://cdn.gksec.com/20211024/KA5sGF1y/1635024738241.png)

街景地图确认后，直接冲，根据常识推断出答案。

![1635024836849.png](https://cdn.gksec.com/20211024/mzMk6lAz/1635024836849.png)

## FLAG助力大红包

```
flag{r3d-enve10p3-73431814c1}
```

没啥特别要注意的，从`1.1.1.1`发到`255.1.1.1`，记得再发一个0.1.1.1这个IP地址，一共主力256次才能拿到FLAG。

![1635032068911.png](https://cdn.gksec.com/20211024/Jx6UgWlZ/1635032068911.png)

# Amnesia

### 轻度失忆

> flag{S0_S1mp1e_r1ght_b47b01fd93}

```c
#include <stdio.h>
#define _ putchar
int main() {_('H');_('e');_('l');_('l');_('o');_(',');_(' ');_('w');_('o');_('r');_('l');_('d');_('!');}
```



## 图之上的信息

> flag{dont_let_graphql_l3ak_data_6600944459@hackergame.ustc}

看描述应该是GraphQL注入，先获取类型，得到GNote，然后查字段名。

```sql
{
	__schema {
		types {
			name
		}
	}
}
```

![1635028081847.png](https://cdn.gksec.com/20211024/fjb2xpom/1635028081847.png)

发现了关键字段GUser，然后找到了字段名称为`privateEmail`

```
{
  __type (name: "GUser") {
    name
    fields {
      name
      type {
        name
        kind
        ofType {
          name
          kind
        }
      }
    }
  }
}
```

![1635030172506.png](https://cdn.gksec.com/20211024/4CdYT5s0/1635030172506.png)

但是这时候不能跨类型查，就很烦，然后又看了以下Query类，果然带通过user就能查询GUser里面的内容。

![1635030289457.png](https://cdn.gksec.com/20211024/kNtOYxfO/1635030289457.png)

所以Payload就出来了，轻松秒杀。

```
{
 user(id: 1) 
  { 
    privateEmail
  }
}
```

![1635030361929.png](https://cdn.gksec.com/20211024/w8jMYP7n/1635030361929.png)

## 赛博厨房

### Level0

> flag{level0_9d132008f193_da55d8956f}

三个菜单，分别对应菜单（1，0）、（0，1）、（1，1）

```
向右 2 步
拿起 1 个物品
向下 1 步
向左 2 步
放下 1 个物品
向右 1 步
向上 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品


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


向右 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品
向右 1 步
向上 1 步
拿起 1 个物品
向下 1 步
向左 1 步
放下 1 个物品
```
