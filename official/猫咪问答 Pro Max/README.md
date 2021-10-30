# 猫咪问答 Pro Max

题解作者：[taoky](https://github.com/taoky)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：general

- 题目分值：100

- 题目链接：[http://202.38.93.111:10001/?token={token}](http://202.38.93.111:10001/)

我猛然一看，就猛然看到这个猫咪问答，我直呼我直呼，上次看到这么这么的发言还是上次，这问答属于是典型的典型了，我之前还没发现，当我发现的时候我已经发现了，这问答就像一个问答，问答的内容充满了内容，我不禁感慨了一句感慨：希望下次看到这么这么的猫咪问答是下次。

提示：**解出谜题不需要是科大在校学生**。解题遇到困难？你可以参考 [2018 年猫咪问答题解](https://github.com/ustclug/hackergame2018-writeups/blob/master/official/ustcquiz/README.md) 和 [2020 年猫咪问答++ 题解](https://github.com/USTC-Hackergame/hackergame2020-writeups/blob/master/official/%E7%8C%AB%E5%92%AA%E9%97%AE%E7%AD%94++/README.md)。

## 题解

先从第二题开始顺序讲。

### 第二题

「中国科学技术大学 Linux 用户协会在近五年多少次被评为校五星级社团」？直接搜索估计会看到 [USTCLUG 的介绍页](https://lug.ustc.edu.cn/wiki/intro/):

> 为了表彰其出色表现，协会于 2011 年 5 月被评为中国科学技术大学优秀学生社团，于 2012 年 5 月、2013 年 5 月及 2014 年 5 月分别被评为中国科学技术大学四星级学生社团，并于 2015 年 5 月、2017 年 7 月、2018 年 9 月、2019 年 8 月及 2020 年 9 月被评为中国科学技术大学五星级学生社团。

所以答案是 4 年？这可不一定！请看页面下方更新时间：

> 更新时间: 2021 年 5 月 20 日

基于往年的评选时间，可以推断页面**没有及时更新**。那么怎么证明 2021 年 USTCLUG 是五星社团呢？搜索「2021 中国科大 五星级社团」，可以找到这个页面：[我校举行2021年学生社团游园会](https://zsb.ustc.edu.cn/2021/0928/c12990a524155/pagem.htm)。其中的[图片](https://zsb.ustc.edu.cn/_upload/article/images/aa/64/6fa4dabb4810a17cf7c1d978c481/bfc8bd9e-51a8-4b61-9c42-8d484a7d72c0.jpg)证明了 2021 年 USTCLUG 也是五星级社团，所以答案为 5。

PS: 如果看过[网站的仓库](https://github.com/ustclug/website)，会发现[有一个 commit](https://github.com/ustclug/website/commit/3f84b515ba97d1b8a63490390661d925f758205b) 更新了英文版的介绍——是我干的，其实是当时忘了更新中文的介绍，后来发现就算不更新也有足够的资料证明 2021 年的结果，所以就没有动。

### 第三题

「中国科学技术大学 Linux 用户协会位于西区图书馆的活动室门口的牌子上“LUG @ USTC”下方的小字是？」

如果是科大学生，是可以在 10/28 前亲自到活动室来看看的。但是，如果从来没来过的话，活动室在几楼呢？所以关于活动室的资料仍然需要搜索解决。

最简单的搜索方法是：在[官网](https://lug.ustc.edu.cn/)右上角点击搜索按钮，输入「活动室」三个字，点击第一篇文章即可。

> 2016 年 6 月 16 日，LUG 西区新活动室启用，并成为今后唯一的社团活动室。一部分 LUG 成员在当日早上从东区图书馆 605 老活动室与东图一楼将大部分活动材料与各类物品搬迁到了西区活动室。
> 
> （[门口牌子的图片](https://ftp.lug.ustc.edu.cn/wp-content/uploads/2016/06/IMG_20160616_133655_compressed.jpg)）
> 
> 新的西区活动室仍然由图书馆提供，位于西区图书馆 206 室。具体地点在西区图书馆主楼二楼西北角，十分接近原 308 活动室。

得到答案为 `Development Team of Library`，也不需要亲自来跑一趟了 :)

### 第四题

「在 SIGBOVIK 2021 的一篇关于二进制 Newcomb-Benford 定律的论文中，作者一共展示了多少个数据集对其理论结果进行验证？」

「国际顶会」SIGBOVIK (Special Interest Group on Harry Quamasia Bovik) 于每年的 4 月 1 日召开：有着和正规学术会议一样的流程，通过严格的评审选出搞笑的计算机科学类论文。

搜索可以找到[官网](sigbovik.org/2021)，官网可以下载到[会议的 Proceedings](http://sigbovik.org/2021/proceedings.pdf)。

在 PDF 中搜索可以得到该论文为 *The Newcomb-Benford Law, Applied to Binary Data: An Empirical and Theoretic Analysis*。阅读该论文（很短），可以看到在论文的第六部分：

> If you’re like us, you probably weren’t convinced by the above proof. But, as we all know, numbers don’t lie. We collected several exhaustive sets of data from reliable sources and plotted the proportion of data points with first digits 0 and 1 respectively. The sources are listed alongside the figures.
> 
> The tabulated data is omitted, for brevity, as well as to protect the privacy of our data sources. We converted all of the data points to their binary representations, and plotted the relative frequency of the leading digits. The figures are shown in Figs. 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, and 14 in the appendix.

图 2-14 一共是 13 张图，因为每个数据集都画了图，所以答案是 13.

### 第五题

「不严格遵循协议规范的操作着实令人生厌，好在 IETF 于 2021 年成立了 Protocol Police 以监督并惩戒所有违背 RFC 文档的行为个体。假如你发现了某位同学可能违反了协议规范，根据 Protocol Police 相关文档中规定的举报方法，你应该将你的举报信发往何处？」

与去年的鸽子题一脉相承的搞笑 RFC 题。搜索 "RFC protocol police"，优秀的搜索引擎可以给出正确的 RFC 编号：[rfc8962](https://tools.ietf.org/html/rfc8962)。全文搜索 "report"，可以找到：

```
6.  Reporting Offenses
   Send all your reports of possible violations and all tips about
   wrongdoing to /dev/null.  The Protocol Police are listening and will
   take care of it.
```

所以答案为 `/dev/null`。

### 第一题

「2017 年，中科大信息安全俱乐部（SEC@USTC）并入中科大 Linux 用户协会（USTCLUG）。目前，信息安全俱乐部的域名（sec.ustc.edu.cn）已经无法访问，但你能找到信息安全俱乐部的社团章程在哪一天的会员代表大会上通过的吗？」

第一题的争议可能比较大，出题人也看到了向我们吐槽的邮件。

说到获取已经下线的网站的内容，有过相关了解的同学肯定会去 [Web Archive](https://web.archive.org/) 等相关网站去找。如果不知道的话，搜索引擎搜 `"sec.ustc.edu.cn"`（带双引号），也可以找到页面 <https://lug.ustc.edu.cn/wiki/sec/contest.html>，从而在原站的首页找到相关内容。

>  中国科学技术大学学生信息安全俱乐部（以下简称“信息安全俱乐部”）是由中国科学技术大学对信息安全感兴趣、学习和研究信息安全的本科生、研究生自发组建的，由信息科学技术学院网络信息安全系（筹）提供专业指导的，开展信息安全领域相关活动的学生社团。（详见信息安全俱乐部社团章程) 

> 本章程在 2015 年 5 月 4 日，经会员代表大会审议通过。

可能有些同学会发现无法访问上面的链接，在其他地方找不到答案。这个时候并不等于这道题无解，因为**爆破答案也可以是猫咪问答的一部分。**

发送请求的格式可以通过浏览器的「检查元素」-> Network 看到。下面使用 Python 的 requests 库给出一个示例：在确定了第二到五题答案的情况下猜第一题的答案。

```python
import requests
import datetime

s = requests.Session()
s.get("http://202.38.93.111:10001/?token=<urlencode 之后的 token>")

date = datetime.date(2017, 12, 31)  # 从 2017/12/31 开始向前推
delta = datetime.timedelta(days=1)
while True:
    datestr = date.strftime("%Y%m%d")
    ret = s.post("http://202.38.93.111:10001/", {
        "q1": datestr,
        "q2": "5",
        "q3": "Development Team of Library",
        "q4": "13",
        "q5": "/dev/null"
    })
    if "没有全部答对" in ret.text:
        print(datestr, "❌")
    else:
        print(datestr, "✅")
        break
    date = date - delta
```

测试以上脚本只需要不到 20 秒即可得到答案为 20150504。

## 附录

@taoky:

今年的猫咪问答的题目是在比赛前几天才（比较）仓促定下来的，所以里面可能有的题目的做题体验不是很好，在此表示抱歉。作为第一题的出题人，出这道题是因为在整理 hackergame 资料的时候，发现 <sec.ustc.edu.cn> 没了（去年还在的），**结果第二届和第三届比赛的新闻稿/获奖名单也一起没掉了**。我把所有能找的地方都翻了一通，最后才在 Web Archive 上找到了第二届的资料（很遗憾，第三届的资料还是没有找到），并且放在了上面提到的链接里。

有不少人有备份自己的数据的习惯，但是对于公开在网站上的数据，会像备份自己的数据一样去备份它们的人就少得多了。[LUGFTP](https://ftp.lug.ustc.edu.cn/) 在遭遇今年 3 月的磁盘阵列问题之前（详见[「阵列恢复大师」题解的背景部分](../阵列恢复大师/README.md#背景)），我们也没有做相关的备份，后来才知道只有一个同学一直在自己备份一份（虽然最后恢复成功了，没有用他的备份）。出第一题的时候，我的本意是希望传达：过往看似消失的回忆，可能互联网上仍然会有人会有一份自己的存档。但是似乎没有达到预期的效果，并且被人发邮件吐槽了一通。如果有人觉得第一题非常糟糕、起到了误导性的作用，我在此表示歉意。
