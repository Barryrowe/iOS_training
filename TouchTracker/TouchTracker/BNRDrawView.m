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
    UIPanGestureRecognizer *_moveRecognizer;
    NSMutableDictionary *_linesInProgress;
    NSMutableArray *_finishedLines;
}

@property (nonatomic, weak) BNRLine *selectedLine;
- (BNRLine *)lineAtPoint:(CGPoint)p;
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
        
        //Build and set our DoubleTap Gesture Recognizer
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(doubleTap:)];
        [doubleTapRecognizer setNumberOfTapsRequired:2];
        [doubleTapRecognizer setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:doubleTapRecognizer];
        
        //Build and set our Tap Gesture Recognizer to select a line
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tap:)];
        [tapRecognizer setDelaysTouchesBegan:YES];
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        //BUild and set our Long Press Gesture Recognizer
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                      action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        // BUild and set our Pan Gesture Recognizer
        _moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        [_moveRecognizer setDelegate:self];
        [_moveRecognizer setCancelsTouchesInView:NO];
        [self addGestureRecognizer:_moveRecognizer];
    }
    return self;
}

- (BOOL) canBecomeFirstResponder{
    return YES;
}

//Touch Events
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
//UIGestureRecognizerDelegate Implementation
//
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(gestureRecognizer == _moveRecognizer){
        return YES;
    }
    
    return NO;
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
    
    //Draw any selected Line
    if([self selectedLine]){
        [[UIColor greenColor] set];
        strokeLine([self selectedLine]);
    }
}

-(BNRLine *)lineAtPoint:(CGPoint)p{
    //Find a line close to p
    for(BNRLine *l in _finishedLines){
        CGPoint start = [l begin];
        CGPoint end = [l end];
        
        // Check a few points on the line
        for(float t = 0.0; t<= 1.0; t+= 0.05){
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            //If the tapped point is within 20 points, let's return the line
            if(hypot(x -p.x, y - p.y) < 20.0){
                return l;
            }
        }
    }
    
    return nil;
}

-(void) deleteLine:(id)sender{
    // Remove the selected line from the list of finishedLines
    [_finishedLines removeObject:[self selectedLine]];
    
    // Redraw everything
    [self setNeedsDisplay];
}
//-----

//
//UI Gesture Target Selectors
//
-(void) doubleTap:(UIGestureRecognizer *)gr{
    NSLog(@"Recognized Double Tap");
    
    [_linesInProgress removeAllObjects];
    [_finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

-(void) tap:(UIGestureRecognizer *)gr{
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    [self setSelectedLine:[self lineAtPoint:point]];
    
    if([self selectedLine]){
        // Make ourselves the target of menu item action messages
        [self becomeFirstResponder];
        
        // Grab the menu controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create a new Delete Menu Item
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete"
                                                            action:@selector(deleteLine:)];
        [menu setMenuItems:@[deleteItem]];
        
        // Tell the menu where it should come from and show it
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }else{
        // Hide the menu if no line is selected
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

-(void) longPress:(UIGestureRecognizer *)gr{
    if([gr state] == UIGestureRecognizerStateBegan){
        CGPoint point = [gr locationInView:self];
        [self setSelectedLine:[self lineAtPoint:point]];
        
        if([self selectedLine]){
            [_linesInProgress removeAllObjects];
        }else if([gr state] == UIGestureRecognizerStateEnded){
            [self setSelectedLine:nil];
        }
        
        [self setNeedsDisplay];
    }
}

-(void) moveLine:(UIPanGestureRecognizer *)gr{
    
    //If we ahving't selected a line, we don't do anything
    if(![self selectedLine]){
        return;
    }
    
    // When the pan recognizer changes its position...
    if([gr state] == UIGestureRecognizerStateChanged){
        // How far as the pan moved
        CGPoint translation = [gr translationInView:self];
        
        // Add the translation to the current begin and end points of the line
        CGPoint begin = [[self selectedLine] begin];
        CGPoint end = [[self selectedLine] end];
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // Set the new beginning and end points of the line
        [[self selectedLine] setBegin:begin];
        [[self selectedLine] setEnd:end];
        
        //Redraw the shit!
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}
//-----
@end
