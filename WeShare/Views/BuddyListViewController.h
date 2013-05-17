//
//  BuddyListViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuddyListDelegate.h"
@interface BuddyListViewController : UIViewController<BuddyListDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *process;

@property (strong, nonatomic) IBOutlet UITableView *FriendList;

@property (nonatomic,strong) NSMutableArray *onlineBuddies;

//分组信息
@property (nonatomic,strong) NSMutableArray *sections;
@property (nonatomic,strong) NSMutableDictionary *sectionData;
@end
