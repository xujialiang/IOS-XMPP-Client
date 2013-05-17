//
//  ChangeSignatureViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface ChangeSignatureViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *signature;
@property (strong,nonatomic) NSString *parasignature;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic,strong) MyInfoViewController *infoviewController;

@end
