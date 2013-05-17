//
//  SessionViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "SessionViewController.h"
#import "ChatListCell.h"
#import "Message.h"
#import "Common.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
#import "XMPPvCardTemp.h"
#import "SessionDetailViewController.h"
@interface SessionViewController ()

@end

@implementation SessionViewController

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
    return [[self.chatsession allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"userCell";
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ChatListCell" owner:self options:nil];
    cell=[nib objectAtIndex:0];
    
    NSString *from=[self.chatsession.allKeys objectAtIndex:indexPath.row];
    NSArray *messages=[self.chatsession objectForKey:from];
    Message *message=[messages lastObject];
    
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    XMPPvCardTemp *card=[appdel.xmppHelper getvcard:from ];
    UIImage *image=[[UIImage alloc] initWithData:card.photo];
    cell.photo.image=image;
    cell.nickname.text=from;
    cell.time.text=[Common getmessageTime:message.date];
    cell.lastmessage.text=message.message;
    
    cell.countbuddle.image=[Common imageFromText:messages.count image:[UIImage imageNamed:@"bi2y2t.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *jid=[self.chatsession.allKeys objectAtIndex:indexPath.row];
    SessionDetailViewController *detail=[[SessionDetailViewController alloc] init];
    detail.from=jid;
    [self presentViewController:detail animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNavbar:nil];
    [self setNavbaritem:nil];
    [super viewDidUnload];
}
@end
