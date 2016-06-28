//
//  GroupMemberController.m
//  FamilysHelper
//
//  Created by 我 on 15/8/21.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GroupMemberController.h"
#import "HomeService.h"
#import "EGOTableView.h"
#import "GroupMemberCell.h"
#import "GrounpInfoModel.h"
#import "UserInfoViewController.h"

@interface GroupMemberController ()<EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation GroupMemberController{

EGOTableView* _tableView;
DataModel* _dataModel;
ASIHTTPRequest* _request;
MBProgressHUD* _hud;
BOOL _isRefresh;
}

@synthesize messageListner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"群成员"];
    [self inintView];
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%@",CACHE_MYHOME_GROUPMEMBER,_name]];
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
    
    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
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
    _request = [[HomeService shareInstance] getNewGroupMemberList:_name nextCursor:_dataModel.nextCursor onSuccess:                  ^(DataModel *dataModel) {
                                                       if (dataModel.code == 200) {
                                                           
                                                           if (_dataModel && !_isRefresh) {
                                                               [((GrounpInfoModel *)_dataModel.data).mucMembers addObjectsFromArray:((GrounpInfoModel *)dataModel.data).mucMembers];
                                                               _dataModel.code = dataModel.code;
                                                               _dataModel.nextCursor = dataModel.nextCursor;
                                                               _dataModel.previousCursor = dataModel.previousCursor;
                                                               _dataModel.error = dataModel.error;
                                                           }
                                                           else
                                                               _dataModel = dataModel;
                                                           [AppCache saveCache:[NSString stringWithFormat:@"%@_%@",CACHE_MYHOME_GROUPMEMBER,_name] Data:_dataModel];
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
    
    return ((GrounpInfoModel *)_dataModel.data).mucMembers.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString* identifier = @"ActivityMemberCell";
    GroupMemberCell* activityMemberCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!activityMemberCell) {
        activityMemberCell = [[GroupMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        activityMemberCell.selectionStyle = UITableViewCellSelectionStyleNone;
        activityMemberCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }
    
    GrounpInfoModel*  Model = ((GrounpInfoModel *)_dataModel.data).mucMembers[indexPath.row];
    [activityMemberCell bindModel:Model];
    
    return activityMemberCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrounpInfoModel*  model = ((GrounpInfoModel *)_dataModel.data).mucMembers[indexPath.row];
    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
    userInfoVc.phone = model.username;
    userInfoVc.userId = model.user_id;
    userInfoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVc animated:YES];
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
