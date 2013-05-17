//
//  ChangeSexViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface ChangeSexViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) MyInfoViewController *infoviewController;

@end
