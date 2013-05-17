//
//  recommendcellCell.h
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface recommendcell : UITableViewCell
- (IBAction)deny:(id)sender;
- (IBAction)accept:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong,nonatomic) NSString *user;
@end
