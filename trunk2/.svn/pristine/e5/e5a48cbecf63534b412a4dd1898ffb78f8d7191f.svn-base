//
//  AllChatController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AllChatController.h"
#import "PublishController.h"
#import "EGOTableView.h"
#import "HomeService.h"
#import "MsgModel.h"
#import "MsgCell.h"
#import "HomeInfoController.h"
#import "AppCache.h"
#import "AppCacheConfig.h"
@interface AllChatController () <EGOTableViewDelegate, UITableViewDataSource, UITableViewDelegate> {
}
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) DataModel* dataModel;
@property (nonatomic, assign) NSInteger msg_type;
@end

@implementation AllChatController{
    ASIHTTPRequest *_request;
    BOOL _isRefresh;
}
@synthesize messageListner;
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
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"大家聊"];
    [self initializeMyView];
    [self initView];
    _isRefresh = NO;
    _dataModel = [AppCache loadCache:CACHE_MYHOME_ALLCHAT];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

-(void)initView{
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight)];
    _msg_type = 4; //大家聊
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
}

- (void)initializeMyView
{
    [self.view setBackgroundColor:BGViewGray];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(onrightButton:)];
    [rightItem setTintColor:HomeNavBarBgColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)onrightButton:(id)sender
{
    PublishController* pubishController = [[PublishController alloc] init];
    pubishController.msg_Type = 4;
    pubishController.messageListner = self;
    [self.navigationController pushViewController:pubishController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadData:(BOOL)iRefresh
{
 
    if (_request) {
        [_request cancel];
    }
    _request = [[HomeService shareInstance] getNewTalkList:_dataModel.nextCursor
                                                 onSuccess:^(DataModel* dataModel) {
                                                     if (dataModel.code == 200) {
                                                         if (_dataModel && !_isRefresh) {
                                                             NSMutableArray* list = _dataModel.data;
                                                             [list addObjectsFromArray:dataModel.data];
                                                             _dataModel.data = list;
                                                             _dataModel.previousCursor = dataModel.previousCursor;
                                                             _dataModel.nextCursor = dataModel.nextCursor;
                                                         }
                                                         else
                                                             _dataModel = dataModel;
                                                         [AppCache saveCache:CACHE_MYHOME_ALLCHAT Data:_dataModel];
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
    return ((NSArray*)_dataModel.data).count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* identifier = @"CommunityCellIdentifier";
    MsgCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSInteger from_type = 1;
        cell.messageListner = self;
        [cell initView:from_type];
    }
    NSArray* list = _dataModel.data;
    if (list.count > indexPath.row) {
        MsgModel* model = [list objectAtIndex:indexPath.row];
        model.type = _msg_type;
        [cell bindMsgModel:model type:_msg_type];
    }
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSArray* list = _dataModel.data;
    if (list.count > indexPath.row) {

        NSDictionary* dic = @{ ACTION_Controller_Name : self, ACTION_Controller_Data : [list objectAtIndex:indexPath.row] };
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

#pragma mark -
#pragma mark EGOTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
    _isRefresh = YES;
    [self loadData:NO];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _isRefresh = NO;
    [self loadData:NO];
}
- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
}

#pragma mark RouteMessage Delegate
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    if ([message isEqualToString:NOTIFICATION_HOME_PUBLISH]) {
        NSDictionary* dic = context;
        MsgModel* msgModel = [dic objectForKey:NOTIFICATION_DATA];
        if (msgModel) {
            [_dataModel.data insertObject:msgModel atIndex:0];
            [_tableView reloadData];
        }
    }
    else {
        [self.messageListner RouteMessage:message withContext:context];
    }
}

@end
