//
//  OpProfileViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "OpProfileViewController.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
#import "DefaultViewController.h"
#import "BuddyListViewController.h"
@interface OpProfileViewController ()

@end

@implementation OpProfileViewController

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

- (IBAction)deleteuser:(id)sender {
    AppDelegate *appdel =[[UIApplication sharedApplication] delegate];
    [appdel.xmppHelper delFriend:self.user];
    [appdel.defaultViewController.buddyList.FriendList reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
