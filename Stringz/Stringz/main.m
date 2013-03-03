//
//  main.m
//  Stringz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableString *str = [[NSMutableString alloc] init];
        for(int i = 0;i<10;i++){
            [str appendString:@"Lights Out. Guerrilla Radio\n"];
        }
        
        //Always use nil with Objective-C objects
        NSError *error = nil;
    
        
        BOOL success = [str writeToFile:@"/tmp/testtmp/cool.txt"
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&error];
        
        if(success){
            NSLog(@"Done Writing /tmp/cool.txt");
        }else{
            NSLog(@"Error occurred!: %@", [error localizedDescription]);
        }

        
        //Read a File
        NSString *s = [[NSString alloc] initWithContentsOfFile:@"/etc/resolv.conf" encoding:NSASCIIStringEncoding error:&error];
        
        if(!s){
            NSLog(@"read failed: %@", [error localizedDescription]);
        }else{
            NSLog(@"Resolv.conf is: %@", s);
        }
        
        
        //Read a remote file
        NSURL *url = [NSURL URLWithString:@"http://www.google.com/image/logo/ps_logo2.png"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSError *urlError = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL
                                                         error:&urlError];
        
        if(!data){
            NSLog(@"Fetch failed: %@", [urlError localizedDescription]);
        }else{
            NSLog(@"The file is %lu bytes", [data length]);
            BOOL written = [data writeToFile:@"/tmp/ps_logo2.png" options:0 error:&urlError];
            if(!written){
                NSLog(@"Error Writing Data: %@", [urlError localizedDescription]);
            }else{
                NSLog(@"Image written successfully");
            }
        }
        
        
    }
    return 0;
}

