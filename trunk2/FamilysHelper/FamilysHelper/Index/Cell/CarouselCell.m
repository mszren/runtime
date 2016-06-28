//
//  carouselView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "carouselCell.h"
#import <CoreText/CoreText.h>
#import "UIImageView+AFNetworking.h"
#import "ModuleModel.h"
#import "IndexModel.h"
#import "WebViewController.h"
#import "BangBangActivityViewController.h"

@implementation CarouselCell {
    UIScrollView* _carouselScrollView;
    UIPageControl* _pageControl;
    UILabel* _carouselLabel;
    NSArray* _carouselArry;
    UIView* _carouselView;
    EGOImageView* _carouseImage1;
    EGOImageView* _carouseImage2;
    EGOImageView* _carouseImage3;
}
@synthesize messageListner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //添加定时器
        [NSTimer scheduledTimerWithTimeInterval:3
                                         target:self
                                       selector:@selector(runTimePage)
                                       userInfo:nil
                                        repeats:YES];

        //滚动视图
        _carouselView =
            [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124 * (SCREEN_WIDTH / 320) + 35)];
        _carouselView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_carouselView];

        _carouselScrollView = [[UIScrollView alloc]
            initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 124 * (SCREEN_WIDTH / 320))];

        _carouselScrollView.showsVerticalScrollIndicator = NO;
        _carouselScrollView.showsHorizontalScrollIndicator = NO;
        _carouselScrollView.delegate = self;
        _carouselScrollView.pagingEnabled = YES;
        _carouselScrollView.bounces = NO;
        _carouselScrollView.userInteractionEnabled = YES;
        [_carouselView addSubview:_carouselScrollView];

        UITapGestureRecognizer* tapImage = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(onTapCarouseImage:)];

        _carouseImage1 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_320x215"]];
        _carouseImage1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 124 * (SCREEN_WIDTH / 320));
        _carouseImage1.tag = 100;
        _carouseImage1.userInteractionEnabled = YES;
        [_carouseImage1 addGestureRecognizer:tapImage];
        [_carouselScrollView addSubview:_carouseImage1];

        _carouseImage2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_320x215"]];
        _carouseImage2.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 124 * (SCREEN_WIDTH / 320));
        _carouseImage2.tag = 101;
        _carouseImage2.userInteractionEnabled = YES;
        tapImage = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(onTapCarouseImage:)];
        [_carouseImage2 addGestureRecognizer:tapImage];
        [_carouselScrollView addSubview:_carouseImage2];

        _carouseImage3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_320x215"]];
        _carouseImage3.frame = CGRectMake(2 * SCREEN_WIDTH, 0, SCREEN_WIDTH, 124 * (SCREEN_WIDTH / 320));
        _carouseImage3.tag = 102;
        _carouseImage3.userInteractionEnabled = YES;
        tapImage = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(onTapCarouseImage:)];
        [_carouseImage3 addGestureRecognizer:tapImage];
        [_carouselScrollView addSubview:_carouseImage3];

        _carouselScrollView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, 0);
        _carouselScrollView.contentOffset = CGPointMake(0, 0);

        //图片主题
        _carouselLabel = [[UILabel alloc]
            initWithFrame:CGRectMake(10, 124 * (SCREEN_WIDTH / 320) + 10, SCREEN_WIDTH - 50, 15 * (SCREEN_WIDTH / 320))];
        _carouselLabel.textColor = COLOR_GRAY_DEFAULT_30;
        _carouselLabel.font = [UIFont systemFontOfSize:12];
        [_carouselView addSubview:_carouselLabel];

        //创建pageControl
        _pageControl = [[UIPageControl alloc]
            initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 124 * (SCREEN_WIDTH / 320) + 10, 40, 20)];

        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = COLOR_GRAY_DEFAULT;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [_carouselView addSubview:_pageControl];
    }
    return self;
}

- (void)bindMoudle:(DataModel*)model
{
    if (!model || !model.data) {
        return;
    }
    _carouselArry = ((IndexModel*)model.data).carouselDiagramList;

    if ([_carouselArry count] > 0) {
        [_carouseImage1 setImageURL:[AppImageUtil getImageURL:((ModuleModel*)_carouselArry[0]).imgUrl Size:_carouseImage1.frame.size]];
    }

    if ([_carouselArry count] > 1) {
        [_carouseImage2 setImageURL:[AppImageUtil getImageURL:((ModuleModel*)_carouselArry[1]).imgUrl Size:_carouseImage1.frame.size]];
    }

    if ([_carouselArry count] > 2) {
        [_carouseImage3 setImageURL:[AppImageUtil getImageURL:((ModuleModel*)_carouselArry[2]).imgUrl Size:_carouseImage1.frame.size]];
    }
    _pageControl.numberOfPages = _carouselArry.count;
    ModuleModel* module = _carouselArry[0];
    _carouselLabel.text = module.title;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{

    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;

    [scrollView
        setContentOffset:CGPointMake(scrollView.bounds.size.width * page, 0)
                animated:NO];

    _pageControl.currentPage = page;
    ModuleModel* module = _carouselArry[page];
    _carouselLabel.text = module.title;
}

//定时器绑定方法
- (void)runTimePage
{

    NSInteger page = (_pageControl.currentPage + 1) % 3; // 获取当前的page
    _pageControl.currentPage = page;
    [_carouselScrollView
        setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width * page,
                             0)
                animated:NO];

    ModuleModel* module = _carouselArry[page];
    _carouselLabel.text = module.title;
}

//滚动视图图片点击手势
- (void)onTapCarouseImage:(UITapGestureRecognizer*)sender
{

    ModuleModel* moduleModel = _carouselArry[sender.view.tag - 100];

    NSInteger type = moduleModel.type;

    //判断属于哪个活动板块
    if (type == 1) {
        NSString* webURL =
            [NSString stringWithFormat:@"%@/ibsApp/page/activity/hdinfo.html?act_id=%ld&object_type=0&userId=%ld",
                      JAVA_API, (long)moduleModel.objectId,(long)[CurrentAccount currentAccount].uid];
        NSString* title = @"活动详情";
        NSString* flag = @"huodong";
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:
                messageListner, ACTION_Controller_Name,
            webURL,
            ACTION_Web_URL,
            title,
            ACTION_Web_Title, flag,ACTION_Web_flag,nil];
        [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
    }
    else if (type == 2) {
        NSString* webURL =
            [NSString stringWithFormat:@"%@/ibsApp/page/fenxiang/fxz_wzxq.html?share_id=%ld&userId=%ld",
                      JAVA_API, (long)moduleModel.objectId,(long)[CurrentAccount currentAccount].uid];
        NSString* title = @"文章详情";
        NSString* flag = @"fenxiang";
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:
                messageListner, ACTION_Controller_Name,
            webURL,
            ACTION_Web_URL,
            title,
            ACTION_Web_Title, flag,ACTION_Web_flag,nil];
        [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
    }
    else if (type == 3) {
        NSString* webURL =
            [NSString stringWithFormat:@"%@/ibsApp/page/tjz/tjzinfo.html?projectId=%ld&userId=%ld",
                      JAVA_API, (long)moduleModel.objectId,(long)[CurrentAccount currentAccount].uid];
        NSString* title = @"推荐赚详情";
        NSString* flag = @"tuijian";
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:
                messageListner, ACTION_Controller_Name,
            webURL,
            ACTION_Web_URL,
            title,
            ACTION_Web_Title, flag,ACTION_Web_flag,nil];
        [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
    }
    else {
        [messageListner RouteMessage:ACTION_SHOW_BANGBANG_ACTIVITYDETAIL
               withContext:@{ ACTION_Controller_Name : messageListner,
                   ACTION_Controller_Data : [NSString stringWithFormat:@"%ld", (long)moduleModel.objectId] }];
    }
}

@end
