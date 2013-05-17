//
//  ChangeNickNameViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface ChangeNickNameViewController : UIViewController
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *nickname;
@property (strong,nonatomic) MyInfoViewController *infoviewController;
@property (nonatomic,strong) NSString *paranickname;
@end
