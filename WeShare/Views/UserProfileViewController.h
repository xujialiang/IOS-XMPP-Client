//
//  UserProfileViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-14.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIImageView;
@class XMPPvCardTemp;
@interface UserProfileViewController : UIViewController
- (IBAction)more:(id)sender;
- (IBAction)cancel:(id)sender;

- (IBAction)sendmessage:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *sexpic;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *remarkname;
@property (strong, nonatomic) IBOutlet UILabel *jid;
@property (strong, nonatomic) IBOutlet UILabel *nickname;

@property (strong,nonatomic) XMPPvCardTemp *vcard;

@property (strong, nonatomic) NSString *pararemarkname;
@property (strong, nonatomic) NSString *parajid;
@property (strong, nonatomic) NSString *paranickname;

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSString *user;
@end
