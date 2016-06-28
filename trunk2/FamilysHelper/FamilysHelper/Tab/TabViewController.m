//
//  TabViewController.m
//  JobsCenter
//
//  Created by caoliang on 14-1-7.
//  Copyright (c) 2014年 caoliang. All rights reserved.
//

#import "TabViewController.h"

#import "HomeController.h"
#import "BangBangController.h"
#import "ShopController.h"
#import "IndexController.h"
#import "ActionHandler.h"

@interface TabViewController ()

@end

@implementation TabViewController{
   
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;
    self.selectedIndex = 0;

    _actionHandler = [[ActionHandler alloc] init];

    IndexController* controller1 = [[IndexController alloc] init];
    controller1.messageListner = self;

    BangBangController* controller2 = [[BangBangController alloc] init];
    controller2.messageListner = self;

    ShopController* controller3 = [[ShopController alloc] init];
    controller3.messageListner = self;

    HomeController* controller4 = [[HomeController alloc] init];
    controller4.messageListner = self;

    nav1 = [[BaseNavController alloc] initWithRootViewController:controller1];

    nav2 = [[BaseNavController alloc] initWithRootViewController:controller2];
    nav3 = [[BaseNavController alloc] initWithRootViewController:controller3];

    nav4 = [[BaseNavController alloc] initWithRootViewController:controller4];

    self.viewControllers = @[ nav1, nav2, nav3, nav4 ];

    UITabBarItem* item1 = [self.tabBar.items objectAtIndex:0];
    UIImage* item1Image = [UIImage imageNamed:@"tabbar_home_selected"];
    item1Image =
        [item1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = item1Image;
    [item1 setImage:[UIImage imageNamed:@"tabbar_home_normal"]];
    item1.title = @"首页";
    
    UITabBarItem* item2 = [self.tabBar.items objectAtIndex:1];
    UIImage* item2Image = [UIImage imageNamed:@"tabbar_bang_selected"];
    item2Image =
        [item2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = item2Image;
    [item2 setImage:[UIImage imageNamed:@"tabbar_bang_normal"]];
    item2.title = @"帮帮";

    UITabBarItem* item3 = [self.tabBar.items objectAtIndex:2];
    UIImage* item3Image = [UIImage imageNamed:@"tabbar_shop_selected"];
    item3Image =
        [item3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = item3Image;
    [item3 setImage:[UIImage imageNamed:@"tabbar_shop_normal"]];
    item3.title = @"商家";

    UITabBarItem* item5 = [self.tabBar.items objectAtIndex:3];
    UIImage* item5Image = [UIImage imageNamed:@"tabbar_myhome_selected"];
    item5Image =
        [item5Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = item5Image;
    [item5 setImage:[UIImage imageNamed:@"tabbar_myhome_normal"]];
    item5.title = @"我家";

    self.tabBar.tintColor = HomeNavBarBgColor;
    self.tabBar.barTintColor = TabBarColor;
    
 
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITabBarController Delegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController
    shouldSelectViewController:(UIViewController*)viewController
{

    return YES;
}

- (void)tabBarController:(UITabBarController*)tabBarController
 didSelectViewController:(UIViewController*)viewController
{
}

#pragma mark -
#pragma mark UIDevice InterfaceOrientations
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark RoutedMessages
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    [_actionHandler excuteAction:message context:context];
}

@end
