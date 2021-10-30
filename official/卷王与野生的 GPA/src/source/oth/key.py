#!python3
import random
from PIL import Image
import numpy as np
enckey=[i for i in range(11520)]
random.shuffle(enckey)
key=[0]*11520
l=0
for i in enckey:
    key[i]=l
    l+=1
keyfp=open('../include/key.h','w')
keyfp.write('const unsigned short key[11520]={\n')
l=0
for i in key:
    keyfp.write(hex(i))
    l+=1
    if(l!=11520): keyfp.write(',')
    if(l%40==0): keyfp.write('\n')

keyfp.write('};\n\n')

keyfp.write('const unsigned short flagenc[11520]={\n')

flag=[]
i=np.array(Image.open('./flag.jpg'))
for j in i:
    for k in j:
        c0=k[2]//8
        c1=k[1]//8
        c2=k[0]//8
        c=c0*1024+c1*32+c2
        flag.append(c)

for i in range(len(flag)):
    keyfp.write(hex(flag[enckey[i]]))
    if(i+1!=11520): keyfp.write(',')
    if((i+1)%40==0): keyfp.write('\n')

keyfp.write('};\n\n')
