file1 = open('2.txt', 'r')
content1 = file1.read()
file1.close()

file2 = open('2+.txt', 'r')
content2 = file2.read()
file2.close()

contentSplit1 = content1.split('\n')
contentSplit2 = content2.split('\n')
length = len(contentSplit1)

for i in range(length):
    ignoreMinus1 = contentSplit1[i].replace('-', '')
    ignoreMinus2 = contentSplit2[i].replace('-', '')
    if ignoreMinus1 != ignoreMinus2:
        print(i)
