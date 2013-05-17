//
//  BuddyListViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "BuddyListViewController.h"
#import "UserProfileViewController.h"
#import "RecommendViewController.h"

@interface BuddyListViewController ()

@end

@implementation BuddyListViewController

-(id)init
{
    if(self=[super init])
    {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sections=[[NSMutableArray alloc] init];
    [self.sections addObject:@"推荐"];
    [self.sections addObject:@"星标朋友"];
    [self.sections addObject:@"通讯录"];
    self.sectionData=[[NSMutableDictionary alloc] init];
    [self.sectionData setObject:@[@"新的朋友"] forKey:@"推荐"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionname=[self.sections objectAtIndex:indexPath.section];
    
    
    NSString *name=[[self.sectionData objectForKey:sectionname] objectAtIndex:indexPath.row];
    if([name isEqualToString:@"新的朋友"]){
        RecommendViewController *recommendviewctrl=[[RecommendViewController alloc] init];
        [self presentViewController:recommendviewctrl animated:YES completion:nil];
    }else{
        UserProfileViewController *userinfo=[[UserProfileViewController alloc] init];
        userinfo.parajid=[self.onlineBuddies objectAtIndex:indexPath.row];
        [self presentViewController:userinfo animated:YES completion:nil];
    }
}

//获取分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *sectionname=[self.sections objectAtIndex:section];
    if(section==0){
        return [[self.sectionData objectForKey:sectionname] count];
    }else if(section==1){
        return [[self.sectionData objectForKey:sectionname] count];
    }
    else{
        return [self.onlineBuddies count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *sectionname=[self.sections objectAtIndex:indexPath.section];
    if(indexPath.section==0){
        NSArray *data=[self.sectionData objectForKey:sectionname];
        cell.textLabel.text = [data objectAtIndex:indexPath.row];
    }
    else if(indexPath.section==1){
        NSArray *data=[self.sectionData objectForKey:sectionname];
        cell.textLabel.text = [data objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.onlineBuddies objectAtIndex:[indexPath row]];
    }
    //标记
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//分组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *name=[self.sections objectAtIndex:section];
    return name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
