//
//  AppDelegate.h
//  WeShare
//
//  Created by Elliott on 13-5-6.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class LoginViewController;
@class BuddyListViewController;
@class XMPPHelper;
@class ChatViewController;
@class DefaultViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) DefaultViewController *defaultViewController;
@property (nonatomic,strong) XMPPHelper *xmppHelper;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic,strong)  NSMutableArray *entries;

@end
