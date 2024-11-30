# 助记词

题解作者：[Yanbing Zhao](https://github.com/ustc-zzzz)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](../../credits.pdf)。

## 题目描述

- 题目分类：math

- 题目分值：第一顿大餐（250）+ 第二顿大餐（250）

- 题目链接：[http://202.38.93.111:10048/?token={token}](http://202.38.93.111:10048/)

你的室友终于连夜赶完了他的 Java 语言程序设计的课程大作业。看起来他使用 Java 17 写了一个保存助记词的后端，当然还有配套的前端。助记词由四个英文单词组成，每个用户最多保存 32 条。

你并没有仔细看过他写的任何代码；实际上你压根没有选过这门课。然而，你的室友平常总是在你的耳边喋喋不休 Java 这门编程语言的优越性，虽然无非就是些诸如「微服务」和「大数据」之类的词。当然，他的课程大作业里似乎既没有「微服务」也没有「大数据」，32 条记录也叫「大数据」？

你正糊里糊涂地整理着你自己的书包，并在心中暗骂教务处为何要把这门课安排在早上 7:50。你的室友通宵了一晚上，正准备爬上他的床。虽然他忙了一晚上，但他看起来一点也不累：他又在和你炫耀 Java 在性能上的优越性了。

你从他充满激情却又夹杂不清的表述中得知，他似乎还为此专门在大作业里藏了两个 flag：当访问延迟达到两个特殊的阈值时，flag 便会打印出来，届时你便可以拿着 flag 让你的室友请你吃一顿大餐。

请吃饭倒是次要了，重点是想个办法杀杀他的锐气——你在心里这样想着。突然，你回想起来你的室友在几天前为方便调试，在代码里人为添加了一段延时代码，也不知道他有没有删掉。他之前甚至还朝你炫耀过他的这一「技术」，因为「这样就可以方便手动暂停了」——至于为什么他连打断点都不会，那就不得而知了。

你决定在今天早上的课上把你室友的大作业拿过来试一试——反正这门课已经够无聊了，还不如搞点有意思的。

注：请在下载源代码后使用 `./gradlew run`（Linux / macOS）或 `gradlew.bat run`（Windows）启动，然后通过 `http://localhost:8080` 访问。Java 17 可在[此处](https://mirrors.ustc.edu.cn/AdoptOpenJDK/binary-adoptium/temurin17-binaries/LatestRelease/)下载。

## 源代码

题目后端源代码在 [`backend` 目录下](src/backend/)，只需使用和题目描述中同样的方法启动即可。

## 题解

首先我们先看题干：「在代码里人为添加了一段延时代码」，我们在下载的源代码里很快便可找到这段位于 `Phrase` 类下的延时代码：

```java
@Override
public boolean equals(Object o)
{
    if (o instanceof Phrase that)
    {
        try
        {
            TimeUnit.MILLISECONDS.sleep(EQUALS_DURATION_MILLIS); // TODO: remove it since it is for debugging
        }
        catch (InterruptedException e)
        {
            throw new RuntimeException(e);
        }
        return that.text.equals(this.text) && that.time.equals(this.time) && that.user.equals(this.user);
    }
    return false;
}
```

可以看到每次 `equals` 调用时，当前线程都会暂停一段时间。

通过 `EQUALS_DURATION_MILLIS` 的声明可以注意到暂停了 20 ms：

```java
private static final int EQUALS_DURATION_MILLIS = 20;
```

在添加助记词的方法里，我们可以注意到代码维护了一个 `HashSet<Phrase>` 并将作为输入的 32 个 `Phrase` 一个一个加进去。到这里基本上可以判定这是一个 hash 碰撞的问题——我们要尽可能增加比较的次数，这样才能使得 `equals` 的调用次数足够多。

通过观察，可以注意到决定 hash 的因素一共有三个：

* 助记词本身
* 当前时间（精确到秒）
* 当前用户（对每位选手固定）

当前用户自然是不能动的了，而当前时间一秒变动一次，不会以我们的意志为转移。因此，我们能做的也只有在助记词本身动手脚了。

## 第一顿大餐

这道小题的目标是 `600 ms`，其实很简单——选择 32 个一样的助记词加进去就行了。

* 当请求在同一秒内进行时，比较操作会发生 31 次。
* 当请求分散在两秒进行时，比较操作会发生 30 次。

因此 hash 碰撞会至少发生 30 次，加一起正好是 `600 ms`。

以下是示例请求：

```bash
curl -X DELETE http://202.38.93.111:10048/phrases?token=[token]; curl -X POST -d '[ "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal", "wood fire earth metal" ]' http://202.38.93.111:10048/phrases?token=[token]
```

示例 FLAG：`flag{h45h-m4p-c011i5i0n-0f-key-inpu75-db86cfb1d4617327}`

## 第二顿大餐

这道小题的目标是 `9000 ms`。上一个 FLAG 的获取方式借助了完全相同的 `Phrase`。由于 `HashSet<Phrase>` 里只有一两个元素，因此每次添加助记词带来的 hash 碰撞只会有一次比较发生。

现在我们考虑 32 个 hash 完全相同但互不相同的 `Phrase`：

* 添加第一个，无比较，延时 `0 ms`
* 添加第二个，与第一个比较，延时 `20 ms`
* 添加第三个，与第一个和第二个比较，延时 `40 ms`

依此类推。在添加第 31 个的时候，延时会达到 `9300 ms`，从而超过 `9000 ms` 的数值。

我们设发起请求的时刻为 `t ms`，那么这 31 个的 `Phrase` 的添加时机分别为：

| 序号 | 添加开始 | 添加结束 | 序号 | 添加开始 | 添加结束 |
| :--: | :------: | :------: | :--: | :------: | :------: |
| 1 | `t + 0 ms` | `t + 0 ms` | 17 | `t + 2400 ms` | `t + 2720 ms` |
| 2 | `t + 0 ms` | `t + 20 ms` | 18 | `t + 2720 ms` | `t + 3060 ms` |
| 3 | `t + 20 ms` | `t + 60 ms` | 19 | `t + 3060 ms` | `t + 3420 ms` |
| 4 | `t + 60 ms` | `t + 120 ms` | 20 | `t + 3420 ms` | `t + 3800 ms` |
| 5 | `t + 120 ms` | `t + 200 ms` | 21 | `t + 3800 ms` | `t + 4200 ms` |
| 6 | `t + 200 ms` | `t + 300 ms` | 22 | `t + 4200 ms` | `t + 4620 ms` |
| 7 | `t + 300 ms` | `t + 420 ms` | 23 | `t + 4620 ms` | `t + 5060 ms` |
| 8 | `t + 420 ms` | `t + 560 ms` | 24 | `t + 5060 ms` | `t + 5520 ms` |
| 9 | `t + 560 ms` | `t + 720 ms` | 25 | `t + 5520 ms` | `t + 6000 ms` |
| 10 | `t + 720 ms` | `t + 900 ms` | 26 | `t + 6000 ms` | `t + 6500 ms` |
| 11 | `t + 900 ms` | `t + 1100 ms` | 27 | `t + 6500 ms` | `t + 7020 ms` |
| 12 | `t + 1100 ms` | `t + 1320 ms` | 28 | `t + 7020 ms` | `t + 7560 ms` |
| 13 | `t + 1320 ms` | `t + 1560 ms` | 29 | `t + 7560 ms` | `t + 8120 ms` |
| 14 | `t + 1560 ms` | `t + 1820 ms` | 30 | `t + 8120 ms` | `t + 8700 ms` |
| 15 | `t + 1820 ms` | `t + 2100 ms` | 31 | `t + 8700 ms` | `t + 9300 ms` |
| 16 | `t + 2100 ms` | `t + 2400 ms` | | | |

考虑到 `Phrase` 里的时间是「添加开始」的时间，因此这 31 条助记词分散在不同的九秒里。

我们可以这样分配 32 条助记词（多出一条可用于冗余）：

* 第一秒分配 11 个
* 第二秒分配 5 个
* 第三秒和第四秒各分配 3 个
* 剩下五秒各分配 2 个

这样，当 `t` 的毫秒部分（`t % 1000`）在 `0 ms` 和 `180 ms` 之间时，延时便会达到 `9300 ms` 的数值。换言之，一次成功的概率在 18%，尝试 16 次便会有超过 95% 的概率成功。

现在我们考虑 `Phrase` 的 hash 的实现。hash 的实现位于 `hashCode` 方法。

首先我们观察 `Phrase` 的 `hashCode` 方法。经总结我们可以得到：

```plain
hash(phrase) = hash(user) + 31 * hash(time) + 961 * hash(text) + 29791
             = (hash(user) + 29791) + 31 * (hash(time) + 31 * hash(text)), mod 2 ** 32
```

`hash(user) + 29791` 为相对参赛选手的固定值，而经过调研可以注意到，`time` 的 hash 实现即为其 Unix 时间戳——换言之，`hash(time)` 每秒都会自增。

现在我们的目标变成了寻找特定的 `31 * hash(text)`：

* 11 个 `31 * hash(text) = 9, mod 2 ** 32`
* 5 个 `31 * hash(text) = 8, mod 2 ** 32`
* 3 个 `31 * hash(text) in [7, 6], mod 2 ** 32`
* 2 个`31 * hash(text) in [5, 4, 3, 2, 1], mod 2 ** 32`

这样我们便找到了满足条件的 hash 完全相同的 32 个 `Phrase`。

经过观察，可用的助记词数量为 `600 ** 4 = 30 * (2 ** 32) + 750981120` 个，每个 hash 平均对应 30 余个助记词。对于我们寻找相同 hash 的助记词的目标而言，这个数量绰绰有余。

hash 碰撞代码见 [MnemonicPhraseHashCollision.java](src/MnemonicPhraseHashCollision.java)，完成碰撞在本人的电脑上（`Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz`）单线程只需不到半小时。

以下是示例请求：

```bash
for i in $(seq 16); do curl -X DELETE http://202.38.93.111:10048/phrases?token=[token]; curl -X POST -d '[ "future earth physical politics", "function beautiful purchase break", "finding rock pair person", "figure target private machine", "experience summer reserve officer", "condition money sound attempt", "condition credit people comfortable", "click tool boss insurance", "cash level size attempt", "camera classic flight potential", "bird fall scene finding", "contact education discount possible", "black salt importance instance", "birth community computer city", "bank newspaper make government", "animal time philosophy language", "cell career back thing", "capital phone house hand", "bottom action love business", "board cycle recipe health", "benefit fall link advertising", "audience stage worry square", "bank wood back effect", "access moment lake recipe", "blood woman medicine attention", "advice produce computer ball", "address stay deep stand", "action method other exercise", "activity payment week share", "action mood apartment government", "call action physics plastic", "basis member read north" ]' http://202.38.93.111:10048/phrases?token=[token]; done
```

示例 FLAG：`flag{differen7-key5-h45h-m4p-c011i5i0n-4bb1eb7dca83da16}`
