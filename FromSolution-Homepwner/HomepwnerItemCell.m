//
//  HompepwnerItemCell.m
//  Homepwner
//
//  Created by Admin on 3/6/13.
//
//

#import "HomepwnerItemCell.h"

@implementation HomepwnerItemCell

- (void) awakeFromNib{
    // Remove any constraints we have from the views
    for(UIView *v in [[self contentView] subviews]){
        [v setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    // Name all of the views for the visual format String
    NSDictionary *names = @{@"image": [self thumbnailView],
                            @"name":[self nameLabel],
                            @"serial":[self serialNumberLabel],
                            @"value":[self valueLabel]};
    
    // Create a horizontal constraint
    NSString *fmt = @"H:|-2-[image(==40)]-[name]-[value(==42)]-|";
    
    // Create the constraints from this visual format string
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
                                                                   options:0
                                                                   metrics:nil
                                                                     views:names];
    //[[self serialNumberLabel] setFont:[UIFont fontWithName:@"System" size:13]];

    // Add the constraints to the content view, which is the superview
    // for all of our cell's content
    [[self contentView] addConstraints:constraints];
    
    fmt = @"V:|-1-[name(==20)]-(>=0)-[serial(==20)]-1-|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
                                                          options:NSLayoutFormatAlignAllLeft
                                                          metrics:nil
                                                            views:names];
    [[self contentView] addConstraints:constraints];
    
    NSArray * (^constraintBuilder)(UIView *, float);
    constraintBuilder = ^(UIView *view, float height){
        return @[
                 // Constraint 0: Center Y of incoming view to contentView
                 [NSLayoutConstraint constraintWithItem:view
                                               attribute:NSLayoutAttributeCenterY
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:[self contentView]
                                               attribute:NSLayoutAttributeCenterY
                                              multiplier:1.0
                                                constant:0],
                 [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:0.0
                                               constant:height]
                 ];
    };
    
    constraints = constraintBuilder([self thumbnailView], 40);
    [[self contentView] addConstraints:constraints];
    
    constraints = constraintBuilder([self valueLabel], 21);
    [[self contentView] addConstraints:constraints];
    
    //Create transparent button, give it target-action pair and add it
    //  to the contentView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self
               action:@selector(showImage:)
     forControlEvents:UIControlEventTouchUpInside];
    [[self contentView] addSubview:button];
    
    // Configure names dictionary and format string to apply constraints
    names = @{@"button": button,
              @"image" :[self thumbnailView],
              @"name": [self nameLabel]};
    
    fmt = @"H:|-2-[button(==image)]-[name]";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
                                                          options:0
                                                          metrics:nil
                                                            views:names];
    [[self contentView] addConstraints:constraints];
    
    //Apply centerY and ehigth Constraint
    [[self contentView] addConstraints:constraintBuilder(button, 40)];
}

- (void) showImage:(id)sender{
    
    
    //Get the current command "showImage:"
    NSString *selector = NSStringFromSelector(_cmd);
    
    //Append "atIndexPath:" which we know completes the
    //  format of our Controller's implementation
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    
    //Prepare a Selector from this string
    SEL newSelector = NSSelectorFromString(selector);

    NSIndexPath *path = [[self owningTableView] indexPathForCell:self];
    if(path){
        if([[self controller] respondsToSelector:newSelector]){
            [[self controller] performSelector:newSelector
                                    withObject:self
                                    withObject:path];
        }
    }
}
@end
