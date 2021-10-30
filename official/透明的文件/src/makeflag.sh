#!/bin/bash
gcc makeflag.c -o makeflag
./makeflag | lolcat -f | sed 's/\x1b//g' > ../files/transparent.txt
# solution: cat transparent.txt | sed 's/\[/\x1b[/g' then select all
