//
//  AddFriendsViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendsViewController : UIViewController
- (IBAction)search:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *account;

- (IBAction)back:(id)sender;

@end
