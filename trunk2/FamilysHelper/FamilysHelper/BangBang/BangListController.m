//
//  MyTopicViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangListController.h"
#import "EGOTableView.h"
#import "TribeService.h"
#import "TribeModel.h"
#import "BangListCell.h"
#import "BangIndexController.h"

@interface BangListController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating,EGOTableViewDelegate> {
    DataModel* _dataModel;
}
@end

@implementation BangListController {

    EGOTableView* _tableView;
    NSMutableArray* _dataSource; //请求数据
    NSMutableArray* _searchResults; //搜索结果
    UISearchController* _searchController;
    BOOL _isRefresh;
    ASIHTTPRequest *_request;
    MBProgressHUD *_hud;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    
    _dataModel = [AppCache loadCache:CACHE_BANG_BANGLIST];
    if (!_dataModel) {
        
        [_tableView launchRefreshing];
    }
    
}

- (void)loadData
{
    if (_request) {
        [_request cancel];
    }
    _request = [[TribeService shareInstance] getMoreTribeBy:_searchController.searchBar.text
                                          userID:[CurrentAccount currentAccount].uid
                                       nexCurror:_dataModel.nextCursor
                                       OnSuccess:^(DataModel* dataModel) {
                                           if (dataModel.code == 200) {
                                               if (_dataModel && _isRefresh) {
                                                   [(NSMutableArray*)_dataModel.data addObjectsFromArray:dataModel.data];
                                                   _dataModel.code = dataModel.code;
                                                   _dataModel.error = dataModel.error;
                                                   _dataModel.nextCursor = dataModel.nextCursor;
                                                   _dataModel.previousCursor = dataModel.previousCursor;
                                               }
                                               else
                                                   _dataModel = dataModel;
                                               [AppCache saveCache:CACHE_BANG_BANGLIST Data:_dataModel];
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
                                           _hud.hidden = YES;
                                           [_tableView tableViewDidFinishedLoading];
                                       }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchController.searchBar resignFirstResponder];
}

- (void)initView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];

    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight);

    _searchController.searchBar.barTintColor = TableSeparatorColor;
    _searchController.searchBar.placeholder = @"搜索要关注的帮";
    _searchController.searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;

    _tableView.tableHeaderView = _searchController.searchBar; //把搜索框放在表头
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* listModel = _dataModel.data;
    return listModel.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* myTopicIdentifier = @"BangListIdentifier";
    BangListCell* cell = [tableView dequeueReusableCellWithIdentifier:myTopicIdentifier];
    if (!cell) {
        cell = [[BangListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myTopicIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray* listModel = _dataModel.data;
    [cell bindTribel:listModel[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 75;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSArray* listModel = _dataModel.data;
    TribeModel* model = (TribeModel*)listModel[indexPath.row];
    NSDictionary* dic = @{ ACTION_Controller_Name : self,
        ACTION_Controller_Data :  @{BANGBANG_INDEX_TRIBEID:@(model.shopId),BANGBANG_INDEX_SELECTINDEX:@(SELECTTOPIC)} };
    [self RouteMessage:ACTION_SHOW_BANGBANG_BANGINDEX withContext:dic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark EGOTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
         ;
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

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [_tableView tableViewDidScroll:scrollView];
    [_searchController.searchBar resignFirstResponder];
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView tableViewDidEndDragging:scrollView];
    [_searchController.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController*)searchController
{
    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
        [_dataModel.data removeAllObjects];
    }
    [self loadData];
}

@end
