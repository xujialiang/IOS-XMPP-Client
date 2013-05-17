//
//  OpProfileViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpProfileViewController : UIViewController

- (IBAction)deleteuser:(id)sender;
- (IBAction)cancel:(id)sender;
@property (nonatomic,strong)NSString *user;

@end
