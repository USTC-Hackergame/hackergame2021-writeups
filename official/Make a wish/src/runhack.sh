#!/bin/bash
/usr/games/nethack $1 2>/dev/null
echo $? > ret.txt
