//
//  XMPPHelper.h
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProcessFriendDelegate.h"
@class XMPPStream;
@class XMPPRosterMemoryStorage;
@class XMPPvCardCoreDataStorage;
@class XMPPvCardTempModule;
@class XMPPvCardAvatarModule;
@class XMPPvCardTemp;
@class Message;
@class XMPPPresence;
@interface XMPPHelper : NSObject

typedef void (^CallBackBlock) (void);
typedef void (^XMPPRosterMemoryStorateCallBack) (XMPPRosterMemoryStorage *rosters);
typedef void (^CallBackBlockErr) (NSError *result);

typedef enum {
    reg,
    login
}xmpptype;//枚举名称

@property (nonatomic,strong) XMPPStream *xmppStream;
@property (nonatomic,strong) XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (nonatomic,strong) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic,strong) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic,strong) XMPPvCardTemp *xmppvCardTemp;

@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *password;

@property (nonatomic, retain)id buddyListDelegate;
@property (nonatomic, retain)id chatDelegate;
@property (nonatomic, retain)id xmpprosterDelegate;
@property (nonatomic,retain) id processFriendDelegate;
@property (nonatomic) xmpptype xmpptype;

- (void) setupStream;
- (void) goOnline;
- (void) goOffline;
-(BOOL)connect:(NSString *)account password:(NSString *)password host:(NSString *)host success:(CallBackBlock)Success fail:(CallBackBlockErr)Fail;
-(void) reg:(NSString *)account password:(NSString *)password host:(NSString *)host success:(CallBackBlock)success fail:(CallBackBlockErr)fail;

- (void)updateVCard:(XMPPvCardTemp *)vcard success:(CallBackBlock)success fail:(CallBackBlockErr)fail;
-(XMPPvCardTemp *)getmyvcard;
-(XMPPvCardTemp *)getvcard:(NSString *)account;
-(void)getCompleteRoster:(XMPPRosterMemoryStorateCallBack)callback;
- (void)sendMessageTo:(Message *)message;
-(void)addOrDenyFriend:(Boolean)issubscribe user:(NSString *)user;
-(void)addFriend:(NSString *)user;
-(void)delFriend:(NSString *)user;
@end
