def hexToBin(numInHex):
    d = int(numInHex, base=16)
    string = str(bin(d))
    return string[2:]



file1 = open("D:\MOHAMED ENGINEERING\cmp\\third year\Computer Architecture\Project\Assembler\myFile.txt","r")
newFile = open("D:\MOHAMED ENGINEERING\cmp\\third year\Computer Architecture\Project\Assembler\\new.txt","w")


# this part to remove comments
breaked = False
for x in file1:
    breaked = False
    if (x[0] != "#"):
        line = ""
        for char in x:
            if (char != "#"):
                line = line + char
            else:
                breaked = True
                break
        newFile.write(line)  
        if (breaked):      
            newFile.write("\n") 
file1.close()
newFile.close()
newFile = open("D:\MOHAMED ENGINEERING\cmp\\third year\Computer Architecture\Project\Assembler\\new.txt","r")
instructionMemo = open("D:\MOHAMED ENGINEERING\cmp\\third year\Computer Architecture\Project\Assembler\instructionMemo.txt","w")
allLines = []
isInt = False
intCout = 0

# intialize the interrupt part with zeros
for i in range (0, 32):
    if (i == 31):
        allLines.append("0")      
    else:
        allLines.append("0\n")        


# looping line by line in the new text file        
for line in newFile:
    instruction = ""
    arr = line.split()     # split the line to the instruction and the operands
    if (arr[0] == "NOP"):
        instruction = instruction + "00000"
    elif (arr[0] == "SETC"):
        instruction = instruction + "00001"    
    elif (arr[0] == "CLRC"):
        instruction = instruction + "00011"   
    elif (arr[0] == "OUT"):
        instruction = instruction + "00100"   
    elif (arr[0] == "IN"):
        instruction = instruction + "00110"   
    elif (arr[0] == "MOV"):
        instruction = instruction + "00101"   
    elif (arr[0] == "IDM"):
        instruction = instruction + "00111"   
    elif (arr[0] == "INC"):
        instruction = instruction + "00010"   
    elif (arr[0] == "ADD"):
        instruction = instruction + "00000"   
    elif (arr[0] == "PUSH"):
        instruction = instruction + "01100"   
    elif (arr[0] == "POP"):
        instruction = instruction + "01101"   
    elif (arr[0] == "LDD"):
        instruction = instruction + "01110"   
    elif (arr[0] == "STD"):
        instruction = instruction + "01111"   
    elif (arr[0] == "DEC"):
        instruction = instruction + "10000"   
    elif (arr[0] == "SUB"):
        instruction = instruction + "10001"   
    elif (arr[0] == "OR"):
        instruction = instruction + "10010"   
    elif (arr[0] == "AND"):
        instruction = instruction + "10011"   
    elif (arr[0] == "SHL"):
        instruction = instruction + "10100"   
    elif (arr[0] == "SHR"):
        instruction = instruction + "10101"   
    elif (arr[0] == "NOT"):
        instruction = instruction + "10110"   
    elif (arr[0] == "JZ"):
        instruction = instruction + "11000"   
    elif (arr[0] == "JN"):
        instruction = instruction + "11001"   
    elif (arr[0] == "JC"):
        instruction = instruction + "11010"   
    elif (arr[0] == "JMP"):
        instruction = instruction + "11011"   
    elif (arr[0] == "INT"):
        instruction = instruction + "01000"   
    elif (arr[0] == "CALL"):
        instruction = instruction + "01001"   
    elif (arr[0] == "RET"):
        instruction = instruction + "11100"   
    elif (arr[0] == "RTI"):
        instruction = instruction + "11101"   
    elif (arr[0] == "RESET"):
        instruction = instruction + "11110"   

    # To be edited    
    elif (arr[0] == ".ORG"):
        if (arr[1] == "0"):       # interrupt
            isInt = True
        elif (arr[1] == "20"):    # return to code
            isInt = False    


    # split the two operands  ( the instruction has two operands )
    if (',' in arr[1]):
        reg = arr[1].split(',')
        if (reg[0] == "R0"):
            instruction = instruction + "000"
        elif (reg[0] == "R1"):
            instruction = instruction + "001"    
        elif (reg[0] == "R2"):
            instruction = instruction + "010"    
        elif (reg[0] == "R3"):
            instruction = instruction + "011"    
        elif (reg[0] == "R4"):
            instruction = instruction + "100"    
        elif (reg[0] == "R5"):
            instruction = instruction + "101"    
        elif (reg[0] == "R6"):
            instruction = instruction + "110"    
        elif (reg[0] == "R7"):
            instruction = instruction + "111"    
        if (arr[0] == "LDD" or arr[0] == "SHR" or arr[0] == "SHL"):       # convert immediate values from hex to binary
            instruction = instruction + hexToBin(reg[1])  
        else:
            if (reg[1] == "R0"):
                instruction = instruction + "000"
            elif (reg[1] == "R1"):
                instruction = instruction + "001"    
            elif (reg[1] == "R2"):
                instruction = instruction + "010"    
            elif (reg[1] == "R3"):
                instruction = instruction + "011"    
            elif (reg[1] == "R4"):
                instruction = instruction + "100"    
            elif (reg[1] == "R5"):
                instruction = instruction + "101"    
            elif (reg[1] == "R6"):
                instruction = instruction + "110"    
            elif (reg[1] == "R7"):
                instruction = instruction + "111"       

    # the instruction has one operand            
    else:
        if (arr[1] == "R0"):
            instruction = instruction + "000"
        elif (arr[1] == "R1"):
            instruction = instruction + "001"    
        elif (arr[1] == "R2"):
            instruction = instruction + "010"    
        elif (arr[1] == "R3"):
            instruction = instruction + "011"    
        elif (arr[1] == "R4"):
            instruction = instruction + "100"    
        elif (arr[1] == "R5"):
            instruction = instruction + "101"    
        elif (arr[1] == "R6"):
            instruction = instruction + "110"    
        elif (arr[1] == "R7"):
            instruction = instruction + "111"     


    if (len(instruction) > 0 and len(instruction) < 16):     # append zeros to complete 16 bit
        while (len(instruction) < 16):
            instruction = instruction + "0"           
    
    if (isInt == False):                            # it is not interrupt so put it in code part
        allLines.append(instruction + "\n")
    else:                                          # it is interrupt so put it in interrupt part
        allLines[intCout] = instruction + "\n"
        intCout = intCout + 1    
    

instructionMemo.writelines(allLines)      
instructionMemo.close()    