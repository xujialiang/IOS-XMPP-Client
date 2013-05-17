//
//  RecommendViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendFriend.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "recommendcell.h"
#import "UserInfoViewController.h"
@interface RecommendViewController ()

@property (strong,nonatomic) AppDelegate *appdel;
@property (strong,nonatomic) NSArray *receivelist;
@end

@implementation RecommendViewController

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
    self.appdel =[[UIApplication sharedApplication] delegate];
    [self GetRecommendinfo];
    // Do any additional setup after loading the view from its nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRecommendlist:nil];
    [super viewDidUnload];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoViewController *userinfo=[[UserInfoViewController alloc] init];
    userinfo.user=[[self.receivelist objectAtIndex:indexPath.row] from];
    [self presentViewController:userinfo animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.receivelist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"infoCell";
    recommendcell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"recommendcell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    //文本
    RecommendFriend *object=[self.receivelist objectAtIndex:indexPath.row];
    cell.message.text=[object.from stringByAppendingString:@"加您为好友"];
    cell.user=object.from;
    return cell;
}

-(NSArray *)GetRecommendinfo{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RecommendFriend"];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"from !=''"];
    
    NSError *error;
    
    NSArray *fetchResult = [self.appdel.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(!error){
        self.receivelist=fetchResult;
    }else{
        self.receivelist=[[NSArray alloc] init];
    }
    return fetchResult;
}



- (IBAction)clearlist:(id)sender {
    NSArray *fetchResult=[self GetRecommendinfo];
    if([fetchResult count]>0){
      for(RecommendFriend *object in fetchResult) {
          [self.appdel.managedObjectContext delete:object];
      }
      if([self.appdel.managedObjectContext hasChanges]) {
          [self.appdel.managedObjectContext save:nil];
          
      }
    }    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
