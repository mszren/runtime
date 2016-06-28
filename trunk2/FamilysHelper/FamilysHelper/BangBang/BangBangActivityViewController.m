//
//  BangBangActivityViewController.m
//  FamilysHelper
//
//  Created by 我 on 15/7/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangBangActivityViewController.h"
#import "ActivityCommentViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityReplyController.h"
#import "ActivityModel.h"

@interface BangBangActivityViewController () <UIScrollViewDelegate>

@end

@implementation BangBangActivityViewController {

    UIBarButtonItem* rightButton;
    UISegmentedControl* _seg;
    ActivityCommentViewController *_activityComment;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    rightButton =
        [[UIBarButtonItem alloc] initWithTitle:@"评价"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(onrightButton:)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initializeNavTitleView];
}

- (void)onrightButton:(id)sender
{

    switch (_seg.selectedSegmentIndex) {
 
        case 1: {
            NSDictionary* dic = @{ ACTION_Controller_Name : _activityComment,
                                   ACTION_Controller_Data : [NSString stringWithFormat:@"%ld", (long)_activityID] };
            [self RouteMessage:ACTION_SHOW_BANGBANG_ACTIVITYREPLY withContext:dic];
            break;
        }
 
        default:
            break;
    }
    
    
}

/**
 *  初始化头部切换标签
 */
- (void)initializeNavTitleView
{
    _seg = [[UISegmentedControl alloc] initWithItems:@[ @"详情", @"评论" ]];
    _seg.segmentedControlStyle = UISegmentedControlStyleBar;
    _seg.tintColor = [UIColor whiteColor];
    _seg.frame = CGRectMake((SCREEN_WIDTH - SegWidth) / 2, 6, SegWidth, seghight);
    [_seg addTarget:self
                  action:@selector(onSegmentedControlClick:)
        forControlEvents:UIControlEventValueChanged];
    _seg.selectedSegmentIndex = 0; //选中的分段的索引
    self.navigationItem.titleView = _seg;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:HomeNavBarBgColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:HomeNavBarTitleColor];
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
- (id)initWithActivityID:(NSInteger)activityID
{
    _activityID = activityID;
    NSMutableArray* controllerArray = [[NSMutableArray alloc] init];
    ActivityDetailViewController* detail =
        [[ActivityDetailViewController alloc] init];
    detail.messageListner = self;
    detail.activityId = activityID;
    [controllerArray addObject:detail];

    _activityComment =
        [[ActivityCommentViewController alloc] init];
    _activityComment.activityId = activityID;
    _activityComment.messageListner = self;
    [controllerArray addObject:_activityComment];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RouteMessage Delegate
IMPLEMENT_MESSAGE_ROUTABLE

@end
