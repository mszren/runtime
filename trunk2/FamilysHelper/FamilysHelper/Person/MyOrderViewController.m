//
//  MyOrderViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyOrderViewController.h"
#import "EGOTableView.h"
#import "UserService.h"
#import "OrderCell.h"
#import "SegmentBarView.h"
#import "TribeModel.h"
#import "GoodsModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "EditView.h"
@interface MyOrderViewController () <EGOTableViewDelegate, UITableViewDataSource, UITableViewDelegate,SegmentBarViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> {
    BOOL _iRefresh;
    ASIHTTPRequest* _request;
    NSString *payStatus;
    BOOL _isEdit;
    UIBarButtonItem *_rightButton;
    NSMutableString *_delectOrderNums;
    NSMutableArray *_deldectOrders;
}

@end

@implementation MyOrderViewController{

    SegmentBarView* _barView;
    EditView *_editView;
     NSMutableIndexSet *_indexSetToDel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _iRefresh = NO;
    _isEdit = NO;
    [self setWhiteNavBg];
    [self initView];
    
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%ld_%d", CACHE_PERSON_MYORDER, (long)[CurrentAccount currentAccount].uid,_barView.selectedIndex]];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

- (void)initView
{
    
    [self initializeWhiteBackgroudView:@"我的购"];
    
    _deldectOrders = [[NSMutableArray alloc]initWithCapacity:0];
    _delectOrderNums = [[NSMutableString alloc]initWithCapacity:0];
    _indexSetToDel = [[NSMutableIndexSet alloc]init];
    _rightButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onEdit:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _barView = [[SegmentBarView alloc]
                initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                andItems:@[ @"待付款", @"待消费", @"已消费" ,@"已取消",@"已退款"]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.tableHeaderView = _barView;
    _tableView.emptyDataSetDelegate= self;
    _tableView.emptyDataSetSource = self;
    [self.view addSubview:_tableView];
    
    _editView = [[EditView alloc]
                initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TopBarHeight - 54, SCREEN_WIDTH, 34)];
    [_editView.cancelButton addTarget:self
                      action:@selector(onBtnCancel:)
            forControlEvents:UIControlEventTouchUpInside];
    [_editView.deletButton addTarget:self
                     action:@selector(onBtnDelet:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editView];
    _editView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    [_tableView hideFooterViewAndHeadViewState];
    NSString *text = @"还没有订单哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_7a};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
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


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 170;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)_dataModel.data).count;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    if (_isEdit) {
        [_indexSetToDel  addIndex:indexPath.row];
    }
    else{
        OrderModel * ordermodel;
        ordermodel = _dataModel.data[indexPath.section];
        GoodsModel* goods = [[GoodsModel alloc]init ];
        goods.shopName = ordermodel.shopname;
        goods.shopId = ordermodel.shopId;
        goods.goodsId=ordermodel.goodsId;
        goods.goodsName=ordermodel.goodsname;
        if (ordermodel.payStatus >= 11 && ordermodel.payStatus <= 15) {
            //进入退货详情
            
            NSDictionary *dic = @{ACTION_Controller_Name:self,ACTION_Controller_Data:@(ordermodel.orderId)};
            
            [self RouteMessage:ACTION_SHOW_PERSON_CENTER_RETURNORDEL withContext:dic];
        }else{
            
            NSDictionary* dic = @{ ACTION_Controller_Name : self, ACTION_Controller_Data : goods };
            [self RouteMessage:ACTION_SHOW_BANGBANG_GOODSDETAIL
                   withContext:dic];
        }
    }

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isEdit) {
        [_indexSetToDel removeIndex:indexPath.row];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"myorderCellIdentifier";
    OrderCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil] lastObject];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        [cell initView];
    }
    NSArray* list = _dataModel.data;
    [cell bindMsgModel:list[indexPath.row] index:indexPath.row isEdit:_isEdit];
     cell.bockcancel = ^(void) {
        [_tableView launchRefreshing];
     };
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
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
- (void)loadData
{
    if (_request) {
        [_request cancel];
    }
    switch (_barView.selectedIndex) {
        case 0: {
            payStatus =@"1" ;
            break;
        }
        case 1: {
            payStatus =@"2" ;
            break;
        }
        case 2: {
            payStatus =@"3" ;
            break;
        case 3: {
            payStatus =@"4" ;
            break;
        }
        case 4: {
            payStatus =@"5" ;
            break;
        }
        default:
            break;

        }
        
    }
            
    _request = [[UserService shareInstance] getMyOrderList:[CurrentAccount currentAccount].uid
                                      payStatus:payStatus
                                     nextCursor:_dataModel.nextCursor
                                      OnSuccess:^(DataModel* dataModel) {
                                          if (dataModel.code == 200) {

                                              if (_dataModel && !_iRefresh) {
                                                  NSMutableArray* list = _dataModel.data;
                                                  [list addObjectsFromArray:dataModel.data];
                                                  _dataModel.data = list;
                                                  _dataModel.previousCursor = dataModel.previousCursor;
                                                  _dataModel.nextCursor = dataModel.nextCursor;
                                              }
                                              else
                                                  _dataModel = dataModel;

                                              [AppCache saveCache:[NSString stringWithFormat:@"%@_%ld_%d", CACHE_PERSON_MYORDER, (long)[CurrentAccount currentAccount].uid,_barView.selectedIndex] Data:_dataModel];

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
#pragma mark -
#pragma mark SegmentBarViewDelegate

- (void)barSelectedIndexChanged:(int)newIndex
{
    _isEdit = NO;
    _editView.hidden = YES;
    _rightButton.enabled = YES;
    [_tableView setEditing:NO animated:YES];
    [_indexSetToDel removeAllIndexes];
    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%ld_%d", CACHE_PERSON_MYORDER, (long)[CurrentAccount currentAccount].uid,_barView.selectedIndex]];
    [_tableView reloadData];
    if (!_dataModel) {
        
        _iRefresh = YES;
        [_tableView launchRefreshing];
    }

}

#pragma mark
#pragma mark ButtonAction
-(void)onEdit:(UIBarButtonItem *)sender{
    _editView.hidden = NO;
    _isEdit = YES;
    _rightButton.enabled = NO;
    [_tableView setEditing:YES animated:YES];
}

-(void)onBtnCancel:(UIButton *)sender{
    
    _editView.hidden = YES;
    _isEdit = NO;
    _rightButton.enabled = YES;
    [_indexSetToDel removeAllIndexes];
    [_tableView setEditing:NO animated:YES];
    
}

-(void)onBtnDelet:(UIButton *)sender{
    if (_indexSetToDel.count > 0) {
        
        [_deldectOrders addObjectsFromArray:[_dataModel.data objectsAtIndexes:_indexSetToDel ]];
        for (NSInteger i = 0; i<_deldectOrders.count; i++) {
            OrderModel *model = _deldectOrders[i];
            if (i == _deldectOrders.count - 1) {
                [_delectOrderNums appendFormat:@"%@",model.orderNum];
            }
            else{
                [_delectOrderNums appendFormat:@"%@,",model.orderNum];
            }
        }
        _editView.hidden = YES;
        _isEdit = NO;
        _rightButton.enabled = YES;
        [self deldecOrderNums];
        _delectOrderNums = [[NSMutableString alloc]initWithCapacity:0];
        [_deldectOrders removeAllObjects];
        [_indexSetToDel removeAllIndexes];
        [_tableView setEditing:NO animated:YES];
    }
    else{
        [ToastManager showToast:@"请选择删除对象" withTime:Toast_Hide_TIME];
        return;
    }
    
}

-(void)deldecOrderNums{
    [[UserService shareInstance] deleteMyOrder:_delectOrderNums OnSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 202) {
            [ToastManager showToast:@"删除订单成功" withTime:Toast_Hide_TIME];
        }
        else
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
        
        if (_dataModel) {
            _dataModel.nextCursor = 0;
            _dataModel.previousCursor = 0;
        }
        _iRefresh = YES;
        [self loadData];
        
    }];
}

@end