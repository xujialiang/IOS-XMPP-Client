//
//  UserInfoViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserProfileCell.h"
#import "XMPPvCardTemp.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
#import "DefaultViewController.h"
#import "BuddyListViewController.h"
@interface UserInfoViewController ()
@property (nonatomic,strong)AppDelegate *appdel;
@end

@implementation UserInfoViewController

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
    self.appdel=[[UIApplication sharedApplication] delegate];
    self.vcard= [self.appdel.xmppHelper getvcard:self.user];
    UIImage *image=[[UIImage alloc] initWithData:self.vcard.photo];
    self.photo.image=image;
    self.nickname.text=self.vcard.jid.bare;
    self.account.text=self.user;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPhoto:nil];
    [self setAccount:nil];
    [self setAddfriend:nil];
    [self setNickname:nil];
    [super viewDidUnload];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addfriend:(id)sender {
    [self.appdel.xmppHelper addFriend:self.user];
    [self.appdel.defaultViewController.buddyList.FriendList reloadData];
    
}
@end
