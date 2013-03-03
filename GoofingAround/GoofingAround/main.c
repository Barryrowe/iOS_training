//
//  main.c
//  GoofingAround
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 HP_ES. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[])
{
    char *buffer = NULL;
    
    buffer = (char *)malloc(BUFSIZ*sizeof(char));
    while(1){
        printf("customShell>");
        fgets(buffer, BUFSIZ, stdin);
        
        if(buffer){
            printf("You entered: %s", buffer);
        }

        if(strcmp(buffer, "exit") == 0){
            break;
        }
    }
    free(buffer);

    return 0;
}

