# 只读文件系统

题解作者：[V1me](https://github.com/Roarcannotprogramming)、[zzh1996](https://github.com/zzh1996)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：binary

- 题目分值：250

- 题目链接：[http://202.38.93.111:10107/?token={token}](http://202.38.93.111:10107/)

你通过一个简单的任意代码执行漏洞就成功入侵了目标。

然而，你发现目标上的文件系统是只读的，并且，没有任何地方给你放临时文件。

「连个落脚的地方都没有，我想放进去个工具程序然后跑起来都做不到！」你感到不满。

**[下载题目源代码](src/只读文件系统.zip)**

你可以通过 `nc 202.38.93.111 10106` 来连接，也可以点击下面按钮打开网页终端

注：题目环境内核为 Debian 11 最新版本 `Linux 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86_64 GNU/Linux`。

> 如果你不知道 `nc` 是什么，或者在使用上面的命令时遇到了困难，可以参考我们编写的 [萌新入门手册：如何使用 nc/ncat？](https://lug.ustc.edu.cn/planet/2019/09/how-to-use-nc/)

### 出题思路

本节作者：[zzh1996](https://github.com/zzh1996)

这题的出题思路是我提供的，但是我写 shellcode 不熟练，所以让 V1me 帮我写了解题代码和题目二进制（见下一节）。

每当我 pwn 掉一个题目，看到只有 `sh`、`ls` 和 `cat` 的只读环境时，我都在想：这种限制除了防止我占用磁盘空间之外到底有什么用？我不是都已经任意代码执行了吗？这真的能防止我运行其他 binary 吗？

于是，我就出了这道题。

搜索「run ELF in memory」之类的关键词，很容易找到解法，例如[这里](https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html)和[这里](https://stackoverflow.com/questions/63208333/using-memfd-create-and-fexecve-to-run-elf-from-memory)。

另外，如果题目不是部署在 Docker 容器里面的话，其实还可以用 unshare 创建新的 mount namespace 来做到这件事情，有兴趣的同学可以试试。

除了这两种方法，如果你还有其他的方法，一定要记得告诉我~

还有，部分选手遇到了本地打通但是远程却出错的情况，这是因为 read 系统调用不保证一次性返回你要求的字节数，在本地的环境中，read 通常可以一次性把你的 payload 完全读入，但是你与远程环境是通过 TCP 来交互的，一次 read 读不进那么多字节，你需要在 shellcode 中写一个循环来读入。你可以自己在云服务器上复现。另：将 read 的边界作为消息边界的网络程序不是好程序！

（下面由 V1me 来讲讲解题策略）

### 解题策略

本节作者：[V1me](https://github.com/Roarcannotprogramming)

`check.py` 持续检查 `/proc/{pid}/exe` 是不是我们设定的 hello world 程序。而文件系统是只读的，所以需要想办法调用 `execve` 系统调用，将本来的 overflow 程序变为 hello world 程序。

然而 `execve` 系统调用只接受文件路径作为参数（当然也可以 `execve("/proc/self/fd/{mem_fd}", NULL, NULL)`，如 [shellcode.c](./shellcode.c) 所示）。所以一个简单的办法是调用 `execveat`。[execveat](https://man7.org/linux/man-pages/man2/execveat.2.html) 可以接受 fd 作为参数。所以现在的问题是怎么在一个只读的文件系统中得到一个我们可以操控的文件了。

`memfd_create` 系统调用在内核版本 3.17 后被引入 linux。它可以帮助我们在内存中创建一个匿名的文件，并且返回其 fd，并且无需挂载 `/tmp` 或者 `/dev/shm`。所以最后的思路就呼之欲出了。

用一段 C 语言（伪）代码表示如下:

```c
bin_buf = mmap(0x23335000, 0x100000, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
read(0, bin_buf, 16744); // 16744 is the size of the helloworld binary file
memfd = memfd_create("", MFD_CLOEXEC);
write(memfd, bin_buf, 16744);
execveat(memfd, "", NULL, NULL, AT_EMPTY_PATH);
```

这样就可以达成目标了。

### EXP

本节作者：[V1me](https://github.com/Roarcannotprogramming)

见 [exp.py](./exp.py) 和 [shellcode_execveat.c](./shellcode_execveat.c)。
