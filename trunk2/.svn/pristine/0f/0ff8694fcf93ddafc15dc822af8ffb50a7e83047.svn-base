//
//  AppDelegate.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/3.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;
@property (strong, nonatomic) UIWindow* loginWindow;
@property (strong, nonatomic) TabViewController* tabController;
 

+ (AppDelegate*)shareDelegate;

- (void)loadLoginController;
- (void)loadHomeController;

- (void)showTabbar:(BOOL)isShow;

- (BOOL)checkIsExistUser;
@end
