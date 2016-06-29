//
//  CommentViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CommentViewController.h"
#import "ShopCommentCell.h"
#import "ShopsService.h"
#import "CommentModel.h"
#import "EGOTableView.h"
#import "UIImageView+AFNetworking.h"
#import "activityCommentView.h"
#import "BuyView.h"
#import "OrdeViewController.h"
#import "OrderModel.h"
#import "MsgListModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CommentViewController () <EGOTableViewDelegate,
    UITableViewDataSource, UITableViewDelegate,
    UIScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) GoodsModel* goods;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) DataModel* dataModel;
@property (nonatomic,strong)BuyView *buyView;
@property (nonatomic,strong)MsgListModel *msglistModel;

@end

 
@implementation CommentViewController{
    BOOL isRfresh;
    BOOL iFinishComment;
    BOOL iFinishGoods;
    BOOL IfinishBangBi;
    ASIHTTPRequest *_commentRequest;
    ASIHTTPRequest *_goodsRequest;
    ASIHTTPRequest *_bangBiRequest;
}

@synthesize messageListner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self inintView];
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENT,_goodsId]];
    _goods = [AppCache loadCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENTGOODS,_goodsId]];
    _msglistModel = [AppCache loadCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENTBUY,_goodsId]];

    if (!_dataModel && !_goods && !_msglistModel) {
        [_tableView launchRefreshing];
        
    }else{
        
        float price = _goods.goodsPrice;
        _buyView.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",price];
        
        _buyView.banBiLabel.text = [NSString stringWithFormat:@"可以使用帮币%.2f", _msglistModel.count];
    }
    
}

- (void)inintView
{

    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, -34, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 30) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    
    _tableView.backgroundView = nil;

    _tableView.dataSource = self;

    _tableView.delegate = self;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.pullingDelegate = self;

    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;

    [self.view addSubview:_tableView];

    _buyView = [[BuyView alloc]
        initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TopBarHeight - 64, SCREEN_WIDTH, 44)];
    [_buyView.byButton addTarget:self
                          action:@selector(onBtnBuy:)
                forControlEvents:UIControlEventTouchUpInside];
    float price = _goods.goodsPrice;
    _buyView.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",price];
    _buyView.banBiLabel.text = [NSString stringWithFormat:@"可以使用帮币%.2f", _msglistModel.count];
    [self.view addSubview:_buyView];
}

- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{

    if (_dataModel) {

        _dataModel.nextCursor = 0;

        _dataModel.previousCursor = 0;

    }
    isRfresh = YES;
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    isRfresh = NO;
    [self loadData];
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{

    return [NSDate date];
}

-(void)fifnishLoad{
    if (iFinishGoods && IfinishBangBi &&iFinishComment) {
        
        float price = _goods.goodsPrice;
        _buyView.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",price];
        
        _buyView.banBiLabel.text = [NSString stringWithFormat:@"可以使用帮币%.2f", _msglistModel.count];
        
        
        [_tableView reloadData];
        [_tableView tableViewDidFinishedLoading];
    }
    
}

-(void)loadData{
    
    [self loadBangBi];
    [self loadComment];
    [self loadGoods];
    
}

-(void)loadComment{
 
    
    if (_commentRequest) {
        [_commentRequest cancel];
    }
    
    _commentRequest = [[ShopsService shareInstance]
     getCommentInfoListV2:_goodsId
     type:1
     nextCursor:_dataModel.nextCursor
     onSuccess:^(DataModel* dataModel) {
         if (dataModel.code == 200) {
             
             if (isRfresh) {
                 _dataModel = nil;
             }
             NSMutableArray* reslutData =
             [NSMutableArray arrayWithCapacity:0];
             if (_dataModel) {
                 [reslutData addObjectsFromArray:_dataModel.data];
                 _dataModel.code = dataModel.code;
                 _dataModel.nextCursor = dataModel.nextCursor;
                 _dataModel.previousCursor = dataModel.previousCursor;
                 _dataModel.error = dataModel.error;
                 
             }
             [reslutData addObjectsFromArray:dataModel.data];
             dataModel.data = reslutData;
             _dataModel = dataModel;
             [AppCache saveCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENT,_goodsId] Data:_dataModel];
             
             
         }
         iFinishComment = YES;
         [self fifnishLoad];
         
        }];
    
}

-(void)loadGoods{
    
 
 
    if (_goodsRequest) {
        [_goodsRequest cancel];
    }
    _goodsRequest = [[ShopsService shareInstance] getGoodsInfoV2:_goodsId userId:[CurrentAccount currentAccount].uid
                                       OnSuccess:^(DataModel* dataModel) {
                                           if (dataModel.code == 200) {
                                               
                                               _goods = dataModel.data;
                                               [AppCache saveCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENTGOODS,_goodsId]  Data:_goods];
                                               
                                           }
                                           iFinishGoods = YES;
                                           [self fifnishLoad];
                                       }];
    
}

-(void)loadBangBi{
 

    if (_bangBiRequest) {
        [_bangBiRequest cancel];
    }
    _bangBiRequest = [[ShopsService shareInstance] getCouldUseBangBiCountV2:_goodsId userId:[CurrentAccount currentAccount].uid
                                                 onSuccess:^(DataModel* dataModel) {
                                                     if (dataModel.code == 200) {
                                                         
                                                         _msglistModel = dataModel.data;
                                                         [AppCache saveCache:[NSString stringWithFormat:@"%@%d",CACHE_SHOP_COMMENTBUY,_goodsId] Data:_msglistModel];
                                                         
                                                     }

                                                     IfinishBangBi = YES;
                                                     [self fifnishLoad];
                                                 }];
}



- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CommentModel* commentModel = _dataModel.data[indexPath.row];
    if (commentModel.imgurl.count == 0 || [commentModel.imgurl[0] isEqualToString:@""]) {
        return 115 + commentModel.childCommentList.count * 30;
    }
    else {

        return 205 + commentModel.childCommentList.count * 30;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{

    return ((NSArray*)_dataModel.data).count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* identifier = @"CommentViewCell";

    ShopCommentCell* commentCell =
        [tableView dequeueReusableCellWithIdentifier:identifier];

    if (commentCell == nil) {

        commentCell =
            [[ShopCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:identifier];
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commentCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }

    CommentModel* comment = _dataModel.data[indexPath.row];
    [commentCell.informButton addTarget:self
                                 action:@selector(onBtnInform:)
                       forControlEvents:UIControlEventTouchUpInside];

    [commentCell bindcomment:comment];

    return commentCell;
}

#pragma mark
#pragma mark-- UIButtonAction
- (void)onBtnComment:(UIButton*)sender
{

    activityCommentView* commentView = [[activityCommentView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    commentView.type = 1;
    commentView.objectType = 3;
    [self.view.window addSubview:commentView];

    [self loadData];
}

- (void)onBtnInform:(UIButton*)sender

{

    activityCommentView* commentView = [[activityCommentView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    commentView.type = 1;
    [self.view.window addSubview:commentView];
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


#pragma  mark
#pragma mark -- UIButtonAction
- (void)onBtnBuy:(UIButton*)sender
{
        
        OrdeViewController *orVc = [[OrdeViewController alloc]init];
        
            [[ShopsService shareInstance] saveGoodsOrderFormInfo:[CurrentAccount currentAccount].uid goodsId:_goodsId shopId:_shopId onSuccess:^(DataModel *dataModel) {
                if (dataModel.code == 200) {
                    OrderModel* orderModel = dataModel.data;
                    
                    orderModel.bangbi = _msglistModel.count;
                    orderModel.goods = _goods;
                    orderModel.goodsId = _goodsId;
                    orderModel.goodsname = _goodsName;
                    orderModel.shopname = _shopName;
                    orderModel.goodsTitle = _goods.goodstitle;
                    NSDictionary* dic = @{ ACTION_Controller_Name : messageListner, ACTION_Controller_Data : orderModel };
                    
                    [self RouteMessage:ACTION_SHOW_SHOP_ORDER
                           withContext:dic];
                }else{
                    
                    [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                }
        
            }];

}

#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_wpl@2x"];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    [_tableView hideFooterViewAndHeadViewState];
    NSString *text = @"没有评论哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_7a};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end