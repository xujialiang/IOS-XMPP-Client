//
//  MyInfo.h
//  WeShare
//
//  Created by Elliott on 13-5-8.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * signature;

@end
