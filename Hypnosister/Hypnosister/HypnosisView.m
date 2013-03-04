//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView()
    @property NSArray *colors;
@end

@implementation HypnosisView

//Page 144 - Adding Init With Frame override
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        //All HypnosisViews start with a clear background color
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
        [self setColors:@[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor purpleColor]] ];
    }
    return self;
}

- (void) setCircleColor:(UIColor *)clr{
    _circleColor = clr;
    [self setNeedsDisplay];
}

//Page 154
- (BOOL) canBecomeFirstResponder{
    return YES;
}

//Page 154
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{    
    if(motion == UIEventSubtypeMotionShake){
        NSLog(@"Device started shaking!");
        if([self circleColor] == [UIColor grayColor]){
            [self setCircleColor:[UIColor lightGrayColor]];
        }else{
            [self setCircleColor:[UIColor grayColor]];
        }
    }
}

//Page 141
- (void) drawRect:(CGRect)rect{
    CGRect bounds = [self bounds];
    
    //Page 142
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width /2.0;
    center.y = bounds.origin.x + bounds.size.height /2.0;
    
    // Changed on Page 147 - Increase the size of the Radius by
    //  reducing the divisor from 4.0 to 2.0
    // The radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) /2.0;
    
    // Replaced on Page 146
//    //Add an arc to the path at center with radius of maxRadius,
//    // from 0 to 2*PI radians (a circle)
//    [path addArcWithCenter:center
//                    radius:maxRadius
//                startAngle:0.0
//                  endAngle:M_PI*2.0
//                 clockwise:YES];
    //Page 146
    int count = 0;
    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        UIBezierPath *path = [[UIBezierPath alloc] init];
        UIColor *ringColor = [[self colors] objectAtIndex:count++ % [[self colors] count]];
        [ringColor set];
        //Page 147 - "Lifting the pencil off the paper for each sub circle"
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI*2.0
                     clockwise:YES];
        
        [path setLineWidth:10];
        [path stroke];
    }
    
    //Configure line width to 10points
    
    //CHanged on page 153
    // Configure the drawing color to gray
    //[[UIColor grayColor] set];
    ////[[self circleColor] setStroke];
    
    // Draw the line!
    //[path stroke];
    
    
    //Page 148 - Adding Text to a View
    NSString *text = @"You are getting sleeepy.";
    CGRect textRect;
    
    // Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    //Page 149 - Adding a Shadow
    //Create the attributed string
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    // Figure out the range of the whole string
    NSRange range = NSMakeRange(0, [attrString length]);
    
    // Set the drawing font for the whole string to font
    [attrString addAttribute:NSFontAttributeName value:font range:range];

    //Create a shadow object
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(4, 3)];
    [shadow setShadowColor:[UIColor darkGrayColor]];
    
    //Set the shadow for the whole string
    [attrString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    for(int i=0;i<[attrString length];i++){
        if(i % 2 == 0) {
            // Make even index characters light Gray
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor lightGrayColor]
                               range:NSMakeRange(i, 1)];
        }else{
            // Make odd index characters Black
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:[UIColor blackColor]
                               range:NSMakeRange(i, 1)];
        }
    }
    // Determine the size of this strong
    textRect.size = [attrString size];
    
    // Replaced on Page 149
    // How big is the string when rawn in this font?
    //textRect.size = [text sizeWithFont:font];
    
    // Let's put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width /2.0;
    textRect.origin.y = center.y - textRect.size.height /2.0;
    
    //Replaced on Page 150
    // Set the current fill color to black
    //[[UIColor blackColor] set];
    
    // Draw the String to the view
    //[text drawInRect:textRect
    //        withFont:font];
    
    //Draw the Attributed String
    [attrString drawInRect:textRect];
}
@end
