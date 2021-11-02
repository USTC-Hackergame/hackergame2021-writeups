#include <unistd.h>

int main(void) {
    //write(0x55, 0xabcd, 0x77);
    write(1, "Hello, world!\n", 13);
}
