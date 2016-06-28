//
//  CommunityController.m
//  FamilysHelper
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CommunityController.h"
#import "EGOTableView.h"
#import "HomeService.h"
#import "MsgListModel.h"
#import "MsgModel.h"
#import "MsgCell.h"
#import "StatisticsView.h"
#import "HomeInfoController.h"

@interface CommunityController () <EGOTableViewDelegate, UITableViewDataSource, UITableViewDelegate> {

    StatisticsView* _statisticsView;
}
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) DataModel* dataModel;
@property (nonatomic, assign) NSInteger msg_type;
@end

@implementation CommunityController {
    ASIHTTPRequest* _request;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _msg_type = 1; //小区
    _refreshing = NO;
    [self initView];
    _dataModel = [AppCache loadCache:CACHE_MYHOME_COMMUNITY];
    if (_dataModel) {
        MsgListModel* msgListModel = _dataModel.data;
        [_statisticsView setName:msgListModel.name count:msgListModel.count];
    }
    else
        [_tableView launchRefreshing];
}

- (void)initView
{
    _statisticsView = [[StatisticsView alloc] init];
    [self.view addSubview:_statisticsView];

    [_statisticsView.btnSetting addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 37, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 57 - TabBarHeight)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
    _refreshing = YES;
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _refreshing = NO;
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
    _request = [[HomeService shareInstance] getNeighbourCircleInfoNew:[CurrentAccount currentAccount].uid
                                                           nextCursor:_dataModel.nextCursor
                                                            onSuccess:^(DataModel* dataModel) {
                                                                if (dataModel.code == 200) {
                                                                    if (_dataModel && !_refreshing) {
                                                                        MsgListModel* msgOldListModel = _dataModel.data;
                                                                        MsgListModel* msgNewListModel = dataModel.data;

                                                                        [msgOldListModel.lcdList addObjectsFromArray:msgNewListModel.lcdList];
                                                                        msgOldListModel.count = msgNewListModel.count;
                                                                        msgOldListModel.name = msgNewListModel.name;
                                                                        _dataModel.data = msgOldListModel;
                                                                        _dataModel.previousCursor = dataModel.previousCursor;
                                                                        _dataModel.nextCursor = dataModel.nextCursor;
                                                                    }
                                                                    else
                                                                        _dataModel = dataModel;

                                                                    [AppCache saveCache:CACHE_MYHOME_COMMUNITY Data:dataModel];
                                                                    MsgListModel* msgListModel = _dataModel.data;
                                                                    [_statisticsView setName:msgListModel.name count:msgListModel.count];

                                                                    if (_dataModel.previousCursor == _dataModel.nextCursor) {
                                                                        _tableView.reachedTheEnd = YES;
                                                                    }
                                                                    else {
                                                                        _tableView.reachedTheEnd = NO;
                                                                    }
                                                                    [_tableView reloadData];
                                                                }
                                                                else {
                                                                    [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                                    _tableView.reachedTheEnd = NO;
                                                                }
                                                                [_tableView tableViewDidFinishedLoading];
                                                            }];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((MsgListModel*)_dataModel.data).lcdList.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* identifier = @"CommunityCellIdentifier";
    MsgCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageListner = self;
        NSInteger from_type = 1;
        [cell initView:from_type];
    }
    MsgListModel* list = _dataModel.data;
    if (list.lcdList.count > indexPath.row) {
        MsgModel* model = [list.lcdList objectAtIndex:indexPath.row];
        model.type = _msg_type;
        [cell bindMsgModel:model type:_msg_type];
    }
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MsgListModel* list = _dataModel.data;
    if (list.lcdList.count > indexPath.row) {
        NSDictionary* dic = @{ ACTION_Controller_Name : self, ACTION_Controller_Data : [list.lcdList objectAtIndex:indexPath.row] };
        [self RouteMessage:ACTION_SHOW_HOME_MSGDETAIL withContext:dic];
    }
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
- (void)settingAction:(id)sender
{
    NSString* title = @"设置小区";
    NSString* flag = @"home";
    NSString* url = [NSString stringWithFormat:@"%@/ibsApp/page/lifeCircle/llzx_gl.html?userId=%ld", JAVA_API, (long)[CurrentAccount currentAccount].uid];
    NSDictionary* dic = @{ ACTION_Controller_Name : self,
        ACTION_Web_URL : url,
        ACTION_Web_Title : title,
        ACTION_Web_flag : flag };
    [self RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
}

#pragma mark RouteMessage Delegate
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    if ([message isEqualToString:NOTIFICATION_HOME_PUBLISH]) {
        NSDictionary* dic = context;
        MsgModel* msgModel = [dic objectForKey:NOTIFICATION_DATA];
        if (msgModel) {
            MsgListModel* msgList = _dataModel.data;
            [msgList.lcdList insertObject:msgModel atIndex:0];
            _dataModel.data = msgList;
            [_tableView reloadData];
        }
    }
    else {
        [self.messageListner RouteMessage:message withContext:context];
    }
}
@end
