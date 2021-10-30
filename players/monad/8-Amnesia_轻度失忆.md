# Amnesia - 轻度失忆

`.data` 段没了，字符串常量是储存在这里的。既然不能用字符串常量，就分割成字符就可以了。

```c
#include <stdio.h>

int main() {
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

    return 0;
}
```
