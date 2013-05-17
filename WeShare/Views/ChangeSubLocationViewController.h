//
//  ChangeSubLocationViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MyInfoViewController;
@class ChangeLocationViewController;
@interface ChangeSubLocationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)cancel:(id)sender;

@property (nonatomic,strong) MyInfoViewController *infoviewController;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) ChangeLocationViewController *changeLocationController;
@property (nonatomic,strong) NSString *city;
@end
