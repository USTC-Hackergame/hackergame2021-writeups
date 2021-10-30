#!/bin/bash

rm -f lukspwd.zip
rm -f lukspwd-encrypted.7z
zip lukspwd.zip day1.img day2.img

7za a lukspwd-encrypted.7z '-pDA-0zmt3R-tVg9RudwsQyg' -mhe=on lukspwd.zip
