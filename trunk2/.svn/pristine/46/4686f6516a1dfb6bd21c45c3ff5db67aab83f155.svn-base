//
//  DiscoverController.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/6.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsInfoViewController.h"
#import "CommentViewController.h"

@interface GoodsDetailViewController () <UIScrollViewDelegate> {
    UIBarButtonItem* rightButton;
    UISegmentedControl* _seg;
    GoodsInfoViewController* detailVC;
    CommentViewController* commentVC;
}

@end


@implementation GoodsDetailViewController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initializeNavTitleView];
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
- (id)initWithGoodsID:(NSInteger)goodsID shopName:(NSString*)shopName shopID:(NSInteger)shopId goodsName:(NSString*)goodsName
{
    NSMutableArray* controllerArray = [[NSMutableArray alloc] init];
    detailVC = [[GoodsInfoViewController alloc] init];
    detailVC.messageListner = self;
    detailVC.goodsId = goodsID;
    detailVC.shopName = shopName;
    detailVC.shopId = shopId;
    detailVC.goodsName = goodsName;
    [controllerArray addObject:detailVC];

    commentVC = [[CommentViewController alloc] init];
    commentVC.messageListner = self;
    commentVC.goodsId = goodsID;
    commentVC.shopId = shopId;
    commentVC.shopName = shopName;
    commentVC.goodsName = goodsName;
    [controllerArray addObject:commentVC];

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
