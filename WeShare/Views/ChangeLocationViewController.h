//
//  ChangeLocationViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface ChangeLocationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray *subdata;
@property (nonatomic,strong) MyInfoViewController *infoviewController;
@property (nonatomic,strong) NSMutableDictionary *provinces;

- (IBAction)hide;
@end
