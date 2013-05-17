//
//  DefaultViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-7.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "DefaultViewController.h"
#import "XMPPHelper.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BuddyListViewController.h"
#import "ChatRecords.h"
#import "Common.h"
#import "SettingsViewController.h"
#import "XMPPUserMemoryStorageObject.h"
#import "XMPPRosterMemoryStorage.h"
#import "Message.h"
#import "SessionViewController.h"
#import "RecommendFriend.h"
@interface DefaultViewController ()

@property (nonatomic,strong) AppDelegate *appdel;

@end

@implementation DefaultViewController

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
    self.appdel=[[UIApplication sharedApplication] delegate];
    self.tabbar.view.frame=self.view.bounds;
    [self.view addSubview:self.tabbar.view];
   }

- (void)viewDidAppear:(BOOL)animated {

	[super viewDidAppear:animated];
	[self login];
}

-(void)login{
    NSString *logacc = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    NSUserDefaults *defaultuserinfo=[NSUserDefaults standardUserDefaults];
    if (logacc) {
        self.appdel.xmppHelper.xmpptype=login;
        [self.appdel.xmppHelper connect:[[defaultuserinfo objectForKey:@"account"] stringByAppendingString:Domain] password:[defaultuserinfo objectForKey:@"password"] host:Host success:^(void) {
            NSLog(@"登陆成功");
            self.appdel.xmppHelper.buddyListDelegate=self;
            self.appdel.xmppHelper.chatDelegate=self;
            self.appdel.xmppHelper.processFriendDelegate=self;
            [self.appdel.xmppHelper getCompleteRoster:^(XMPPRosterMemoryStorage *rosters) {
                NSArray *users=[rosters sortedUsersByName];
                for (XMPPUserMemoryStorageObject *user in users) {
                    [self newBuddyOnline:user.jid.user];
                }
            }];
            

        } fail:^(NSError *result) {
            NSLog(@"失败");
            //[self.processbar stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"账号或密码错误，请重新填写" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有设置账号" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        LoginViewController *viewController=[[LoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

//接收到新消息
-(void)newMessageReceived:(NSDictionary *)messageCotent{
    
    NSUserDefaults *defaultuserinfo=[NSUserDefaults standardUserDefaults];
    NSRange range = [[messageCotent objectForKey:@"sender"] rangeOfString:@"@"];
    NSString *to=[defaultuserinfo objectForKey:@"account"];
    NSString *from=[[messageCotent objectForKey:@"sender"] substringToIndex:range.location];
    NSDate *receivetime=[Common getCurrentTimeFromString:[messageCotent objectForKey:@"time"]];
    NSString *content=[messageCotent objectForKey:@"msg"];
    
    Message *message=[[Message alloc] init];
    message.to=to;
    message.from=from;
    message.date=receivetime;
    message.message=content;
    
    //缓存消息
    if(self.sessioncontroller.chatsession==nil){
        self.sessioncontroller.chatsession=[[NSMutableDictionary alloc] init];
    }
    NSMutableArray *messages=nil;
    if([self.sessioncontroller.chatsession objectForKey:from]==nil){
        messages=[[NSMutableArray alloc] init];
        [messages addObject:message];
        [self.sessioncontroller.chatsession setObject:messages forKey:from];
    }else{
        messages=[self.sessioncontroller.chatsession objectForKey:from];
        [messages addObject:message];
        [self.sessioncontroller.chatsession removeObjectForKey:from];
        [self.sessioncontroller.chatsession setObject:messages forKey:from];
    }
    [self.sessioncontroller.table reloadData];
    //未读的消息
    ChatRecords *record = [NSEntityDescription
                        insertNewObjectForEntityForName:@"ChatRecords"
                        inManagedObjectContext:self.appdel.managedObjectContext];
    if (record != nil){
        NSString *account=to;
        record.from=from;
        record.to=account;
        record.time=receivetime;
        record.message=content;
        NSError *savingError = nil;
        if ([self.appdel.managedObjectContext save:&savingError]){
            //NSLog(@"Successfully saved the context.");
        } else {
            //NSLog(@"Failed to save the context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to create the new person.");
    }
}

//处理好友请求
-(void)processFriend:(XMPPPresence *)processFriend{
    //添加到DB中。
    NSLog(@"有好友请求");
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RecommendFriend"];
    NSString *username=[[processFriend from] user];
    NSString *predicate=[@"from ==" stringByAppendingFormat:@"'%@'",username];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:predicate];
    NSError *error;
    
    NSArray *fetchResult = [self.appdel.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(!error){
        if(fetchResult.count>0) return;
        else{
            RecommendFriend *record = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"RecommendFriend"
                                       inManagedObjectContext:self.appdel.managedObjectContext];
            
            if (record != nil){
                record.from=[[processFriend from] user];
                record.read=NO;
                record.content=@"xxx";
                NSError *savingError = nil;
                if ([self.appdel.managedObjectContext save:&savingError]){
                    NSLog(@"Successfully saved the context.");
                } else {
                    NSLog(@"Failed to save the context. Error = %@", savingError);
                }
            } else {
                NSLog(@"Failed to create the new person.");
            }
        }
        
    }else{
        NSLog(@"%@",error);
    }
    
    
}

//在线好友
-(void)newBuddyOnline:(NSString *)buddyName{
    if(self.buddyList.onlineBuddies==nil){
        self.buddyList.onlineBuddies = [[NSMutableArray alloc ] init];
    }
    if (![self.buddyList.onlineBuddies containsObject:buddyName]) {
        [self.buddyList.onlineBuddies addObject:buddyName];
        [self.buddyList.FriendList reloadData];
    }
}

//好友下线
-(void)buddyWentOffline:(NSString *)buddyName{
    [self.buddyList.onlineBuddies removeObject:buddyName];
    [self.buddyList.FriendList reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if([viewController isKindOfClass:[SettingsViewController class]]){
        if([viewController.view.subviews count]>=3){
            [[viewController.view.subviews objectAtIndex:2] removeFromSuperview];
        }
    }
}



@end
