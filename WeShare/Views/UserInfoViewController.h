//
//  UserInfoViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPvCardTemp;
@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)addfriend:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *account;
@property (strong, nonatomic) IBOutlet UILabel *nickname;

- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addfriend;

@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (nonatomic,strong) NSArray *data;

@property (nonatomic,strong) XMPPvCardTemp *vcard;

@property (nonatomic,strong) NSString *user;
@end
