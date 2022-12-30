#ifndef _PROCESSOR_H
#define _PROCESSOR_H

typedef enum os operationState;
enum os{
    INVALID, END, NOP, SINGLE, DOUBLE
};

const char instructions[27][4] = {
    "NOP",
    "SETC",
    "CLRC",
    "RET",
    "RTI",
    "CALL",
    "DEC",
    "INC",
    "JZ",
    "JN",
    "JC",
    "JMP",
    "IN",
    "NOT",
    "OUT",
    "PUSH",
    "POP",
    "ADD",
    "AND",
    "LDM",
    "LDD",
    "MOV",
    "OR",
    "SUB",
    "SHL",
    "SHR",
    "STD"
};

const char opCodes[27][5] = {
    "11111",
    "00001",
    "00011",
    "11100",
    "11101",
    "11110",
    "10000",
    "00010",
    "11000",
    "11001",
    "11010",
    "11011",
    "00110",
    "10110",
    "00100",
    "01100",
    "01101",
    "00000",
    "10011",
    "00111",
    "01110",
    "00101",
    "10010",
    "10001",
    "10100",
    "10101",
    "01111"  
};

const char regs[8][2] = {
    "R0",
    "R1",
    "R2",
    "R3",
    "R4",
    "R5",
    "R6",
    "R7"
};

const char addresses[8][3] = {
    "000",
    "001",
    "010",
    "011",
    "100",
    "101",
    "110",
    "111"
};

char index;

operationState process_operation(char* text, char** bin);
//pos = 1 for Rsrc, pos = 2 for Rdst
void           process_operand(char* text, char** bin, char pos);

#endif


// void hash_func()
// {
//     codefileptr = fopen("lol.txt", "r");
//     binfileptr = fopen("lol2.txt", "w");

//     char *ptr;
//     unsigned long long hash, m, i;
//     while(fgets(line, MAX_NUMBER_OF_CHARACTERS, codefileptr) != NULL)
//     {
//         ptr = line;
//         hash = 0;
//         m = 1e9+9;
//         i = 1;
//         while(*ptr != '\n')
//         {
//             hash = (hash + (*ptr - 'A' + 1)*i) % m;
//             i = i * 13;
//             ptr++;
//         }
//         hash = hash % 173;
//         fprintf(binfileptr, "%d\n", hash);
//     }
// }