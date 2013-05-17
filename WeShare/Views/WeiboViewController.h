//
//  WeiboViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSDictionary *data;;

@end
