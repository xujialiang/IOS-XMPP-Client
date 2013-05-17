//
//  UserProfileViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-14.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
#import "XMPPvCardTemp.h"
#import "UserProfileCell.h"
#import "SessionDetailViewController.h"
#import "OpProfileViewController.h"
@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

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
    self.data=@[@"地区",@"个性签名",@"手机",@"个人相册"];
    self.jid.text=self.parajid;
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    self.vcard= [appdel.xmppHelper getvcard:self.parajid];
    UIImage *image=[[UIImage alloc] initWithData:self.vcard.photo];
    self.photo.image=image;
    self.nickname.text=self.vcard.nickname;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"infoCell";
    UserProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"UserProfileCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
    }
    //文本
    NSString *title=[self.data objectAtIndex:indexPath.row];
    cell.title.text=title;
    if([title isEqualToString:@"地区"]){
        cell.content.text=self.vcard.local;
    }
    if([title isEqualToString:@"个性签名"]){
        cell.content.text=self.vcard.signature;
    }
    if([title isEqualToString:@"手机"]){
        cell.content.text=@"暂不支持";
    }
    if([title isEqualToString:@"个人相册"]){
        cell.content.text=@"暂不支持";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)more:(id)sender {
    OpProfileViewController *opviewcontroller=[[OpProfileViewController alloc] init];
    opviewcontroller.user=self.parajid;
    [self presentViewController:opviewcontroller animated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendmessage:(id)sender {
    SessionDetailViewController *sessionDetailViewController=[[SessionDetailViewController alloc] init];
    sessionDetailViewController.from=self.parajid;
    [self presentViewController:sessionDetailViewController animated:YES completion:nil];
}
@end
