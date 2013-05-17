//
//  MyInfoViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "MyInfoViewController.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
#import "XMPPvCardTemp.h"
#import "MyInfoViewCell.h"
#import "MyInfoViewWithImageCell.h"
#import "ChangeNickNameViewController.h"
#import "ChangeSexViewController.h"
#import "ChangeLocationViewController.h"
#import "ChangeSignatureViewController.h"
#import "ChangePhotoViewController.h"
#import "DefaultViewController.h"
@interface MyInfoViewController ()

@property (nonatomic,strong)AppDelegate *appdel;

@end

@implementation MyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//获取分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.sections objectAtIndex:section];
    NSArray *menudetail = [self.detail objectForKey:key];
    return [menudetail count];
}

//行的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取第几分区
    NSUInteger section = [indexPath section];
    //获取行
    NSUInteger row = [indexPath row];
    
    NSString *key = [self.sections objectAtIndex:section];
    NSArray *nameSection = [self.detail objectForKey:key];
    
    NSString *currenttitle=[nameSection objectAtIndex:row];
    
    MyInfoViewCell *cell = nil;
    MyInfoViewWithImageCell *imagecell=nil;

    NSArray *nib=nil;
    if([currenttitle isEqualToString:@"头像"]){
        nib=[[NSBundle mainBundle]loadNibNamed:@"MyInfoVIewWithImageCell" owner:self options:nil];
        imagecell=[nib objectAtIndex:0];
    }
    else{
        nib=[[NSBundle mainBundle]loadNibNamed:@"MyInfoViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.title.text = [nameSection objectAtIndex:row];
    }
    


    if([currenttitle isEqualToString:@"头像"]){
        NSData *photoData=self.mycard.photo;
        UIImage *image = [[UIImage alloc]initWithData:photoData];
        imagecell.photo.image=image;
        imagecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return imagecell;
    }else if([currenttitle isEqualToString:@"昵称"]){
        cell.content.text=self.mycard.nickname;
    }else if([currenttitle isEqualToString:@"微享号"]){
        cell.content.text=self.mycard.jid.user;
    }else if([currenttitle isEqualToString:@"性别"]){
        cell.content.text=self.mycard.sex;
    }else if([currenttitle isEqualToString:@"地区"]){
        cell.content.text=self.mycard.local;
    }else if([currenttitle isEqualToString:@"个性签名"]){
        cell.content.text=self.mycard.signature;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0 && indexPath.section==0){
        return 80;
    }
    else {
        return 45;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger secindex=indexPath.section;
    NSInteger rowindex=indexPath.row;
    NSString *sectionname=[self.sections objectAtIndex:secindex];
    NSArray *rows=[self.detail objectForKey:sectionname];
    NSString *selectname=[rows objectAtIndex:rowindex];
    if([selectname isEqualToString:@"昵称"]){
        ChangeNickNameViewController *viewController=[[ChangeNickNameViewController alloc] init];
        viewController.infoviewController=self;
        viewController.paranickname=self.mycard.nickname;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if([selectname isEqualToString:@"性别"]){
        ChangeSexViewController *viewController=[[ChangeSexViewController alloc] init];
        viewController.infoviewController=self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if([selectname isEqualToString:@"地区"]){
        ChangeLocationViewController *viewController=[[ChangeLocationViewController alloc] init];
        viewController.infoviewController=self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if([selectname isEqualToString:@"个性签名"]){
        ChangeSignatureViewController *viewController=[[ChangeSignatureViewController alloc] init];
        viewController.parasignature=self.mycard.signature;
        viewController.infoviewController=self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if([selectname isEqualToString:@"头像"]){
        ChangePhotoViewController *viewController=[[ChangePhotoViewController alloc] init];
        viewController.infoviewController=self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.appdel=[[UIApplication sharedApplication] delegate];
    self.mycard=[self.appdel.xmppHelper getmyvcard];
    self.sections=@[@"basic",@"ex"];
    self.detail=@{@"basic": @[@"头像",@"昵称",@"微享号"],@"ex": @[@"性别",@"地区",@"个性签名"]};
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.view removeFromSuperview];
}
@end
