//
//  AddFriendsViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "UserInfoViewController.h"
@interface AddFriendsViewController ()

@end

@implementation AddFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload {
    [self setAccount:nil];
    [super viewDidUnload];
}
- (IBAction)search:(id)sender {
    UserInfoViewController *userinfo=[[UserInfoViewController alloc] init];
    userinfo.user=self.account.text;
    [self presentViewController:userinfo animated:YES completion:nil];
}
@end
