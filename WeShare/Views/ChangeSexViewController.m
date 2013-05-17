//
//  ChangeSexViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "ChangeSexViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"
#import "XMPPHelper.h"
#import "MyInfoViewController.h"
@interface ChangeSexViewController ()

@property (nonatomic,strong) NSString *sex;

@end

@implementation ChangeSexViewController

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
    self.array=@[@"男",@"女",@"双性",@"无性"];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.array objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.sex=[self.array objectAtIndex:row];
}

- (IBAction)save:(id)sender {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    XMPPvCardTemp *mycard= [appdel.xmppHelper getmyvcard];
    mycard.sex=self.sex;
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
