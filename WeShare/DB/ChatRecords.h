//
//  ChatRecords.h
//  WeShare
//
//  Created by Elliott on 13-5-9.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChatRecords : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * id;

@end
