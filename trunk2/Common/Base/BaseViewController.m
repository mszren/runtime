//
//  BaseViewController.m
//  ipadConference
//
//  Created by caoliang on 13-5-20.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () {
    BOOL _iToRoot;
}
@end

@implementation BaseViewController
@synthesize messageListner;

#pragma mark -
#pragma mark Initialization and teardown
- (id)initWithNibName:(NSString*)nibNameOrNil
               bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _iToRoot = NO;
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        _iToRoot = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BGViewColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setBackToRoot:(BOOL)iToRoot
{
    _iToRoot = iToRoot;
}
#pragma mark -
#pragma mark private Method
- (void)setRedNavBg
{
    [self.navigationController.navigationBar setBarTintColor:HomeNavBarBgColor];
    self.navigationController.navigationBar.alpha = 1.0;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:HomeNavBarTitleColor];
}
- (void)setWhiteNavBg
{
    [self.navigationController.navigationBar
        setBarTintColor:HomeNavBarTitleColor];
    self.navigationController.navigationBar.alpha = 1.0;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:HomeNavBarBgColor];
}

- (void)setCleanNavBg
{

    [self.navigationController.navigationBar
        setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.alpha = 0.5;
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:HomeNavBarTitleColor];
}

- (void)initializeNavTitleView:(NSString*)titileStr
{
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = HomeNavBarTitleColor;
    titleLab.font = HomeNavBarTitleFont;
    titleLab.text = titileStr;
    titleLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLab;
}
- (void)initializeNavBackView
{
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setLeftPersonAction
{
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"personIcon.png"]
                style:UIBarButtonItemStylePlain
               target:self
               action:@selector(leftPersonAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftPersonAction:(id)sender
{
    Class someClass = NSClassFromString(@"PersonController");
    BaseViewController* controller = [[someClass alloc] init];
    controller.messageListner = self;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)leftItemAction:(id)sender
{
    if (_iToRoot)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)inviteBtnAction:(id)sender
{
    Class someClass = NSClassFromString(@"InviteFriendsController");
    UIViewController* controller = [[someClass alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)initializeWhiteBackgroudView:(NSString*)titileStr
{
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = HomeNavBarBgColor;
    titleLab.font = HomeNavBarTitleFont;
    titleLab.text = titileStr;
    titleLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLab;
}

#pragma mark -
#pragma mark UIDevice InterfaceOrientations
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

#pragma mark RouteMessage Delegate
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    if ([self isKindOfClass:[UIView class]] &&
        [(UIView*)self superview] != nil &&
        [[(UIView*)self superview]
            conformsToProtocol:@protocol(MessageRoutable)]) {
        [(id<MessageRoutable>)[(UIView*)self superview] RouteMessage:message
                                                         withContext:context];
    }
    else if ([self respondsToSelector:@selector(messageListner)] && self.messageListner &&
        [[self messageListner]
                 conformsToProtocol:@protocol(MessageRoutable)]) {
        [[self messageListner] RouteMessage:message withContext:context];
    }
    else if ([self isKindOfClass:[UIView class]]) {
        UIView* superView = [(UIView*)self superview];
        while (superView) {
            if ([superView conformsToProtocol:@protocol(MessageRoutable)]) {
                break;
            }
            superView = [superView superview];
        }
        if (superView) {
            [(id<MessageRoutable>)superView RouteMessage:message withContext:context];
        }
    }
}

@end
