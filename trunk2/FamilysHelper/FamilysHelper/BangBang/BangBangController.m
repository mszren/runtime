//
//  DiscoverController.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/6.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BangBangController.h"
#import "MyhelpViewController.h"
#import "MyTopicViewController.h"
#import "SetTopicViewController.h"
@interface BangBangController () <UIScrollViewDelegate> {
    UIBarButtonItem* rightButton;
    UISegmentedControl* _seg;
}

@end

@implementation BangBangController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setLeftPersonAction];
    [self initializeNavTitleView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRedNavBg];
}

- (void)onrightButton:(id)sender
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self, ACTION_Controller_Name, nil];
    [self RouteMessage:ACTION_SHOW_BANGBANG_FOLLOWTOPIC withContext:dic];
}

/**
 *  初始化头部切换标签
 */
- (void)initializeNavTitleView
{
    _seg = [[UISegmentedControl alloc]
        initWithItems:@[ @"我的帮帮", @"我的话题" ]];
    _seg.segmentedControlStyle = UISegmentedControlStyleBar;
    _seg.tintColor = [UIColor whiteColor];
    _seg.frame = CGRectMake((SCREEN_WIDTH - SegWidth) / 2, 6, SegWidth, seghight);
    [_seg addTarget:self
                  action:@selector(onSegmentedControlClick:)
        forControlEvents:UIControlEventValueChanged];
    _seg.selectedSegmentIndex = 0; //选中的分段的索引
    self.navigationItem.titleView = _seg;

    rightButton =
        [[UIBarButtonItem alloc] initWithTitle:@"关注"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(onrightButton:)];
}

- (void)onSegmentedControlClick:(UISegmentedControl*)sender
{
    [self changePageAction:sender.selectedSegmentIndex];
    [self changeState:sender.selectedSegmentIndex];
}

/**
 *  更改右上角按钮状态
 *
 *  @param index <#index description#>
 */
- (void)changeState:(NSInteger)index
{
    _seg.selectedSegmentIndex = index;
    switch (index) {
    case 0:
        self.navigationItem.rightBarButtonItem = nil;
         
        break;
    case 1:
        self.navigationItem.rightBarButtonItem = rightButton;
            
        break;

    default:
        break;
    }
}

/**
 *  页面初始化
 *
 *  @return <#return value description#>
 */
- (id)init
{
    NSMutableArray* controllerArray = [[NSMutableArray alloc] init];
    MyhelpViewController* myHelp = [[MyhelpViewController alloc] init];
    myHelp.messageListner = self;
    [controllerArray addObject:myHelp];

    MyTopicViewController* myTopic = [[MyTopicViewController alloc] init];
    myTopic.messageListner = self;
    [controllerArray addObject:myTopic];

    self =
        [self initWithItems:nil
             andControllers:controllerArray
                withHideBar:YES];

    if (self) {
    }
    return self;
}

#pragma mark
#pragma mark-- scroll delegate
- (void)scrollOffsetChanged:(CGPoint)offset
{
    [super scrollOffsetChanged:offset];
    int lpage = (int)offset.y / SCREEN_WIDTH;
    [self changeState:lpage];
}

#pragma mark -
#pragma mark TitleViewDelegate
- (void)changePageAction:(NSUInteger)aPage
{
    [self selectedChangedIndex:aPage];
}

@end
