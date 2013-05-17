//
//  SessionViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UINavigationItem *navbaritem;
@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (nonatomic,strong) NSMutableDictionary *chatsession;
@end
