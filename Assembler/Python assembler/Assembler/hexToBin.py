def hexToBin(numInHex):
    d = int(numInHex, base=16)
    string = str(bin(d))
    return string[2:]


string = hexToBin("A2")
print (string)    


