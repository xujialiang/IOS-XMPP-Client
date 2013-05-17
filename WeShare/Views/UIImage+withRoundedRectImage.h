//
//  UIImage+withRoundedRectImage.h
//  WeShare
//
//  Created by Elliott on 13-5-14.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (withRoundedRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
