//
//  DetailViewController.m
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)takePicture:(id)sender;

@end

@implementation DetailViewController

//
// Custom Implementation Methods
//
- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)takePicture:(id)sender{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    //If our device has a camera we want to take a picture, otherwise we
    //  pick from photo library
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    //Mark our Detail View controller as the Image Picker's Delegate
    [ipc setDelegate:self];
    
    //Provide users the option to Edit the selected Image
    [ipc setAllowsEditing:YES];
    
    //Load up our Image Picker
    [self presentViewController:ipc animated:YES completion:nil];
}
//-----

//
//UIImagePickerControllerDelegate Implementations
//
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *oldKey = [[self item] imageKey];
    
    if(oldKey){
        // Delete that old ass image
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }
    UIImage *image = nil;
    //Get the picked image from info Dictionary
    if([info objectForKey:UIImagePickerControllerEditedImage]){
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    // Create a NSUUID object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    
    [[self item] setImageKey:key];
    
    //Store that image in the ImageStore Sucka!
    [[BNRImageStore sharedStore] setImage:image forKey:[[self item]imageKey]];
    
    // Put that image onto the screen in our image view
    [[self imageView] setImage:image];
    
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-----


//
//UITextFieldDelegate Implementations
//
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//-----

//
//UIViewController Overrides
//
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BNRItem *item = [self item];
    [[self nameField] setText:[item itemName]];
    [[self serialNumberField] setText:[item serialNumber]];
    [[self valueField] setText:[NSString stringWithFormat:@"%d",[item valueInDollars]]];
    
    //Create a NSDate Fromater that will format our date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set the Date Label
    [[self dateLabel] setText:[formatter stringFromDate:[item dateCreated]]];
    
    NSString *imageKey = [[self item] imageKey];
    if(imageKey){
        [[self imageView] setImage:[[BNRImageStore sharedStore] imageForKey:imageKey]];
    }else{
        [[self imageView] setImage:nil];
    }
}

- (void) viewWillDisappear:(BOOL)animated   {
    [super viewWillDisappear:animated];
    
    // Clear First Responder
    [[self view] endEditing:YES];
    
    // "Save" our changes to the item
    BNRItem *item = [self item];
    [item setItemName:[[self nameField] text]];
    [item setSerialNumber:[[self serialNumberField] text]];
    [item setValueInDollars:[[[self valueField] text] intValue]];
}

- (void) setItem:(BNRItem *)item{
    _item = item;
    [[self navigationItem] setTitle:[[self item] itemName]];
}
//-----

@end
