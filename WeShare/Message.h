//
//  Message.h
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

//JID
@property (nonatomic,strong) NSString *from;
@property (nonatomic,strong) NSString *to;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSDate *date;

@end
