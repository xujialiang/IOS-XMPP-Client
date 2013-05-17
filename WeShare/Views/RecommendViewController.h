//
//  RecommendViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)clearlist:(id)sender;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *recommendlist;

@end
