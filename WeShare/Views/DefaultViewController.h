//
//  DefaultViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-7.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatDelegate.h"
#import "XMPPRoster.h"
#import "ProcessFriendDelegate.h"
@class BuddyListViewController;
@class SettingsViewController;
@class MyInfoViewController;
@class SessionViewController;
@interface DefaultViewController : UIViewController<ChatDelegate,XMPPRosterDelegate,ProcessFriendDelegate,UITabBarControllerDelegate>
@property (strong, nonatomic) IBOutlet SessionViewController *sessioncontroller;

@property (strong, nonatomic) IBOutlet SettingsViewController *settingController;
@property (strong, nonatomic) IBOutlet BuddyListViewController *buddyList;
@property (strong, nonatomic) IBOutlet UITabBarController *tabbar;

@property (strong,nonatomic) SettingsViewController *settingsViewController;

-(void)login;
@end
