inFile = open('2.pyc', 'rb')
content = inFile.read()
inFile.close()

preData = content[:0x350]
data = content[0x350:0x1d50]
afterData = content[0x1d50:]

hold = [True for i in range(len(data))]

for i in range(len(data)):
    if data[i] in [0x3F, 0xBF] and data[i + 9] in [0x3F, 0xBF] and hold[i]:
        hold[i] = False
        hold[i + 9] = False

ansData = bytearray()

for i in range(len(data)):
    if hold[i]:
        ansData.append(data[i])
    else:
        ansData.append(0x3F + 0xBF - data[i])
        print(hex(i + 0x350))

ansContent = preData + ansData + afterData

outFile = open('2+.pyc', 'wb')
outFile.write(ansContent)
outFile.close()
