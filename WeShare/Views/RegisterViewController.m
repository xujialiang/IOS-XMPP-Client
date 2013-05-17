//
//  RegisterViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "XMPP.h"
#import "XMPPHelper.h"
@interface RegisterViewController ()
@property (strong,nonatomic) AppDelegate *appdel;
@end

@implementation RegisterViewController

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
    self.appdel=[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    XMPPHelper *hepler=self.appdel.xmppHelper;
    [hepler reg:self.account.text password:self.password.text host:Host success:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"创建帐号成功"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    } fail:^(NSError *result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"创建帐号失败"
                                                            message:@"创建失败，请稍后再试。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSUserDefaults *defaultuserinfo=[NSUserDefaults standardUserDefaults];
        [defaultuserinfo setObject:self.account.text forKey:@"account"];
        [defaultuserinfo setObject:self.password.text forKey:@"password"];
        [defaultuserinfo synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)protocal:(id)sender {
    
}
@end
