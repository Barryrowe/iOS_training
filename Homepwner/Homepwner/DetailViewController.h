//
//  DetailViewController.h
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) BNRItem *item;

@end
