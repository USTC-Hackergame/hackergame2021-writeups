#include <stdio.h>
int main() {
    int z = 0, c1, c4, c16, c96, H, e, l, o, comma, space, w, r, d, exclamation;
    c1 = !z;
    c4 = c1 + c1 + c1 + c1;
    c16 = c4 + c4 + c4 + c4;
    c96 = c16 + c16 + c16 + c16 + c16 + c16;

    H = c16 + c16 + c16 + c16 + c4 + c4;    // 72
    e = c96 + c4 + c1;                      // 101
    l = c96 + c4 + c4 + c4;                 // 108
    o = c96 + c4 + c4 + c4 + c1 + c1 + c1;  // 111
    comma = c16 + c16 + c4 + c4 + c4;       // 44
    space = c16 + c16;                      // 32
    w = c96 + c16 + c4 + c1 + c1 + c1;      // 119
    r = c96 + c16 + c1 + c1;                // 114
    d = c96 + c4;                           // 100
    exclamation = c16 + c16 + 1;            // 33
    putchar(H);
    putchar(e);
    putchar(l);
    putchar(l);
    putchar(o);
    putchar(comma);
    putchar(space);
    putchar(w);
    putchar(o);
    putchar(r);
    putchar(l);
    putchar(d);
    putchar(exclamation);
    return z;
}
