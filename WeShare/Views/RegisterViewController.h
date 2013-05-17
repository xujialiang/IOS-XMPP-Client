//
//  RegisterViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
- (IBAction)cancel:(id)sender;
- (IBAction)protocal:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *account;
- (IBAction)register:(id)sender;

@end
