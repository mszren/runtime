//
//  AddFriendsByAdrressBookController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AddFriendsByAdrressBookController.h"
#import "HomeService.h"
#import "EGOTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UserInfoViewController.h"
#import "AddFriendsCell.h"

@interface AddFriendsByAdrressBookController()<EGOTableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITableViewDataSource,UITableViewDelegate>

@end

@implementation AddFriendsByAdrressBookController{
    
    EGOTableView* _tableView;
    DataModel* _dataModel;
    ASIHTTPRequest* _request;
    ASIHTTPRequest* _checkRequest;
    MBProgressHUD* _hud;
    BOOL _isRefresh;
    User *_checkUser;
    NSMutableIndexSet  * _indexSet;//获取的非好友下表集合
    NSMutableArray * _checkResults;//非好友数组
}

@synthesize messageListner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"非好友联系人"];
    [self inintView];
    [self loadData];
    
}

#pragma mark
#pragma mark-- InitView
- (void)inintView
{
 
    _checkResults = [[NSMutableArray alloc]initWithCapacity:0];
    _indexSet = [[NSMutableIndexSet alloc]init];
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.backgroundView = nil;
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    _tableView.headerOnly = YES;
    
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    
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
 
    
    _request = [[HomeService shareInstance] Addfriends:[CurrentAccount currentAccount].uid  nextCursor:_dataModel.nextCursor onSuccess:
                ^(DataModel *dataModel) {
                    
            if (dataModel.code == 200) {
                
                if (_dataModel && !_isRefresh) {
                    [_dataModel.data addObjectsFromArray:dataModel.data];
                    _dataModel.code =  dataModel.code;
                    _dataModel.nextCursor = dataModel.nextCursor;
                    _dataModel.previousCursor = dataModel.previousCursor;
                    _dataModel.error = dataModel.error;
                }
                else
                    _dataModel = dataModel;
                
                [self appendString];
                
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
        }
                    
        _hud.hidden = YES;
        
        [_tableView tableViewDidFinishedLoading];
        
    }];
}

//拼接非好友号码
-(void)appendString{
    
    NSMutableString *phone = [[NSMutableString alloc]initWithCapacity:0];
    for (NSInteger i = 0; i < ((NSArray *)_dataModel.data).count; i++) {
        
        User *userModel = ((NSArray *)_dataModel.data)[i];
        if (i < ((NSArray *)_dataModel.data).count - 1) {
            
            [phone appendString:[NSString stringWithFormat:@"%@,",userModel.username]];
        }
        else
            [phone appendString:[NSString stringWithFormat:@"%@",userModel.username]];
    }
    
    [self checkNewData:phone];
}

//通讯录检测
-(void)checkNewData:(NSString *)nums{
    
    if (_checkRequest) {
        
        [_checkRequest cancel];
    }
    
    _checkRequest = [[HomeService shareInstance] contactsCheckNew:[CurrentAccount currentAccount].uid num:nums onSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            
            _checkUser = dataModel.data;
            NSArray * checkArry  = [_checkUser.norel componentsSeparatedByString:@","];
            [self initCheckData:checkArry];
        }
        else
        
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
    }];
}

//筛选数据
-(void)initCheckData:(NSArray *)checkArry{
    
    for (NSInteger i = 0; i < checkArry.count; i++) {
        
        for (User *userModel in _dataModel.data) {
            
            NSRange range = [userModel.username rangeOfString:checkArry[i]];
            if (range.location != NSNotFound) {
                
                [_indexSet addIndex:i];
            }
            
        }
        
    }
    
    [_checkResults removeAllObjects];
    
    [_checkResults addObject:[_dataModel.data objectsAtIndexes:_indexSet]];
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 53;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _checkResults.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString* identifier = @"ActivityMemberCell";
    AddFriendsCell* activityMemberCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!activityMemberCell) {
        activityMemberCell = [[AddFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        activityMemberCell.selectionStyle = UITableViewCellSelectionStyleNone;
        activityMemberCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }
    
    User *userModel = _checkResults[indexPath.row];
    [activityMemberCell bindModel:userModel];
    
    return activityMemberCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    User *userModel = _checkResults[indexPath.row];
    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
    userInfoVc.phone = userModel.username;
    userInfoVc.userId = userModel.uid;
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


#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无联系人哦!";
    [_tableView hideFooterViewAndHeadViewState];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_b9};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

@end
