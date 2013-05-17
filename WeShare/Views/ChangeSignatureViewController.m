//
//  ChangeSignatureViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "ChangeSignatureViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"
#import "XMPPHelper.h"
#import "MyInfoViewController.h"
@interface ChangeSignatureViewController ()

@end

@implementation ChangeSignatureViewController

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
    self.signature.text=self.parasignature;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    XMPPvCardTemp *mycard= [appdel.xmppHelper getmyvcard];
    mycard.signature=self.signature.text;
    [appdel.xmppHelper updateVCard:mycard success:^{
        NSLog(@"更新成功");
        [self.infoviewController.tableview reloadData];
    } fail:^(NSError *result) {
        NSLog(@"更新失败");
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
