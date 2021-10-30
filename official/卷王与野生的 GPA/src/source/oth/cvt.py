#!python3
from PIL import Image
import numpy as np
name=input()
op=open('../include/'+name+'.h','w')
i=np.array(Image.open('./'+name+'.jpg'))
op.write('const unsigned short '+name+'[38400]={\n')
l=0
for j in i:
    for k in j:
        c0=k[2]//8
        c1=k[1]//8
        c2=k[0]//8
        c=c0*1024+c1*32+c2
        op.write(hex(c))
        l+=1
        if l!=38400:
            op.write(',')
        if l % 40==0:
            op.write('\n')
op.write('};\n')