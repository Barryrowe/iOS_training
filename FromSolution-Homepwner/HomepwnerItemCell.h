//
//  HompepwnerItemCell.h
//  Homepwner
//
//  Created by Admin on 3/6/13.
//
//

#import <Foundation/Foundation.h>

@interface HomepwnerItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

// Hold a pointer to the ItemViewController and Table View to send messages to
@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *owningTableView;


@end
