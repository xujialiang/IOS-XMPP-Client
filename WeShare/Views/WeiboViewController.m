//
//  WeiboViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-16.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "WeiboViewController.h"
#import "AddFriendsViewController.h"
@interface WeiboViewController ()

@end

@implementation WeiboViewController

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
    self.sections=@[@"weibo",@"addfriends"];
    self.data=@{@"weibo":@[@"朋友"],@"addfriends":@[@"添加朋友"]};
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionname=[self.sections objectAtIndex:indexPath.section];
    NSArray *data=[self.data objectForKey:sectionname];
    NSString *selectedname=[data objectAtIndex:indexPath.row];
    if([selectedname isEqualToString:@"添加朋友"]){
        AddFriendsViewController *addfriendview=[[AddFriendsViewController alloc] init];
        [self presentViewController:addfriendview animated:YES completion:nil];
    }
}

//获取分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *sec=[self.sections objectAtIndex:section];
    NSArray *data=[self.data objectForKey:sec];
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *section=[self.sections objectAtIndex:indexPath.section];
    
    NSArray *data=[self.data objectForKey:section];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SectionsTableIdentifier ];
    }
    
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
