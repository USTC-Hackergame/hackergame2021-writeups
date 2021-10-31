m = 10786438895794676833086727730725585957654356232962279513537416470909
file = open("flag.txt", "wb")
bytes = int.to_bytes(m, 28, byteorder='big')
file.write(bytes)
