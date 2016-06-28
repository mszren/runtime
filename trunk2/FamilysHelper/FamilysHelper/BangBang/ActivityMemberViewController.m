//
//  ActivityMemberViewController.m
//  FamilysHelper
//
//  Created by 我 on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityMemberViewController.h"
#import "EGOTableView.h"
#import "ActivityListModel.h"
#import "TribeService.h"
#import "ActivityMemberCell.h"

@interface ActivityMemberViewController () <EGOTableViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end
@implementation ActivityMemberViewController {
    EGOTableView* _tableView;
    DataModel* _dataModel;
    ActivityListModel* _activityModel;
    ASIHTTPRequest* _request;
    NSString* _cacheKey;
    MBProgressHUD* _hud;
    BOOL _isRefresh;
}

@synthesize messageListner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"活动成员"];
    [self inintView];
    _cacheKey = [NSString stringWithFormat:@"%@_%ld", CACHE_BANG_MEMBERLIST, _activityID];
    _dataModel = [AppCache loadCache:_cacheKey];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

#pragma mark
#pragma mark-- InitView
- (void)inintView
{

    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];

    _tableView.backgroundColor = [UIColor whiteColor];

    _tableView.backgroundView = nil;

    _tableView.dataSource = self;

    _tableView.delegate = self;
    _tableView.headerOnly = YES;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.pullingDelegate = self;

    _tableView.autoScrollToNextPage = NO;

    [self.view addSubview:_tableView];
}

- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    _isRefresh = YES;
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{

    _isRefresh = NO;
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{

    return [NSDate date];
}

- (NSDate*)pullingTableViewLoadingFinishedDate
{

    return [NSDate date];
}

#pragma mark
#pragma mark-- loadData
- (void)loadData
{

    if (_request) {
        [_request cancel];
    }
    _request = [[TribeService shareInstance] getJoinMoreList:_activityID
                                                   OnSuccess:^(DataModel* dataModel) {
                                                       if (dataModel.code == 200) {

                                                           NSMutableArray* dataArry =
                                                               [[NSMutableArray alloc] initWithCapacity:0];
                                                           if (_dataModel && !_isRefresh) {
                                                               [dataArry addObjectsFromArray:_dataModel.data];
                                                           }
                                                           [dataArry addObjectsFromArray:dataModel.data];
                                                           dataModel.data = dataArry;
                                                           _dataModel = dataModel;
                                                           [AppCache saveCache:_cacheKey Data:_dataModel];
                                                           [_tableView reloadData];
                                                       }
                                                       else {
                                                           [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                       }
                                                       _hud.hidden = YES;

                                                       [_tableView tableViewDidFinishedLoading];

                                                   }];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 53;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return ((NSArray*)_dataModel.data).count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* identifier = @"ActivityMemberCell";
    ActivityMemberCell* activityMemberCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!activityMemberCell) {
        activityMemberCell = [[ActivityMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        activityMemberCell.selectionStyle = UITableViewCellSelectionStyleNone;
        activityMemberCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }

    ActivityListModel* activityListModel = _dataModel.data[indexPath.row];
    [activityMemberCell bindModel:activityListModel];

    return activityMemberCell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ActivityListModel* activityListModel = _dataModel.data[indexPath.row];
//    [self RouteMessage:ACTION_SHOW_PERSON_USERINFO withContext:@{ ACTION_Controller_Name : self, ACTION_Controller_Data : activityListModel.nickname }];
//}

#pragma mark -

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{

    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{

    [_tableView tableViewDidEndDragging:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
