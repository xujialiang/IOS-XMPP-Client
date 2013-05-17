//
//  RecommendFriend.h
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RecommendFriend : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * read;

@end
