//
//  ChangeLocationViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-13.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "ChangeLocationViewController.h"
#import "DDXML.h"
#import "ChangeSubLocationViewController.h"
@interface ChangeLocationViewController ()

@end

@implementation ChangeLocationViewController

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
    //从工程目录获取XML文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"xml"];
    //获取NSData对象并开始解析
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    [self parseXML:xmlData];
    [self.tableview reloadData];
}

-(NSArray *)parseXMLSub:(NSData *) data withID:(NSString *)cityid{
    //文档开始（KissXML和GDataXML一样也是基于DOM的解析方式）
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    
    //利用XPath来定位节点（XPath是XML语言中的定位语法，类似于数据库中的SQL功能）
    NSArray *Districts = [xmlDoc nodesForXPath:@"//Districts//District" error:nil];
    self.subdata=[[NSMutableArray alloc] init];
    for (DDXMLElement *province in Districts) {
        NSString *id = [[province attributeForName:@"CID"] stringValue];
        if([id isEqualToString:cityid])
        {
            NSString *DistrictName=[[province attributeForName:@"DistrictName"] stringValue];
            [self.subdata addObject:DistrictName];
        }
    }
    return self.subdata;
}

-(void)parseXML:(NSData *) data
{
    //文档开始（KissXML和GDataXML一样也是基于DOM的解析方式）
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    
    //利用XPath来定位节点（XPath是XML语言中的定位语法，类似于数据库中的SQL功能）
    NSArray *users = [xmlDoc nodesForXPath:@"//Cities//City" error:nil];
    self.provinces=[[NSMutableDictionary alloc] init];
    self.data=[[NSMutableArray alloc] init];
    for (DDXMLElement *province in users) {
        NSString *id = [[province attributeForName:@"ID"] stringValue];
        NSString *provincename=[[province attributeForName:@"CityName"] stringValue];
        [self.provinces setObject:id forKey:provincename];
        [self.data addObject:provincename];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name=[self.data objectAtIndex:indexPath.row];
    NSLog(@"%@",name);
    NSString *id=[self.provinces objectForKey:name];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Districts" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    ChangeSubLocationViewController *viewController=[[ChangeSubLocationViewController alloc] init];
    viewController.infoviewController=self.infoviewController;
    viewController.changeLocationController=self;
    viewController.city=name;
    viewController.data=[self parseXMLSub:xmlData withID:id];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self hide];
}

- (IBAction)hide{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
