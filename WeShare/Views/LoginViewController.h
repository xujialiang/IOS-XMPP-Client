//
//  LoginViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)register:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *processbar;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *account;
- (IBAction)BtnLogin:(id)sender;

@end
