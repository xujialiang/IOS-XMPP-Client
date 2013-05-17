//
//  ProcessFriendDelegate.h
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMPPPresence;
@protocol ProcessFriendDelegate <NSObject>

-(void)processFriend:(XMPPPresence *)processFriend;

@end
