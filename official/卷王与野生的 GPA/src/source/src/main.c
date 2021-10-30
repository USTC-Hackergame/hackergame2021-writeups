#define REG_VCOUNT *(volatile unsigned short*)0x04000006
#define vid_mem ((unsigned short*)0x06000000)
#include "bg.h"
#include "t1.h"
#include "t2.h"
#include "t3.h"
#include "t4.h"
#include "ball0.h"
#include "ball1.h"
#include "trick0.h"
#include "trick1.h"
#include "m0.h"
#include "m1.h"
#include "m2.h"
#include "m3.h"
#include "b0.h"
#include "b1.h"
#include "b2.h"
#include "b3.h"
#include "b4.h"
#include "b5.h"
#include "flag0.h"
#include "key.h"
#include <string.h>

#define KEY_A        0x0001
#define KEY_B        0x0002
#define KEY_SELECT   0x0004
#define KEY_START    0x0008
#define KEY_RIGHT    0x0010
#define KEY_LEFT     0x0020
#define KEY_UP       0x0040
#define KEY_DOWN     0x0080
#define KEY_R        0x0100
#define KEY_L        0x0200

#define KEY_MASK     0x03FF
#define KEY_CURR *(volatile unsigned short *)0x04000130

unsigned short trick[12]={
    KEY_UP,KEY_UP,KEY_DOWN,KEY_DOWN,
    KEY_LEFT,KEY_RIGHT,KEY_LEFT,KEY_RIGHT,
    KEY_B,KEY_A,KEY_B,KEY_A
};
short top=0,ball=0;
unsigned curr=0,prev=0;

__attribute__((noinline)) unsigned short getkey(){
    prev=curr;
    curr=~KEY_CURR&0xff;
    unsigned short tk=trick[top];
    if(!ball){
        unsigned upk=prev&~curr;
        if(upk){
            if(tk==upk){
                top++;
                if(top==12) ball=1;
            }
            else{
                top=0;
                vid_mem[240*top+300]+=1;
            }
        }
    }
    return curr;
}

__attribute__((noinline)) void vid_vsync()
{
    while(REG_VCOUNT >= 160);   // wait till VDraw
    while(REG_VCOUNT < 160);    // wait till VBlank
}

__attribute__((noinline)) unsigned short keydown(unsigned short k){
    return getkey()&k;
}
__attribute__((noinline)) unsigned short keyrelease(unsigned short k){
    getkey();
    return (~curr&k)&&(prev&k);
}

__attribute__((noinline)) void showtext(unsigned short * bf){
    int i;
    for(i=26880;i<38400;i++){
        vid_mem[i]=bf[i-26880];
        if(!(i&1023)) vid_vsync();
    }
}
__attribute__((noinline)) void showchara(unsigned short * bf){
    int i,j;
    for(i=0;i<64;i++){
        for(j=0;j<105;j++)
            vid_mem[(i+48)*240+j+29]=bf[i*105+j];
        if(!(i&15)) vid_vsync();
    }
}
__attribute__((noinline)) void throw(){
    showtext(t2);
    showchara(m1);
    showchara(m2);
    showchara(m3);
    showball(b1);
    showchara(m0);
}
__attribute__((noinline)) void showball(unsigned short * bf){
    int i,j;
    for(i=0;i<33;i++){
        for(j=0;j<134;j++)
            vid_mem[(i+5)*240+j+105]=bf[i*134+j];
        if(!(i%10)) vid_vsync();
    }
}
__attribute__((noinline)) void fail(){
    showball(b2);
    showball(b3);
    showball(b4);
    showball(b5);
    showball(b0);
    showtext(t3);
    while(!keyrelease(KEY_A));
    showtext(t4);
    while(!keyrelease(KEY_A));
}
__attribute__((noinline)) void trickplay(){
    showtext(trick0);
    while(!keyrelease(KEY_A));
    showtext(trick1);
    while(!keyrelease(KEY_A));
    showtext(ball1);
    while(!keyrelease(KEY_A));
}
__attribute__((noinline)) void init(){
    int i=0,j=0;
    ball=0;
    for(i=0;i<26880;i++){
        vid_mem[i]=bg[i];
    }
    for(i=26880;i<38400;i++){
        vid_mem[i]=bg[i];
        if(!(i&1023)) vid_vsync();
    }
    while(!keyrelease(KEY_A));
    showtext(t1);
    while(!keyrelease(KEY_A));
    showtext(ball0);
}

__attribute__((noinline)) void decrypt(){
    int i;
    for(i=26880;i<38400;i++){
        vid_mem[i]=flagenc[key[i-26880]];
        if(!(i&1023)) vid_vsync();
    }
}
int main(){
    *(unsigned int*)0x04000000 = 0x0403;
mainstart:
    init();
    while(!ball){
        getkey();
    }
    trickplay();
    throw();
    fail();
    vid_mem[0]=23;
    while(!keyrelease(KEY_A))
    showtext(flag0);
    while(!keyrelease(KEY_A))
    showtext(flagenc);
    decrypt();
    while(1);
    return 0;
}