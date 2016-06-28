//
//  ActivityQianDaoViewController.m
//  FamilysHelper
//
//  Created by 我 on 15/7/31.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityQianDaoViewController.h"
#import "IndexService.h"
#import "DataModel.h"
#import "QDCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface ActivityQianDaoViewController ()<UITableViewDataSource,UITableViewDelegate,EGOTableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation ActivityQianDaoViewController{
    DataModel *_dataModel;
    ASIHTTPRequest *_request;
    BOOL _isRefresh;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeWhiteBackgroudView:@"签到记录"];
    _isRefresh = NO;
    [self initView];
    [self lodeData];
    _dataModel = [AppCache loadCache:CACHE_INDEX_ACTIVITYQIANDAO];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

-(void)initView{
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
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)lodeData
{
    if (_request) {
        [_request cancel];
    }
    _request = [[IndexService shareInstance] getActivitySignInfo:[CurrentAccount currentAccount].uid activityId:_activityID nextCursor:_dataModel.nextCursor onSuccess:^(DataModel *dataModel) {
        
                                         if (dataModel.code == 200) {
                                             
                                             if (_dataModel && !_isRefresh) {
                                                 [(NSMutableArray*)_dataModel.data addObjectsFromArray:dataModel.data];
                                                 _dataModel.code = dataModel.code;
                                                 _dataModel.error = dataModel.error;
                                                 _dataModel.nextCursor = dataModel.nextCursor;
                                                 _dataModel.previousCursor = dataModel.previousCursor;
                                             }
                                             else
                                                 _dataModel = dataModel;
                                             [AppCache saveCache:CACHE_INDEX_ACTIVITYQIANDAO Data:_dataModel];
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


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray* listModel = _dataModel.data;
    
    return listModel.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 45;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
 
    static NSString* identifier = @"QDidentifier";
    QDCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QDCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray* listModel = _dataModel.data;
    if (listModel.count > indexPath.row) {
        QDModel* model = [listModel objectAtIndex:indexPath.row];
        [cell bindUserModel:model];
    }
    
    return cell;
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
    [self lodeData];
    
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _isRefresh = NO;
    [self lodeData];
 
}
- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
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
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
     
    return [UIImage imageNamed:@"ic_wpl@2x"];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"没有签到记录哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_7a};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
