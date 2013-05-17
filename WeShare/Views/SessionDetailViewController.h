//
//  SessionDetailViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SessionViewController;
@interface SessionDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *navbaritem;
- (IBAction)sendmessagebtn:(id)sender;

- (IBAction)back:(id)sender;

@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITableView *chatlisttableview;
@property (weak ,nonatomic) SessionViewController *sessionViewController;
@property (strong,nonatomic) NSString *from;

@property (strong,nonatomic) UIImage *photo;
@property (strong,nonatomic) UIImage *myphoto;
@end
