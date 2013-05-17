//
//  ChangeSubLocationViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "ChangeSubLocationViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"
#import "XMPPHelper.h"
#import "MyInfoViewController.h"
#import "ChangeLocationViewController.h"
@interface ChangeSubLocationViewController ()

@end

@implementation ChangeSubLocationViewController

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"infoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //文本
    cell.textLabel.text = [self.data objectAtIndex:[indexPath row]];
    //标记
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *address=[self.data objectAtIndex:indexPath.row];
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    XMPPvCardTemp *mycard= [appdel.xmppHelper getmyvcard];
    mycard.local=[self.city stringByAppendingFormat:@",%@",address];
    [appdel.xmppHelper updateVCard:mycard success:^{
        NSLog(@"更新成功");
        [self.infoviewController.tableview reloadData];
    } fail:^(NSError *result) {
        NSLog(@"更新失败");
    }];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.changeLocationController hide];
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
