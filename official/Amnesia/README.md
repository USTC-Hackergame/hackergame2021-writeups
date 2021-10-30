# Amnesia

题解作者：[Peter Gu](https://github.com/regymm)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：binary

- 题目分值：轻度失忆（150）+ 记忆清除（200）

你的程序只需要输出字符串 `Hello, world!`（结尾有无换行均可）并正常结束。

编译指令：`gcc -O file.c -m32`

运行指令：`./a.out`

编译器版本：Docker 镜像 `ustclug/debian:10` 中 `apt update && apt -y upgrade && apt install -y gcc=4:8.3.0-1 gcc-multilib=4:8.3.0-1` 的版本

**轻度失忆**

编译后 ELF 文件的 `.data` 和 `.rodata` 段会被清零。

连接题目：`nc 202.38.93.111 10051` 或[网页终端](http://202.38.93.111:10050/)

判题脚本：[下载](src/amnesia_1_checker.zip)

**记忆清除**

编译后 ELF 文件的 `.text` 段会被清零。

连接题目：`nc 202.38.93.111 10061` 或[网页终端](http://202.38.93.111:10060/)

判题脚本：[下载](src/amnesia_2_checker.zip)

> 如果你不知道 `nc` 是什么，或者在使用上面的命令时遇到了困难，可以参考我们编写的 [萌新入门手册：如何使用 nc/ncat？](https://lug.ustc.edu.cn/planet/2019/09/how-to-use-nc/)

## 题解

本题主要考察对 ELF 文件各个段和 C 语言编译中变量内存分配的理解。第一问较为简单，第二问比较有意思，出题人想了很久才找到答案，并且多半有各种其他解法，欢迎分享。

ELF 是类 UNIX 操作系统中常用的可执行文件格式。Linux 上，可执行二进制文件、编译中途目标文件（通常为 `.o`）和共享库（通常为 `.so`）都是这种格式。[此处](https://akaedu.github.io/book/ch18s05.html)是一个较为易懂的说明，[此处](https://stevens.netmeister.org/631/elf.html)是较为高级和全面的说明，适合需要了解奇奇怪怪的内容（比如 osdev）时查找。在 CSAPP 书中也有不错的相关讲解和运行时各个段在内存中位置的图示。

第一个链接已经介绍了文件基本构造，这里就不说了（懒）。常见的处理工具为 readelf（读取文件信息，如各个 section 和 segment 的地址、大小、权限等），objdump（反汇编代码段），objcopy（用于段等的操控，比如将某个段清零。常见用途是将 ELF 文件中的代码 dump 成裸二进制文件用于嵌入式处理器的指令 ROM）。

在 C 语言程序编译到二进制的过程中，通常**指令代码**会被编译进 `.text` 段。**只读的数据**，如不变的字符串，会被编译到 `.rodata` 段。**初始化的全局变量** 的值会被放在 `.data` 段。**未初始化的全局变量**，如较大的数组，会被放在 `.bss` 段，并且因为不需要初始值，`.bss` 段在实际文件中的大小可以很小，但运行的时候会被分配正常大小的内存。`.bss` 段运行时会被清零，所以未初始化全局变量会是 0 值。**局部变量和函数内的数组**不会在编译时写入 ELF 文件中，而是运行时在栈上动态分配，因此未赋值时的内容也是不确定的。

*具体的变量分配和编译器版本、体系结构等均有关系。*

#### 轻度失忆

这一问难度还是非常低的。如果直接写 `printf("Hello, world!\n");` ，是以一个只读的字符串为参数（传递头指针），因此该字符串会被分配到 `.rodata` 段，进而被清除。程序不会输出任何内容也不会崩溃，因为清零之后相当于指针直接指向 `\0`，输出长度为 0 的字符串。

那只要不用字符串就好了。一个函数中 char 字符（其实和 int 也没什么差别）则会被分配到栈上，不会受到影响，即使是常数。

*汇编中这种常数通常用加载立即数指令等完成，而对于一些浮点数等，从 `.rodata` 固定内存地址中加载而不是将数值写在汇编指令中也是可能的。*

于是猜一下就出来的答案：

```c
#include <stdio.h>

int main(void) {
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
	putchar('\n');
    return 0;
}
```

~~不知道为什么做出来的人这么少。~~

#### 记忆清除

第二问还是有些 tricky 的，出题人也不了解一般的 binary hacking 过程，所以多半会有更好地解法。并且解法和编译器版本有关。

`.text` 段是代码，清零了就没有代码执行了，所以如果不做特殊处理多半会 Segmentation Fault。

如果通过 gdb 等跟踪，会发现程序会运行到 `.text` 段结束才崩溃：清零后的段会被当成 nop 指令正常执行，直到 `.text` 结束。那么一个自然的思路就是，在 `.text` 结束之后的部分加入一段输出字符串的代码。

尽管如此，就算紧接着 `.text` 的就是用户可以操控的数据段，也是不行的，因为数据段是没有执行权限的。readelf 输出可见，`.text` 段权限为 AX，`.rodata` 段权限为 A，`.data` 段权限为 WA。

另一个思路是让程序的入口地址不在 `.text` 段，或将 `.text` 段改名，或覆盖程序结束后 `.fini` 段的函数等等，但似乎不依靠外界的链接脚本（不过，如果有链接脚本那能干的事情就多了）或 [crt0.o](https://en.wikipedia.org/wiki/Crt0) 这并不容易实现。

那么仅仅有一个 .c 程序文件，能干什么呢？用 C elf section control 等关键字不难查到，可以通过 `__attribute__ ((section (".xxx")))` 控制一个函数被编译到哪个段！

于是，我们可以让函数被编译到一个新的 `.text2` 段，并且发现这个段恰好在 `.text` 之后，清零后的执行情况也说明 `.text2` 段的代码确实会被执行，然后...再次 Segmentation Fault。

```
Disassembly of section .text2:

00001201 <main3>:
	1201:	53                   	push   %ebx
    1202:	83 ec 14             	sub    $0x14,%esp
    1205:	e8 96 fe ff ff       	call   10a0 <__x86.get_pc_thunk.bx>
    120a:	81 c3 f6 2d 00 00    	add    $0x2df6,%ebx
    1210:	8d 83 08 e0 ff ff    	lea    -0x1ff8(%ebx),%eax
    1216:	50                   	push   %eax
    1217:	e8 14 fe ff ff       	call   1030 <puts@plt>
    121c:	83 c4 18             	add    $0x18,%esp
    121f:	5b                   	pop    %ebx
    1220:	c3                   	ret
```

可见此时虽然到了新的段，代码开始时还是会调用被清零段内的代码（`__x86.get_pc_trunk.bx`，用于 position-independent code 相关操作），进而跳回“前面”再“滑下来”。但是因为 x86 指令是变长的，“滑下来”时取指令的 alignment 就不确定了（比如可能取到 00 53、00 00 53， 而不是 53），进而非法指令 Segmentation Fault。

出题人想了一下，发现用内联汇编可以避开开头的 `call`。这也是为什么编译指令有 `-O` 优化：如果没有这个优化，内联汇编后这个讨厌的操作也还存在。

但很不幸的是 alignment 还是有问题。

但是内联汇编的时候也是可以加一些固定常数占位的：`.byte 0;`。本题服务器上 gcc 的版本中，需要 1 个 byte 的额外 0。这个地方出题人想了很久。

还有一个小问题，就是内联汇编 printf 后需要 fflush 才能真正输出结果，否则可能出现在命令行中执行能看到结构，但重定向之后什么都没有的情况。最终完整代码如下：

```
#include <stdio.h>
char Format[]="Hello, world!\n";
int main3(void){
	asm(".byte 0;"
		"movl $Format,(%esp);"
		"call printf;"
		"movl $0, (%esp);"
		"call fflush;"
		"movl $0, (%esp);"
		"call _exit;");
}
extern int main3(void) __attribute__ ((section (".text2")));
int main() {}
```

#### 其他解法

在题目负责人的帮助下看了一下部分选手的 payload 代码，发现很多其他的方法，似乎对齐的问题可以直接解决不需要手动填充 0，并且可以利用某些默认编译的程序里没有出现的名字有特殊含义的段直接运行代码而不用依赖被清零的部分？

在此就不抢选手的 write-up 了，总之感觉大家比我厉害多了。

#### 非预期解

其实判题脚本是有问题的，调用编译脚本之后，没有对编译和清除是否成功进行检查，因此可以”让 objcopy 空间不足失败“，进而直接执行未被清零的原始 ELF 文件。

据我所知仅有一名选手是利用了这个漏洞，就是 ...



*本题灵感来自于，出题人在玩 RISC-V 交叉编译的时候用 objcopy 然后不清除 .bss，发现各种奇奇怪怪的行为... 结果现在发现，就算 .text 都清了程序还是一样的跑 ...*

*另外，看到选手在群里讨论第二个问花了 xxx 个小时也没做出来，出题人还是很有成就感的 ...*
