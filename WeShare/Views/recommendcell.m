//
//  recommendcellCell.m
//  WeShare
//
//  Created by Elliott on 13-5-17.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "recommendcell.h"
#import "AppDelegate.h"
#import "XMPPHelper.h"
@implementation recommendcell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)accept:(id)sender {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    [appdel.xmppHelper addOrDenyFriend:YES user:self.user];

}
- (IBAction)deny:(id)sender {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    [appdel.xmppHelper addOrDenyFriend:NO user:self.user];
    
}
@end
