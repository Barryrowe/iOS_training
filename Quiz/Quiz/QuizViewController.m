//
//  QuizViewController.m
//  Quiz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        questions = @[@"Question 1", @"Question 2", @"What DID she say?"];
        answers = @[@"Answer 1", @"Answer 2", @"You're an idiot.."];
        [answerButton setEnabled:NO];
    }
    return self;
}

- (IBAction)showQuestion:(id)sender{
    NSLog(@"ShowQuestion Fired. CUrrent Index: %d", currentQuestionIndex);
    [questionField setText:[questions objectAtIndex:currentQuestionIndex]];
    [answerField setText:@"----"];
    [answerButton setEnabled:YES];
}

- (IBAction)showAnswer:(id)sender{
    NSLog(@"ShowAnswer Fired!!!");
    [answerField setText:[answers objectAtIndex:currentQuestionIndex++]];
    [sender setEnabled:NO];
    if(currentQuestionIndex >= [questions count]){
        currentQuestionIndex = 0;
    }
}

@end
