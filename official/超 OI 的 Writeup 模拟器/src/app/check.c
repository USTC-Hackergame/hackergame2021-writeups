#include <stdint.h>
#include <stdio.h>

uint64_t check(uint64_t a, uint64_t b);

int main(){
    char *buffer = NULL;
    size_t len;
    printf("Input code: ");
    ssize_t read = getline(&buffer, &len, stdin);
    if(read == 17 && check(*(uint64_t *)buffer, *(uint64_t *)(buffer+8)) == 0){
        puts("Correct code");
    }else{
        puts("Wrong code");
    }
    return 0;
}