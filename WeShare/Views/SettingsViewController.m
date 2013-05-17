//
//  SettingsViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "DefaultViewController.h"
#import "MyInfoViewController.h"
@interface SettingsViewController ()
@property (strong,nonatomic) AppDelegate *appdel;
@end

@implementation SettingsViewController

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"settingmenu"
                                                     ofType:@"plist"];
    //实例化一个字典
    NSDictionary *dict = [[NSDictionary alloc]
                          initWithContentsOfFile:path];
    self.menus=dict;
    NSArray *array = [[dict allKeys] sortedArrayUsingSelector:
                      @selector(compare:)];
    self.menukeys = array;
    // Do any additional setup after loading the view from its nib.
}

//获取分区的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menukeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.menukeys objectAtIndex:section];
    NSArray *menudetail = [self.menus objectForKey:key];
    return [menudetail count];
}

//行的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取第几分区
    NSUInteger section = [indexPath section];
    //获取行
    NSUInteger row = [indexPath row];
    
    NSString *key = [self.menukeys objectAtIndex:section];
    NSArray *nameSection = [self.menus objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SectionsTableIdentifier ];
    }
    
    cell.textLabel.text = [nameSection objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//点击每一个数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            self.myInfoViewController=[[MyInfoViewController alloc] init];
            [self.view addSubview:self.myInfoViewController.view];
            
            break;
        }
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:{
            NSUserDefaults *defaultuserinfo=[NSUserDefaults standardUserDefaults];
            [defaultuserinfo removeObjectForKey:@"account"];
            [defaultuserinfo removeObjectForKey:@"password"];
            [defaultuserinfo synchronize];
            self.appdel=[[UIApplication sharedApplication] delegate];
            [self.appdel.defaultViewController login];
            break;
        }
        
        default:
            break;
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
