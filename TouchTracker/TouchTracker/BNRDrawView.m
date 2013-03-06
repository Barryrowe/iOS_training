//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Admin on 3/6/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView(){
    NSMutableDictionary *_linesInProgress;
    NSMutableArray *_finishedLines;
}

@end

@implementation BNRDrawView

//
//UIView Implementations
//
-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _linesInProgress = [[NSMutableDictionary alloc] init];
        _finishedLines = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor grayColor]];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches){
        CGPoint location = [t locationInView:self];

        BNRLine *line = [[BNRLine alloc] init];
        [line setBegin:location];
        [line setEnd:location];
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [_linesInProgress setObject:line
                             forKey:key];
    }
    
    [self setNeedsDisplay];
}

-(void) touchesMoved:touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = [_linesInProgress objectForKey:key];
        [line setEnd:[t locationInView:self]];
    }
    [self setNeedsDisplay];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = [_linesInProgress objectForKey:key];
        
        [_finishedLines addObject:line];
        [_linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [_linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}
//-----



//
//Custom Implementations
//
-(void) drawRect:(CGRect)rect{
    // Create a block that will configure and draw a BNRLine
    void (^strokeLine)(BNRLine *) = ^(BNRLine *line){
        UIBezierPath *bp = [UIBezierPath bezierPath];
        [bp moveToPoint:[line begin]];
        [bp addLineToPoint:[line end]];
        [bp setLineWidth:10];
        [bp setLineCapStyle:kCGLineCapRound];
        
        //Draw our bezierPath to the view
        [bp stroke];
    };
    
    // Draw Finished Lines in black
    [[UIColor blackColor] set];
    for(BNRLine *line in _finishedLines){
        strokeLine(line);
    }
    
    [[UIColor redColor] set];
    for(NSValue *key in _linesInProgress){
        BNRLine *line = [_linesInProgress objectForKey:key];        
        strokeLine(line);
    }
}
//-----
@end
