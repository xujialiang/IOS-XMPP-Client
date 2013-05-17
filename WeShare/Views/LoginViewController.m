//
//  LoginViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "LoginViewController.h"
#import "XMPPHelper.h"
#import "AppDelegate.h"
#import "DefaultViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
    
@end

@implementation LoginViewController

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

- (IBAction)BtnLogin:(id)sender {
    if(self.account.text.length>0 && self.password.text.length>0)
    {
        NSUserDefaults *defaultuserinfo=[NSUserDefaults standardUserDefaults];
        [defaultuserinfo setObject:self.account.text forKey:@"account"];
        [defaultuserinfo setObject:self.password.text forKey:@"password"];
        [defaultuserinfo synchronize];
        [self Connect];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)Connect
{
    [self.processbar startAnimating];
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    appdel.xmppHelper.xmpptype=login;
    [appdel.xmppHelper connect:[self.account.text stringByAppendingString:Domain] password:self.password.text host:Host success:^(void) {
        NSLog(@"成功");
        [self.processbar stopAnimating];
        appdel.xmppHelper.buddyListDelegate=appdel.defaultViewController;
        appdel.xmppHelper.chatDelegate=appdel.defaultViewController;
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(NSError *result) {
        NSLog(@"失败");
        [self.processbar stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"账号或密码错误，请重新填写" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (IBAction)register:(id)sender {
    RegisterViewController *regviewController=[[RegisterViewController alloc] init];
    [self presentViewController:regviewController animated:YES completion:nil];
}
@end
