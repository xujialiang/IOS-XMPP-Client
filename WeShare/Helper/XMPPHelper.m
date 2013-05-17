//
//  XMPPHelper.m
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "XMPPHelper.h"
#import "XMPP.h"
#import "BuddyListDelegate.h"
#import "ChatDelegate.h"
#import "Common.h"
#import "XMPPRoster.h"
#import "XMPPRosterMemoryStorage.h"
#import "XMPPvCardTemp.h"
#import "XMPPvCardTempModule.h"
#import "XMPPvCardCoreDataStorage.h"
#import "Message.h"
#import "XMPPRosterMemoryStorage.h"
#import "XMPPJID.h"
@interface XMPPHelper()

@property (strong,nonatomic) CallBackBlock success;
@property (strong,nonatomic) CallBackBlockErr fail;
@property (strong,nonatomic) CallBackBlock regsuccess;
@property (strong,nonatomic) CallBackBlockErr regfail;
@property (strong,nonatomic) XMPPRosterMemoryStorateCallBack xmppRosterscallback;
@property (strong,nonatomic) XMPPvCardTemp *myVcardTemp;
@property (strong,nonatomic) XMPPRosterMemoryStorage *xmppRosterMemoryStorage;
@property (strong,nonatomic) XMPPRoster *xmppRoster;
@end
@implementation XMPPHelper

- (void)setupStream {
	self.xmppStream = [[XMPPStream alloc] init];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    self.xmppRosterMemoryStorage = [[XMPPRosterMemoryStorage alloc] init];
    self.xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:self.xmppRosterMemoryStorage];
    [self.xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self.xmppRoster activate:self.xmppStream];
}

- (void)goOnline {
	XMPPPresence *presence = [XMPPPresence presence];
	[[self xmppStream] sendElement:presence];
}

- (void)goOffline {
	XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	[[self xmppStream] sendElement:presence];
}

-(BOOL)connect:(NSString *)account password:(NSString *)password host:(NSString *)host success:(CallBackBlock)Success fail:(CallBackBlockErr)Fail{
    [self setupStream];
    self.password=password;
    self.success=Success;

    self.fail=Fail;
    if (![self.xmppStream isDisconnected]) {
        return YES;
    }
    
    if (account == nil) {
        return NO;
    }
    
    [self.xmppStream setMyJID:[XMPPJID jidWithString:account]];
    [self.xmppStream setHostName:host];
    
    //连接服务器
    NSError *err = nil;
    if (![self.xmppStream connectWithTimeout:30 error:&err]) {
        NSLog(@"cant connect %@", host);
        Fail(err);
        return NO;
    }
    
    return YES;
}

-(void) reg:(NSString *)account password:(NSString *)password host:(NSString *)host success:(CallBackBlock)success fail:(CallBackBlockErr)fail{
    self.xmpptype=reg;
    self.account=[account stringByAppendingString:Domain];
    self.password=password;
    self.regsuccess=success;
    self.regfail=fail;
    [self connect:self.account password:password host:host success:success fail:fail];
}

-(void)disconnect{
    [self goOffline];
    [self.xmppStream disconnect];
}

//获取所有联系人
-(void)getCompleteRoster:(XMPPRosterMemoryStorateCallBack)callback{
    self.xmppRosterscallback=callback;
    [self.xmppRoster fetchRoster];
}

- (void)updateVCard:(XMPPvCardTemp *)vcard success:(CallBackBlock)success fail:(CallBackBlockErr)fail{
    self.success=success;
    self.fail=fail;
    [self.xmppvCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self.xmppvCardTempModule updateMyvCardTemp:vcard];

}

-(XMPPvCardTemp *)getmyvcard{
    self.xmppvCardTemp =[self.xmppvCardTempModule myvCardTemp];
    return self.xmppvCardTemp;
}

-(XMPPvCardTemp *)getvcard:(NSString *)account{
    [self.xmppvCardTempModule fetchvCardTempForJID:[XMPPJID jidWithString:[account stringByAppendingString:Domain]]];
    return [self.xmppvCardTempModule vCardTempForJID:[XMPPJID jidWithString:[account stringByAppendingString:Domain]] shouldFetch:YES];
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid
{
    NSLog(@"%@",vCardTemp);
}

- (void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule{
    NSLog(@"%@",vCardTempModule);
    self.success();
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule failedToUpdateMyvCard:(NSXMLElement *)error{
    NSLog(@"%@",error);
    NSError *err=[[NSError alloc] initWithDomain:@"im.xujialiang.net" code:-1000 userInfo:nil];
    self.fail(err);
}

//添加好友
-(void)addFriend:(NSString *)user{
    [self.xmppRoster addUser:[XMPPJID jidWithString:[user stringByAppendingString:Domain]] withNickname:nil];
}
//删除好友
-(void)delFriend:(NSString *)user{
    [self.xmppRoster removeUser:[XMPPJID jidWithString:[user stringByAppendingString:Domain]]];
}

//处理加好友
-(void)addOrDenyFriend:(Boolean)issubscribe user:(NSString *)user{
    XMPPJID *jid=[XMPPJID jidWithString:[NSString stringWithFormat:@"%@%@",user,Domain]];
    if(issubscribe){
        [self.xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:NO];
    }else{
        [self.xmppRoster rejectPresenceSubscriptionRequestFrom:jid];
    }
}

//发送消息
- (void)sendMessageTo:(Message *)message{

    if (message.message.length > 0) {
        //XMPPFramework主要是通过KissXML来生成XML文件
        //生成<body>文档
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message.message];
        
        //生成XML消息文档
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        //消息类型
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:@"to" stringValue:message.to];
        //由谁发送
        [mes addAttributeWithName:@"from" stringValue:message.from];
        //组合
        [mes addChild:body];
        //发送消息
        [[self xmppStream] sendElement:mes];
    }
}
//===========XMPP委托事件============

//此方法在stream开始连接服务器的时候调用
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"connected");
    NSError *error = nil;
    
    if(self.xmpptype==reg){
        [[self xmppStream] setMyJID:[XMPPJID jidWithString:self.account]];
        NSError *error=nil;
        if (![[self xmppStream] registerWithPassword:self.password error:&error])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"创建帐号失败"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        
    }else{
        //验证密码
        [[self xmppStream] authenticateWithPassword:self.password error:&error];
        if(error!=nil)
        {
            self.fail(error);
        }
    }
}

//此方法在stream连接断开的时候调用
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"disconnected：%@",error);
}

// 2.关于验证的
//验证失败后调用
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"not authenticated");
    NSError *err=[[NSError alloc] initWithDomain:@"WeShare" code:-100 userInfo:@{@"detail": @"ot-authorized"}];
    self.fail(err);
}

//验证成功后调用
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    
    self.xmppvCardStorage=[XMPPvCardCoreDataStorage sharedInstance];
    self.xmppvCardTempModule=[[XMPPvCardTempModule alloc]initWithvCardStorage:self.xmppvCardStorage];
    self.xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:self.xmppvCardTempModule];
    [self.xmppvCardTempModule   activate:self.xmppStream];
    [self.xmppvCardAvatarModule activate:self.xmppStream];
    [self getmyvcard];
    NSLog(@"authenticated");
    [self goOnline];
    self.success();
}

// 3.关于通信的
//收到消息后调用
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    if(msg!=nil){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:msg forKey:@"msg"];
        [dict setObject:from forKey:@"sender"];
        //消息接收到的时间
        [dict setObject:[Common getCurrentTime] forKey:@"time"];
        
        //消息委托(这个后面讲)
        [self.chatDelegate newMessageReceived:dict];
    }
}

//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    self.regsuccess();
}

//注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error{
    NSError *err=[[NSError alloc] initWithDomain:@"WeShare" code:-100 userInfo:@{@"detail": @"reg fail"}];
    self.regfail(err);
}

//接受到好友状态更新
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    
    if ([presenceType isEqualToString:@"subscribe"]) {
        [self.processFriendDelegate processFriend:presence];
    }
    else if([presenceType isEqualToString:@"error"]){
        NSLog(@"错误");
    }
    else{
        //当前用户
        NSString *userId = [[sender myJID] user];
        //在线用户
        NSString *presenceFromUser = [[presence from] user];
        if (![presenceFromUser isEqualToString:userId]) {
            //在线状态
            if ([presenceType isEqualToString:@"available"]) {
                //用户列表委托(后面讲)
                [self.buddyListDelegate newBuddyOnline:[NSString stringWithFormat:@"%@", presenceFromUser]];
                
            }else if ([presenceType isEqualToString:@"unavailable"]) {
                //用户列表委托(后面讲)
                [self.buddyListDelegate buddyWentOffline:[NSString stringWithFormat:@"%@", presenceFromUser]];
            }
        }
    }
}

//fetchRoster后，将结果回调方式传来。
- (void)xmppRosterDidPopulate:(XMPPRosterMemoryStorage *)sender{
    if(self.xmppRosterscallback){
        self.xmppRosterscallback(sender);
    }
    NSLog(@"%@",sender);
}

@end
