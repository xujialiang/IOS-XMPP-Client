//
//  ChangePhotoViewController.h
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoViewController;
@interface ChangePhotoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *image;
- (IBAction)selectlocalphoto:(id)sender;
- (IBAction)camera:(id)sender;

@property (nonatomic,strong) MyInfoViewController *infoviewController;

@end
