//
//  QuizViewController.h
//  Quiz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController{
    int currentQuestionIndex;
    
    //The Model objects
    NSArray *questions;
    NSArray *answers;
    
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;

    IBOutlet UIButton *questionButton;
    IBOutlet UIButton *answerButton;

}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
