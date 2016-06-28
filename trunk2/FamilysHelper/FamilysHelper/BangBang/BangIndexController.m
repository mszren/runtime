//
//  InteractionViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangIndexController.h"
#import "BangInfoView.h"
#import "SegmentBarView.h"
#import "InteractionCell.h"
#import "BangActivityCell.h"
#import "EGOTableView.h"
#import "TribeService.h"
#import "TribeGoodsCell.h"
#import "TopicDetailController.h"
#import "BangPublishController.h"
#import "BangDetailController.h"
#import "GoodsDetailViewController.h"
#import "TribeModel.h"
#import "GoodsModel.h"
#import "BangBangActivityViewController.h"
#import "ActivityModel.h"
#import "MemmberViewController.h"
#import "QianDaoViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BangIndexController () <UITableViewDataSource, UITableViewDelegate,
    EGOTableViewDelegate, SegmentBarViewDelegate,
    UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> {
    DataModel* _interactionModel;
    DataModel* _goodsModel;
    DataModel* _memberModel;
    DataModel* _dataModel;
    TribeModel* _tribeModel;
    ASIHTTPRequest* _request;
    ASIHTTPRequest* _tribeInforequest;
    BOOL _isRefresh;
}
@end

@implementation BangIndexController {
    EGOTableView* _tableView;
    BangInfoView* _bangInfo;
    SegmentBarView* _barView;
    UIButton* _btnPublish;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isRefresh = NO;
    [self setWhiteNavBg];
    [self initView];
    [self loadBangInfo];
    
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%ld_%ld",CACHE_BANG_BANGINDEX,(long)_tribeID,(long)_selectIndex]];
    if (!_dataModel) {
        
        [_tableView launchRefreshing];
    }
    if (_selectIndex != 0 ) {
        [_barView selectButton:_selectIndex];
    }
}

- (void)loadBangInfo
{
    NSString* _cacheKeyBangInfo = [NSString stringWithFormat:@"%@_%ld", CACHE_BANG_BANGINFO, (long)_tribeID];
    _tribeModel = [AppCache loadCache:_cacheKeyBangInfo];
    if (_tribeModel) {
        [_bangInfo bindTribe:_tribeModel];
    }
    else if (_tribeInforequest) {
        [_tribeInforequest cancel];
    }
    _tribeInforequest = [[TribeService shareInstance]
        getTribeInfoBy:_tribeID
                userID:[CurrentAccount currentAccount].uid
             OnSuccess:^(DataModel* dataModel) {
                 if (dataModel.code == 200) {
                     _tribeModel = dataModel.data;
                     [AppCache saveCache:_cacheKeyBangInfo Data:_tribeModel];
                     [_bangInfo bindTribe:_tribeModel];
                 }
             }];
}

- (void)setDataSource:(DataModel*)dataModel
{
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

        [AppCache saveCache:[NSString stringWithFormat:@"%@_%ld_%d",CACHE_BANG_BANGINDEX,(long)_tribeID,_barView.selectedIndex] Data:_dataModel];
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
}

- (void)loadData
{
    if (_request) {
        [_request cancel];
    }
    switch (_barView.selectedIndex) {
    case 0: {

        _request = [[TribeService shareInstance] getTribeInteBy:_tribeID
                                                         typeID:1
                                                      OnSuccess:^(DataModel* dataModel) {
                                                          _dataModel = _interactionModel;

                                                          [self setDataSource:dataModel];

                                                      }];
        break;
    }
    case 1: {
        _request = [[TribeService shareInstance] getTribeGoodsBy:_tribeID
                                                       nexCurror:_dataModel.nextCursor
                                                       OnSuccess:^(DataModel* dataModel) {
                                                           _dataModel = _goodsModel;
                                                           [self setDataSource:dataModel];
                                                       }];
        break;
    }
    case 2: {

        _request = [[TribeService shareInstance] getBangActivityList:_tribeID
                                                          nextCursor:_dataModel.nextCursor
                                                           OnSuccess:^(DataModel* dataModel) {
                                                               [self setDataSource:dataModel];
                                                           }];

        break;
    }
    default:
        break;
    }
}

- (void)initView
{

    UIBarButtonItem* rightItem =
        [[UIBarButtonItem alloc] initWithTitle:@"详情"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;

    _bangInfo = [[BangInfoView alloc] init];
    [_bangInfo.Attentionbut addTarget:self
                               action:@selector(memmeberAction:)
                     forControlEvents:UIControlEventTouchUpInside];
    [_bangInfo.btnqiandao addTarget:self
                             action:@selector(qiandaoAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    _barView = [[SegmentBarView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
             andItems:@[ @"互动", @"商品", @"活动" ]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[EGOTableView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,
                          SCREEN_HEIGHT - TopBarHeight - 20)
                style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;

    [_tableView setBackgroundColor:AllTableViewColor];

    _tableView.tableHeaderView = _bangInfo;
    [self.view addSubview:_tableView];

    _btnPublish = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnPublish setBackgroundImage:[UIImage imageNamed:@"btn_release"]
                           forState:UIControlStateNormal];
    _btnPublish.frame = CGRectMake(0, 0, 50, 50);
    _btnPublish.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);

    [_btnPublish addTarget:self
                    action:@selector(publishAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPublish];
}

- (void)publishAction:(id)sender
{
    NSDictionary* dic = @{ ACTION_Controller_Name : self, ACTION_Controller_Data : _tribeModel };
    [self RouteMessage:ACTION_SHOW_BANGBANG_BANGPUBLISH withContext:dic];
}

- (void)rightItemAction:(id)sender
{
    NSDictionary* dic = @{ ACTION_Controller_Name : self,
        ACTION_Controller_Data : [NSString stringWithFormat:@"%ld", (long)_tribeID] };
    [self RouteMessage:ACTION_SHOW_BANGBANG_BANGDETAIL withContext:dic];
}

- (NSString*)tableView:(UITableView*)tableView
    titleForHeaderInSection:(NSInteger)section;
{
    return @"";
}

- (UIView*)tableView:(UITableView*)tableView
    viewForHeaderInSection:(NSInteger)section
{

    UIView* headerView = nil;
    headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    [headerView setBackgroundColor:[UIColor whiteColor]];

    [headerView addSubview:_barView];

    UIView* separatorView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    [separatorView setBackgroundColor:TableSeparatorColor];
    [headerView addSubview:separatorView];
    return headerView;
}

- (CGFloat)tableView:(UITableView*)tableView
    estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{

    NSArray* listModel = _dataModel.data;
    return listModel.count;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_barView.selectedIndex == 0) {
        return 80;
    }
    if (_barView.selectedIndex == 1) {
        return 90;
    }
    return 210;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSArray* listModel = _dataModel.data;
    id obj;
    if (listModel.count > 0) {
        obj = listModel[indexPath.row];
    }

    if ([obj isKindOfClass:[TopicModel class]]) {
        static NSString* Identifier = @"InteractionIdentifier";
        InteractionCell* cell =
            [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            cell = [[InteractionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell bindTopic:obj];
        return cell;
    }
    else if ([obj isKindOfClass:[GoodsModel class]]) {
        static NSString* Identifier = @"TribeGoodIdentifier";
        TribeGoodsCell* cell =
            [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            cell = [[TribeGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:Identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell bindGoodsModel:obj];
        return cell;
    }
    else {
        static NSString* Identifier = @"BangActivityCell";
        BangActivityCell* cell =
            [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            cell = [[BangActivityCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:Identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        }
        cell.row = indexPath.row;
        cell.tribelId = _tribeID;
        cell.nextCursor = _dataModel.nextCursor;
        [cell bindModel:obj];
        return cell;
    }
}

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    if (indexPath.section == 0) {

        NSArray* listModel = _dataModel.data;
        id obj = listModel[indexPath.row];
        if ([obj isKindOfClass:[TopicModel class]]) {
            TopicModel* model = obj;
            model.tribeld = _tribeID;
            [self RouteMessage:ACTION_SHOW_BANGBANG_TOPICDETAIL withContext:@{ ACTION_Controller_Name : self, ACTION_Controller_Data : model }];
        }
        if ([obj isKindOfClass:[GoodsModel class]]) {
            GoodsModel *goodsModel = (GoodsModel *)obj;
            goodsModel.shopId = _tribeID;
            goodsModel.shopName = _tribeModel.shopName;
            [messageListner RouteMessage:ACTION_SHOW_BANGBANG_GOODSDETAIL
                             withContext:@{ ACTION_Controller_Name : self, ACTION_Controller_Data : goodsModel }];
        }
        if ([obj isKindOfClass:[ActivityModel class]]) {
            ActivityModel* activityModel = obj;
            NSDictionary* dic = @{ ACTION_Controller_Name : self,
                ACTION_Controller_Data : [NSString stringWithFormat:@"%ld", (long)activityModel.activityId] };

            [self RouteMessage:ACTION_SHOW_BANGBANG_ACTIVITYDETAIL
                   withContext:dic];
        }
    }
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
    }
    _isRefresh = YES;
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _isRefresh = NO;
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
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    [_tableView hideFooterViewAndHeadViewState];
    NSString *text;
    switch (_barView.selectedIndex) {
        case 0:
            
            text = @"没有互动哦!";
            break;
        case 1:
            
            text = @"没有商品哦!";
            break;
            
        default:
            
            text = @"没有活动哦!";
            break;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_b9};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{

    [_tableView tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView
                  willDecelerate:(BOOL)decelerate
{
     [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark SegmentBarViewDelegate

- (void)barSelectedIndexChanged:(int)newIndex
{
    if (newIndex == 1 | newIndex == 2) {
        _btnPublish.hidden = YES;
    }
    else {
        _btnPublish.hidden = NO;
    }

    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
        
    }
    
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%ld_%d",CACHE_BANG_BANGINDEX,(long)_tribeID,newIndex]];
    
    if (!_dataModel) {
        
        _isRefresh = YES;
        [_tableView launchRefreshing];
    }else
        [_tableView reloadData];
    
}

- (void)memmeberAction:(id)send
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self, ACTION_Controller_Name, [NSString stringWithFormat:@"%ld", (long)_tribeID], ACTION_Controller_Data, nil];

    [self RouteMessage:ACTION_SHOW_BANGBANG_MEMBERLIST withContext:dic];
}
- (void)qiandaoAction:(id)send
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self, ACTION_Controller_Name, [NSString stringWithFormat:@"%ld", (long)_tribeID], ACTION_Controller_Data, nil];

    [self RouteMessage:ACTION_SHOW_BANGBANG_QIANDAO withContext:dic];
}

#pragma mark RouteMessage Delegate
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    if ([message isEqualToString:NOTIFICATION_BANG_PUBLISH]) {
        NSDictionary* dic = context;
        if (_dataModel) {
            _dataModel.nextCursor = 0;
            _dataModel.previousCursor = 0;
        }
        _isRefresh = YES;
        [_tableView launchRefreshing];
        
    }
    else {
        [self.messageListner RouteMessage:message withContext:context];
    }
}
@end
