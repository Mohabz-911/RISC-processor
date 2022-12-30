#include <stdio.h>
#include "processor.h"
#include "string.h"

operationState process_operation(char* text, char** bin)
{
    char i;

    index = 0;
    char temp [4] = {'$','$','$','$'};
    pass_whitespace(&text);
    i = 0;
    while(*(text+i) != ' ')
    {
        temp[i] = *(text+i);
        i++;    index++;
    }

    if(strcmp(temp,"END") == 0)
        return END;

    i = 0;
    while(strcmp(temp,instructions[i]) != 0 && i < 27) i++;
    
    if(i == 27) return INVALID;

    strcpy(*bin,opCodes[i]);
    if(i < 5) return NOP;
    if(i < 17) return SINGLE;
    return DOUBLE;

}

void process_operand(char* text, char** bin, char pos)
{
    char i;
    char temp [5] = {'$','$','$','$','$'};
    text = text + index;
    pass_whitespace(&text);

    i = 0;
    while(*(text+i) != ' ' || *(text+i) != ',' || *(text+i) != '\n')
    {
        temp[i] = *(text+i);
        i++;    index++;
    }

    if(temp[0] == 'R')
    {
        while(strcmp(temp,instructions[i]) != 0 && i < 8) i++;
        //EDIT: Unhandled case of wrong register
        strcpy((*bin)+(5*pos), addresses[i]);
    }
    //EDIT: Immediate value not handled
}

void pass_whitespace(char **t)
{
    while(**t == ' ')
    {
        *t++;
        index++;
    }
}
