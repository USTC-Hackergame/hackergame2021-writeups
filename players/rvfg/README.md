## Amnesia/记忆清除

`.text`被清除之后`_start`函数都没了，好像自己的代码完全没法执行，但是通过搜索找到 [Linux x86 ELF 启动流程](http://www.dbp-consulting.com/tutorials/debugging/linuxProgramStartup.html)，发现`ld.so`在进入 ELF 的 entry point 之前会执行`.preinit_array`中的函数。

然后通过搜索`.preinit_array`找到了一个 [stackoverflow 回答](https://stackoverflow.com/a/21246462)，但是抄了代码之后出现了`__x86.get_pc_trunk.bx`问题，于是想到了`inline asm`，没学过汇编的我通过`gcc -S`拼凑出了代码:
```C
asm(".section    .rodata\n\t"
    "LC0:\n\t"
    ".string    \"Hello, world!\"\n\t"
    ".section    .data.rel.local,\"aw\"\n\t"
    ".align 4\n\t"
    ".type    hello, @object\n\t"
    ".size    hello, 4\n\t"
    "hello:\n\t"
    ".long    LC0\n\t"
    ".section    mysection,\"ax\",@progbits\n\t"
    ".type    hello_func, @function\n\t"
    "hello_func:\n\t"
    "mov $1, %ebx\n\t"
    "mov hello, %ecx\n\t"
    "mov $13, %edx\n\t"
    "mov $4, %eax\n\t"
    "int $0x80\n\t"
    "mov $0, %ebx\n\t"
    "mov $1, %eax\n\t"
    "int $0x80\n\t"
    ".section    .preinit_array,\"aw\"\n\t"
    ".align 4\n\t"
    ".type    y, @object\n\t"
    ".size    y, 4\n\t"
    "y:\n\t"
    ".long    hello_func\n\t"
    ".section fuck"
);

int main() {
    int a = 0;
}
```
