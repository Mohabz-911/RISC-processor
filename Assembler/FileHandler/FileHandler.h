#ifndef _FILE_H
#define _FILE_H

typedef enum rs readState;
enum rs{
    BLANK, COMMENT, INSTRUCTION, NOMORE
};



void file_init(char** text);
readState get_instruction();

#endif