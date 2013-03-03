//
//  main.c
//  HelloWorld
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#include <stdio.h>


int add150(int a){
    printf("Before Adding 150: %d\n", a);
    return a + 150;
}

int bottlesOfBeer(int howMany){

    printf("%d bottles of beer on the wall, %d bottles of beer\n", howMany, howMany);
    if(howMany > 0){
        printf("Take one down, pass it around, %d bottles of beer on the wall!", --howMany);
        bottlesOfBeer(howMany);
    }
    printf("%d more bottles for recycling");
    
    return howMany;
    
    
}

int main(int argc, const char * argv[])
{
    //Objective-C Variables are initialized to Zero
    int x =6;
    int truckWeight = 4000;
    
    bottlesOfBeer(99);
    size_t sizeOfInt = (int)sizeof(int);
    // insert code here...
    printf("X is %d\n", x);
    printf("Size of X is %zu\n", sizeOfInt);
    
    if(truckWeight >= 4000){
        printf("It's a big ol' truck!");
    }
    
    
    while(truckWeight < 10000){
        truckWeight = add150(truckWeight);
    }
    
    printf("Address of main function %p", main);
    return 0;
}

