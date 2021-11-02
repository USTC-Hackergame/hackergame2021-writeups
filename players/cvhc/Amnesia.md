## Amnesia

### 轻度失忆

同官方题解，用 `putchar` 一个一个字母输出，这样字符都是内嵌到指令（`.text` 段）里的，不会被清除。

### 重度失忆

objdump 观察一下清零后的 binary，`.text` 段指令全变 `00 00  add %al,(%eax)`，不仅你写的 `main` 没了，甚至整个 `crt0` 都被擦了。这个指令本身无害，程序是一路 fallthrough 到下一个段 `.fini` 才崩溃的。这个段也是放代码的，只有个链接 `crt0` 时塞进来的 `_fini` 函数：

```
Disassembly of section .text:

00001060 <_start>:
        ...
......
000012e5 <__x86.get_pc_thunk.bp>:
    12e5:       00 00                   add    %al,(%eax)
        ...

Disassembly of section .fini:

000012ec <_fini>:
    12ec:       f3 0f 1e fb             endbr32 
    12f0:       53                      push   %ebx
    12f1:       83 ec 08                sub    $0x8,%esp
    12f4:       e8 a7 fd ff ff          call   10a0 <__x86.get_pc_thunk.bx>
    12f9:       81 c3 07 2d 00 00       add    $0x2d07,%ebx
    12ff:       83 c4 08                add    $0x8,%esp
    1302:       5b                      pop    %ebx
    1303:       c3                      ret
```

自然的想法是能不能在 `.text` 后面塞一点代码，让程序 fallthrough 到我们加的代码。比如可以替换掉 `_fini` 这个函数，或者在它前面加一个函数。搜索了一下，用 `__attribute__((section(".段名称")))` 就可以在指定段添加任意 payload，但不操纵 linker 似乎就没办法覆盖掉 GCC 插在最前面的 `_fini` 函数。

后来又研究 Linux 程序的启动流程，琢磨有什么能在程序进 `_start` 或 `main` 前插代码的机制。知道了 GCC 里能给函数加 `__attribute__((constructor))` 以及 `__attribute__((destructor))` 属性，然后这些函数就会在进入 `main` 之前或之后执行。其原理是 GCC 会把函数指针写到 `.init_array` 和 `.fini_array` 这两个段（以前也会用 `.ctors`, `.dtors` 段），然后 `crt0` 里会调用这些函数。然而擦掉 `.text` 后 `crt0` 的初始化逻辑全没了，所以这些都没用。

不过这下学到了很多以前不知道的 ELF 段。我就顺着继续研究其他特殊段，`readelf -S` 列出来的段一个个查作用。最后发现了 `.preinit_array` 这个段。这个段用法跟 `.init_array` 和 `.fini_array` 一样，把函数指针塞进去就行，最牛逼的是这些函数是由 `ld.so` 执行的（[参考资料](http://dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html)），所以擦了 `crt0` 也不要紧。

所以只要把函数本体插到某个不会被擦掉的有代码执行权限的段（例如 `.init`），然后把函数指针加到 `.preinit_array` 里面就好了。代码如下：

```c
// 一段在栈上塞字符串然后调用 sys_write 输出的 shellcode
// 可以嵌汇编，但我测试其他段的时候转成 shellcode 了，后来也没有改回来
const char _main[] __attribute__((section(".init"))) = \
    "\x68\x21\x0a\x00\x00"
    "\x68\x6f\x72\x6c\x64"
    "\x68\x6f\x2c\x20\x77"
    "\x68\x48\x65\x6c\x6c"
    "\x89\xe1"
    "\xba\x0e\x00\x00\x00"
    "\xbb\x01\x00\x00\x00"
    "\xb8\x04\x00\x00\x00"
    "\xcd\x80"
    "\xbb\x00\x00\x00\x00"
    "\xb8\x01\x00\x00\x00"
    "\xcd\x80";

void (*funcptr)(void) __attribute__((section(".preinit_array"))) = _main;

int main() {
    return -1;
}
```

