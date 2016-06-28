//
//  RecommendViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RecommendViewController.h"
#import "EGOTableView.h"
#import "DataModel.h"
#import "IndexService.h"
#import "RecomCell.h"
#import "RecommendModel.h"

@interface RecommendViewController () <UITableViewDataSource, UITableViewDelegate, EGOTableViewDelegate> {
    BOOL _iRefresh;
}
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) DataModel* dataModel;
@property (nonatomic,strong)ASIHTTPRequest *request;

@end

@implementation RecommendViewController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    _iRefresh = NO;
    _dataModel = [AppCache loadCache:CACHE_INDEX_MORERECOMMEND];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"规则" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnDetail:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initializeNavTitleView:@"推荐赚"];

    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];

    _tableView.backgroundColor = [UIColor whiteColor];

    _tableView.backgroundView = nil;

    _tableView.dataSource = self;

    _tableView.delegate = self;

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
    _iRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _iRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
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
    _request = [[IndexService shareInstance] getRecommendListV6:[CurrentAccount currentAccount].uid
                                                 mid:_dataModel.nextCursor
                                           onSuccess:^(DataModel* dataModel) {
                                               if (dataModel.code == 200) {
                                                   
                                                   if (_dataModel && !_iRefresh) {
                                                       [_dataModel.data addObjectsFromArray:dataModel.data];
                                                       _dataModel.previousCursor = dataModel.previousCursor;
                                                       _dataModel.nextCursor = dataModel.nextCursor;
                                                   }
                                                   else
                                                       _dataModel = dataModel;
                                                   [AppCache saveCache:CACHE_INDEX_MORERECOMMEND Data:_dataModel];
                                                   [_tableView reloadData];
                                                   [_tableView tableViewDidFinishedLoading];
                                               }
                                               if (dataModel.code == 20001) {
                                                   [_tableView setReachedTheEnd:YES];
                                               }

                                           }];
}

#pragma mark
#pragma mark - UITabelViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 100;
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

    static NSString* identifier = @"RecommendCell";
    RecomCell* recommendCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!recommendCell) {
        recommendCell = [[RecomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        recommendCell.selectionStyle = UITableViewCellSelectionStyleNone;
        recommendCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }

    RecommendModel* recommendModel = _dataModel.data[indexPath.row];
    [recommendCell bindModel:recommendModel];

    return recommendCell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    RecommendModel* recommendModel = _dataModel.data[indexPath.row];

    NSString* webURL = [NSString stringWithFormat:@"%@/ibsApp/page/tjz/tjzinfo.html?projectId=%@&userId=%ld", JAVA_API, recommendModel.projectId,(long)[CurrentAccount currentAccount].uid];
    NSString* title = @"推荐详情";
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

- (void)onBtnDetail:(UIButton*)sender
{

    NSString* webURL = [NSString stringWithFormat:@"%@/ibsApp/page/tjz/tjz.html?userId=%ld", JAVA_API, (long)[CurrentAccount currentAccount].uid];
    NSString* title = @"推荐赚攻略";

    NSDictionary* dic = [NSDictionary
        dictionaryWithObjectsAndKeys:
            messageListner, ACTION_Controller_Name,
        webURL,
        ACTION_Web_URL,
        title,
        ACTION_Web_Title, nil];
    [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
}

- (void)onBtnBack:(UIButton*)sender
{

    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
