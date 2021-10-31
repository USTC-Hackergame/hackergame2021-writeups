int __attribute((section(".xdata"))) main()
{
    __asm(
          "mov $0, %eax                    \n" // clear %eax
          "mov $4, %eax                    \n" // sys_write
          "mov $str, %ecx                  \n" // from -> str
          "mov $1, %ebx                    \n" // to -> stdout
          "mov $14, %edx                   \n" // length -> 14
          "int $0x80                       \n" // syscall
          "mov $1, %eax                    \n" // sys_exit
          "mov $0, %ebx                    \n" // ret -> 0
          "int $0x80                       \n" // syscall
          "str: .ascii \"Hello, world!\\n\"\n");
}
