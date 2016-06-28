//
//  GuGuSegmentNaviViewController.m
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import "SegmentNaviViewController.h"
#import "SegmentBarView.h"
#import "LandscapeTableView.h"

#define kBarHeight 27
@interface SegmentNaviViewController ()
{
    int currentIndex;
    NSArray *_titleArray;
    LandscapeTableView *contentTable;
    SegmentBarView *barView ;
}
@end

@implementation SegmentNaviViewController

-(id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers
{
    self = [super init];
    if (self)
    {
        NSString * tmpVersonType = [UIDevice currentDevice].systemVersion;
        
        NSArray * tmpArr = [tmpVersonType componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
        int y = 0;
        if([[tmpArr objectAtIndex:0] isEqualToString:@"7"])
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
            y = 64;
        }
        
        barView = [[SegmentBarView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, kBarHeight) andItems:titleArray];
        
        barView.backgroundColor = RGBCOLOR(230, 230, 230);
        [self.view addSubview:barView];
        barView.clickDelegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
        contentTable = [[LandscapeTableView alloc]initWithFrame:CGRectMake(0,  kBarHeight + y, SCREEN_WIDTH, self.view.frame.size.height - kBarHeight - y) Array:controllers];
        contentTable.swipeDelegate = self;
        
        [self.view addSubview:contentTable];
        
        
        if (controllers.count > 0)
        {
            for (UIViewController *controller  in controllers)
            {
                [self addChildViewController:controller];
            }
            currentIndex = 0;
        }
        _titleArray = titleArray;
    }
    return self;
}

-(id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers withHideBar:(BOOL) isHide
{
    self = [super init];
    if (self)
    {
        NSString * tmpVersonType = [UIDevice currentDevice].systemVersion;
        
        NSArray * tmpArr = [tmpVersonType componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
        int y = 0;
        if([[tmpArr objectAtIndex:0] isEqualToString:@"7"])
        {
            y = 0;
        }
         self.automaticallyAdjustsScrollViewInsets = YES;
        if (isHide) {
            contentTable = [[LandscapeTableView alloc]initWithFrame:CGRectMake(0,  y, SCREEN_WIDTH, self.view.frame.size.height  - y) Array:controllers];
            contentTable.swipeDelegate = self;
            [self.view addSubview:contentTable];
        }else{
            barView = [[SegmentBarView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, kBarHeight) andItems:titleArray];
            barView.backgroundColor = RGBCOLOR(230, 230, 230);
            barView.clickDelegate = self;
            [self.view addSubview:barView];
            
            contentTable = [[LandscapeTableView alloc]initWithFrame:CGRectMake(0,  kBarHeight + y, SCREEN_WIDTH, self.view.frame.size.height - kBarHeight - y) Array:controllers];
            contentTable.swipeDelegate = self;
            [self.view addSubview:contentTable];
        }

        if (controllers.count > 0)
        {
            for (UIViewController *controller  in controllers)
            {
                [self addChildViewController:controller];
            }
            currentIndex = 0;
        }
        _titleArray = titleArray;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [_titleArray objectAtIndex:0];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideBarView{
    [barView removeFromSuperview];
    contentTable.frame = CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)barSelectedIndexChanged:(int)newIndex
{
    if (newIndex >= 0)
    {
        currentIndex = newIndex;
        self.title = [_titleArray objectAtIndex:newIndex];
        [contentTable selectIndex:newIndex];
    }
}

- (void)selectedChangedIndex:(int)newIndex{
    if (newIndex >= 0)
    {
        currentIndex = newIndex;
        self.title = [_titleArray objectAtIndex:newIndex];
        [contentTable selectIndex:newIndex withAnimated:YES];
    }
}

-(void)contentSelectedIndexChanged:(int)newIndex
{
    [barView selectIndex:newIndex];
}

-(void)scrollOffsetChanged:(CGPoint)offset
{
    int page = (int)offset.y / SCREEN_WIDTH;
    float radio = (float)((int)offset.y % (int)SCREEN_WIDTH)/SCREEN_WIDTH;
    [barView setLineOffsetWithPage:page andRatio:radio];
}





@end
