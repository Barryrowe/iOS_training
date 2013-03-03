//
//  main.m
//  ObjectiveCDemo
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
    int numOfHoles;
    BOOL isFrosted;
    char *typeName;
    
} Donut;

void printMessages(int i){

    for(int x = 0;x < i; x++){
        printf("Some Message\n");
    }
}

void printRemainderAndIntegral(double val){
    double integral;
    double remainder = modf(val, &integral);
    
    printf("Remainder: %f\nIntegral: %f", remainder, integral);
}

void printDonut(Donut *theDonut){
    
    printf("The donut has %d holes", theDonut->numOfHoles);
    if(theDonut->isFrosted){
        printf(" and is frosted\n");
    }
    printf(".");
}

int main(int argc, const char * argv[])
{
    
    
    //@ creates an NS String, and %@ allows us to provide any
    //  objective C object
    NSString *helloMsg = @"Hello Class! %@";
    NSString *helloMsg2 = @"Hello Class! |%06.3e|";
    NSLog(helloMsg, helloMsg);
    NSLog(helloMsg2, 1.123456);
    
    Donut bostonCream;
    bostonCream.numOfHoles = 0;
    bostonCream.isFrosted = YES;
    
    printMessages(10);
    printDonut(&bostonCream);
    
    
    
    //Malloc Stuff
    char *msg = malloc(sizeof(char)*11);
    strcpy(msg, "HelloWorld");

    return 0;
}

