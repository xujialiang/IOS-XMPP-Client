//
//  ChatListCell.h
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *countbuddle;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *lastmessage;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
