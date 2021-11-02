const char message[] = "Hello, world!\n";

void main(void) {
    asm(
        // https://lwn.net/Articles/604515/
        // syscall number
        // https://elixir.bootlin.com/linux/v3.14/source/arch/x86/syscalls/syscall_32.tbl#L12
        "mov $4, %%eax;\n\t"
        // fd of stdout
        "mov $1, %%ebx;\n\t"
        // buffer
        "mov %[message], %%ecx;\n\t"
        // length
        "mov $14, %%edx;\n\t"
        // do syscall
        "int $0x80;\n\t"
        // return 0
        "mov $0, %%eax;\n\t"
        : 
        : [message] "r" (message)
        : "%eax", "%ebx", "%ecx", "%edx"
    );
}
