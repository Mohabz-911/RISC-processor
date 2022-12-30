#include <stdio.h>
#include "App.h"
#include "../FileHandler/FileHandler.h"
#include "../InstructionProcessor/processor.h"

#define MAX_BLANK_LINES 10

void App()
{
    char *line, *bin;
    char exitFlag, errorFlag;
    long index;
    readState textStatus;
    operationState opStatus;

    errorFlag = 0;
    exitFlag = 0;
    index = 0;
    file_init(&line);

    while(1)     //TO BE EDITED
    {
        index++;
        textStatus = get_instruction();
        if(textStatus == NOMORE)
        {
            printf("\nError: END not found");
            return;
        }
        if(textStatus == COMMENT)
            continue;
        if(textStatus == BLANK) 
        {
            exitFlag++;
            if(exitFlag == MAX_BLANK_LINES)
            {
                printf("\nError: More blank lines than allowed");
                return;
            }
            continue;
        }
        else 
            exitFlag = 0;
        
        opStatus = process_operation(line, &bin);
        if(opStatus == INVALID)
        {
            errorFlag = 1;
            printf("line %d: Unsupported instruction", index);
            continue;
        }
        if(opStatus == END)
        {
            printf("\n\nExecutable generated successfuly!");
            return;
        }
        if(opStatus == NOP) continue;
        
        process_operand(&line, &bin, 1);
        if(opStatus == DOUBLE)
            process_operand(&line, &bin, 2);
    }
}