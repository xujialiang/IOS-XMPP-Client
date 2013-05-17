//
//  MyInfoViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPvCardTemp;
@interface MyInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSDictionary *detail;
@property (nonatomic,strong) XMPPvCardTemp *mycard;

@end
