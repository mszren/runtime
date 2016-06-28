//
//  ActivityViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityModel.h"
#import "EGOTableView.h"
#import "ActivityCell.h"
#import "IndexService.h"
#import "WebViewController.h"

@interface ActivityViewController () <UITableViewDataSource, UITableViewDelegate, EGOTableViewDelegate> {
    ASIHTTPRequest* _request;
    BOOL _iRefresh;
}
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, strong) DataModel* activityDataModel;
@end

@implementation ActivityViewController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    _iRefresh = NO;
    _activityDataModel = [AppCache loadCache:CACHE_INDEX_MOREIACTIVITY];
    if (!_activityDataModel) {
        [_tableView launchRefreshing];
    }
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"规则" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnDetail:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"活动赚";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.pullingDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoScrollToNextPage = NO;

    [self.view addSubview:_tableView];
}

- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    if (_activityDataModel) {

        _activityDataModel.nextCursor = 0;

        _activityDataModel.previousCursor = 0;
    }
    _iRefresh = YES;
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _iRefresh = NO;
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

- (void)loadData
{

    if (_request) {
        [_request cancel];
    }
    _request = [[IndexService shareInstance] getActivityListV6:23506
                                                           mid:_activityDataModel.nextCursor
                                                     onSuccess:^(DataModel* dataModel) {
                                                         if (dataModel.code == 200) {
                                                             
                                                             if (_activityDataModel && !_iRefresh) {
                                                                 [_activityDataModel.data addObjectsFromArray:dataModel.data];
                                                                 _activityDataModel.code = dataModel.code;
                                                                 _activityDataModel.nextCursor = dataModel.nextCursor;
                                                                 _activityDataModel.previousCursor = dataModel.previousCursor;
                                                                 _activityDataModel.error = dataModel.error;
                                                             }
                                                             else
                                                                 _activityDataModel = dataModel;
                                                             [AppCache saveCache:CACHE_INDEX_MOREIACTIVITY Data:_activityDataModel];
                                                             
                                                             
                                                             [_tableView reloadData];
                                                             [_tableView tableViewDidFinishedLoading];
                                                         }

                                                         if (dataModel.code == 20001) {
                                                             _tableView.reachedTheEnd = YES;
                                                         }

                                                     }];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return ((NSArray*)_activityDataModel.data).count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 335;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* activityCellid = @"activityCellid";
    ActivityCell* activityCell = [tableView dequeueReusableCellWithIdentifier:activityCellid];
    if (!activityCell) {
        activityCell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellid];
        activityCell.selectionStyle = UITableViewCellSelectionStyleNone;
        activityCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }
    [activityCell bindModel:(_activityDataModel.data)[indexPath.row]];

    return activityCell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    NSString* detailUrl = [NSString stringWithFormat:@"%@/ibsApp/page/activity/hdinfo.html?act_id=%ld&object_type=0&userId=%ld", JAVA_API, (long)((ActivityModel*)self.activityDataModel.data[indexPath.row]).activityId, (long)[CurrentAccount currentAccount].uid];

    NSString* titleName = @"活动详情";
    NSString* flag = @"QianDao";
    NSDictionary* dic = [NSDictionary
        dictionaryWithObjectsAndKeys:
            self, ACTION_Controller_Name,
        detailUrl,
        ACTION_Web_URL,
        titleName,
        ACTION_Web_Title,flag,ACTION_Web_flag,nil];
    [self RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
}

- (void)onBtnDetail:(UIButton*)sender
{
    NSString* titleName = @"活动赚攻略";
    NSString* detailUrl = [NSString stringWithFormat:@"%@/ibsApp/page/activity/hdz_gl.html?userId=%lu", JAVA_API, (unsigned long)[CurrentAccount currentAccount].uid];
    NSDictionary* dic = [NSDictionary
        dictionaryWithObjectsAndKeys:
            messageListner, ACTION_Controller_Name,
        detailUrl,
        ACTION_Web_URL,
        titleName,
        ACTION_Web_Title, nil];
    [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
}

- (void)onBtnBack:(UIButton*)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}

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
