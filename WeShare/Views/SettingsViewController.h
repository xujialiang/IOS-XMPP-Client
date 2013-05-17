//
//  SettingsViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface SettingsViewController : UIViewController

@property (nonatomic,strong) NSArray *menukeys;
@property (nonatomic,strong) NSDictionary *menus;

@property (nonatomic,strong) MyInfoViewController *myInfoViewController;

@end
