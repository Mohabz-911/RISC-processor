#include <stdio.h>
#include "FileHandler.h"

#define CODEFILE "../code.asm"
#define BINFILE "../Instructions.txt"
#define MAX_NUMBER_OF_CHARACTERS 20
#define INSTRUCTION_WIDTH 16

FILE *codefileptr, *binfileptr;
char line[MAX_NUMBER_OF_CHARACTERS];
char bin[INSTRUCTION_WIDTH];

void file_init(char **text)
{
    *text = line;
    codefileptr = fopen(CODEFILE, "r");
    //binfileptr = fopen(BINFILE, "w");
}


readState get_instruction()
{
    char *ptr;
    if(fgets(line, MAX_NUMBER_OF_CHARACTERS, codefileptr) == NULL)
        return NOMORE;
    ptr = line;
    
    while(*ptr == ' ' && ptr-line <= MAX_NUMBER_OF_CHARACTERS)
        ptr++;
    if(*ptr == '\n' || *ptr == ' ')
        return BLANK;
    if(line[0] == '#')
        return COMMENT;
    
    return INSTRUCTION;
}

//Change this func to main for testing
void test()
{
    char * temp;
    char count = 1;
    file_init(&temp);

    if(get_instruction() == COMMENT)
        printf("PASSED: Test #%d\n", count);
    else printf("FAILED: Test #%d\n", count);
    count++;

    if(get_instruction() == BLANK)
        printf("PASSED: Test #%d\n", count);
    else printf("FAILED: Test #%d\n", count);
    count++;

    if(get_instruction() == INSTRUCTION)
        printf("PASSED: Test #%d\n", count);
    else printf("FAILED: Test #%d\n", count);
    count++;
}