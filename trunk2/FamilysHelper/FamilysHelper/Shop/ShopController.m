//
//  ShopController.m
//  FamilysHelper
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShopController.h"
#import "ShopsService.h"
#import "EGOTableView.h"
#import "GoodCell.h"
#import "TribeModel.h"
#import "GoodsModel.h"
#import "UIImageView+AFNetworking.h"
#import "GoodsDetailViewController.h"
#import "BangIndexController.h"
#import "ShopHeaderView.h"
#import "TribeCategoryModel.h"
#import <CoreLocation/CoreLocation.h>
#import "UIView+Toast.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ShopController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, EGOTableViewDelegate, CLLocationManagerDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic, strong) DataModel* dataModel;
@property (nonatomic, strong) UISearchBar* searchBar; //搜索框
@property (nonatomic, assign) NSInteger getType;
@property (nonatomic, strong) NSString* shopType;
@property (nonatomic, strong) NSString* mapX;
@property (nonatomic, strong) NSString* mapY;
@property (nonatomic, strong) CLLocationManager* locationManager;

@property (nonatomic, strong) UIButton* typeButton;
@property (nonatomic, strong) UIButton* selectButton;
@property (nonatomic, strong) UIButton* oldSelectButton;
@property (nonatomic, strong) UIButton* oldTypeButton;
@property (nonatomic, strong) NSMutableArray* dataArry;
@property (nonatomic, strong) TribeCategoryModel* categoryModel;
@property (nonatomic, strong) UIView* backgroundView;
@property (nonatomic, strong) UIView* selctView;
@property (nonatomic, strong) DataModel* selectData;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation ShopController {
    ASIHTTPRequest* _requestData;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLeftPersonAction];
    _getType = 100;
    _shopType = @"";
    _isRefresh = NO;
    [self initSelectView];
    [self initView];
    [self initData];
    [self bindSelectViewData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRedNavBg];
}

- (void)initData
{
    _dataModel = [AppCache loadCache:[NSString stringWithFormat:@"%@_%ld_%@", CACHE_SHOP_INDEX, (long)_getType, _shopType]];
    [_tableView reloadData];
    if (!_dataModel) {
        [_tableView launchRefreshing];
    }
}

- (void)initView
{

    if (![CLLocationManager locationServicesEnabled]) {

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"定位服务不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        if (!_locationManager) {

            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
            _locationManager.delegate = self;
        }
    }

    [self initializeNavTitleView:@"商家"];

    _mapX = @"117.228644";
    _mapY = @"31.82127";
    [_locationManager startUpdatingLocation]; //开始定位

    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_pick@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(onBtnSelectView:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.automaticallyAdjustsScrollViewInsets = NO;

    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20 - TabBarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight)];
    [_searchBar setBackgroundColor:COLOR_GRAY_LIGHT];
    _searchBar.placeholder = @"搜索商家";
    _searchBar.delegate = self;
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.barTintColor = TableSeparatorColor;
    [_searchBar.layer setBorderWidth:1];
    [_searchBar.layer setBorderColor:TableSeparatorColor.CGColor];

    _tableView.tableHeaderView = _searchBar; //把搜索框放在表头

 
}

- (void)initSelectView
{

    _selctView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight)];
    _selctView.userInteractionEnabled = YES;
    
    UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT/3, SCREEN_HEIGHT -64)];
    typeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [_selctView addSubview:typeView];
    typeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapSelectView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapSelectView:)];
    [typeView addGestureRecognizer:tapSelectView];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3 * 2, SCREEN_HEIGHT - 64)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.userInteractionEnabled = YES;
    [_selctView addSubview:_backgroundView];

    UILabel* graylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 2, 20)];
    graylabel.backgroundColor = [UIColor grayColor];
    [_backgroundView addSubview:graylabel];
    UILabel* selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 50, 20)];
    selectLabel.text = @"筛选";
    selectLabel.font = [UIFont systemFontOfSize:15];
    [_backgroundView addSubview:selectLabel];

    NSArray* selectTitle = @[ @"默认", @"附近", @"推荐" ];
    for (NSInteger i = 0; i < 3; i++) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(_backgroundView.frame.size.width / 3 * i, 40, _backgroundView.frame.size.width / 3, 30);
        _selectButton.tag = 100 + i;
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_selectButton setTitle:selectTitle[i] forState:UIControlStateNormal];
        [_selectButton setTitleColor:COLOR_GRAY_DEFAULT_OPAQUE_7a forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(onselectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:_selectButton];
    }

    UILabel* blueLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 2, 20)];
    blueLabel2.backgroundColor = [UIColor blueColor];
    [_backgroundView addSubview:blueLabel2];
    UILabel* typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 75, 50, 20)];
    typeLabel.text = @"类型";
    typeLabel.font = [UIFont systemFontOfSize:15];
    [_backgroundView addSubview:typeLabel];

    _selctView.hidden = YES;
}

- (void)bindSelectViewData
{
    _selectData = [AppCache loadCache:CACHE_SHOP_INDEXSELECT];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, _backgroundView.frame.size.width, _selctView.frame.size.height - 100)];
    [_backgroundView addSubview:_scrollView];

    _dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    [_dataArry addObject:@"全部"];
    for (NSInteger i = 0; i < ((NSArray*)_selectData.data).count; i++) {
        _categoryModel = ((NSArray*)_selectData.data)[i];
        [_dataArry addObject:_categoryModel.tribeName];
    }

    for (NSInteger j = 0; j < _dataArry.count; j++) {

        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];

        _typeButton.frame = CGRectMake(0, j * 30, _backgroundView.frame.size.width, 30);

        _typeButton.tag = 200 + j;
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_typeButton setTitle:_dataArry[j] forState:UIControlStateNormal];
        [_typeButton setTitleColor:COLOR_GRAY_DEFAULT_OPAQUE_7a forState:UIControlStateNormal];
        [_typeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_typeButton addTarget:self action:@selector(onselectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_typeButton];
    }
    if (_dataArry.count * 30 > _scrollView.frame.size.height) {
        _scrollView.contentSize = CGSizeMake(0, _dataArry.count * 30 + 60);
    }

    _oldSelectButton = (UIButton*)[_selctView viewWithTag:100];
    _oldSelectButton.selected = YES;

    _oldTypeButton = (UIButton*)[_selctView viewWithTag:200];
    _oldTypeButton.selected = YES;
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    
    return ((NSArray*)_dataModel.data).count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

        TribeModel* model = _dataModel.data[section];
        return model.goodslist.count;
}

- (void)loadData
{
    
    if (_requestData) {
        [_requestData cancel];
    }
    if (_getType == 100) {
        _requestData = [[ShopsService shareInstance] getTribeGoodsList:_searchBar.text
                                                             shoptypes:_shopType
                                                            nextCursor:_dataModel.nextCursor
                                                                  mapX:_mapX
                                                                  mapY:_mapY
                                                             OnSuccess:^(DataModel* dataModel) {
                                                                 [self loadSelectType:dataModel];
                                                             }];
    }
    else if (_getType == 101) {

        _requestData = [[ShopsService shareInstance] getNearTribeGoodsList:_searchBar.text
                                                                 shoptypes:_shopType
                                                                nextCursor:_dataModel.nextCursor
                                                                      mapX:_mapX
                                                                      mapY:_mapY
                                                                 OnSuccess:^(DataModel* dataModel) {
                                                                     [self loadSelectType:dataModel];

                                                                 }];
    }
    else if (_getType == 102) {

        _requestData = [[ShopsService shareInstance] getRecommendTribeGoodsList:_searchBar.text
                                                                      shoptypes:_shopType
                                                                     nextCursor:_dataModel.nextCursor
                                                                           mapX:_mapX
                                                                           mapY:_mapY
                                                                      OnSuccess:^(DataModel* dataModel) {
                                                                          [self loadSelectType:dataModel];

                                                                      }];
    }
}

//加载数据
- (void)loadSelectType:(DataModel*)dataModel
{
    if (dataModel.code == 200) {
        
        if (_dataModel && !_isRefresh) {

            [_dataModel.data addObjectsFromArray:dataModel.data];
            _dataModel.code = dataModel.code;
            _dataModel.nextCursor = dataModel.nextCursor;
            _dataModel.previousCursor = dataModel.previousCursor;
            _dataModel.error = dataModel.error;
        }
        else
            _dataModel = dataModel;

        [AppCache saveCache:[NSString stringWithFormat:@"%@_%ld_%@", CACHE_SHOP_INDEX, (long)_getType, _shopType] Data:_dataModel];

        if ([dataModel.data count] == 0)
            _tableView.reachedTheEnd = YES;
        [_tableView reloadData];
    }
    [_tableView tableViewDidFinishedLoading];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

        static NSString* cellid = @"shopContrillerCell";
        GoodCell* shopContrillerCell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!shopContrillerCell) {
            shopContrillerCell = [[GoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            shopContrillerCell.selectionStyle = UITableViewCellSelectionStyleNone;
            shopContrillerCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        }
        TribeModel* tribe = _dataModel.data[indexPath.section];

        if (tribe.goodslist.count > indexPath.row) {
            GoodsModel* model = [tribe.goodslist objectAtIndex:indexPath.row];
            [shopContrillerCell bindGoodModel:model];
        }

        return shopContrillerCell;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString* headerReuseIdentifier = @"ShopHeaderReuseIdentifier";
    ShopHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    if (!headerView) {
        headerView = [[ShopHeaderView alloc] initWithReuseIdentifier:headerReuseIdentifier];
        headerView.messageListner = self;
    }
 
    TribeModel* tribe = _dataModel.data[section];
    [headerView bindTribeModel:tribe];

    return headerView;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 75;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString* footerReuseIdentifier = @"ShopFooterReuseIdentifier";
    UITableViewHeaderFooterView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerReuseIdentifier];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerReuseIdentifier];
        footerView.contentView.backgroundColor = TableSeparatorColor;
    }

    return footerView;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 90;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    TribeModel* tribe = _dataModel.data[indexPath.section];
    GoodsModel* goods = [tribe.goodslist objectAtIndex:indexPath.row];
    goods.shopName = tribe.shopName;
    goods.shopId = tribe.shopId;

    NSDictionary* dic = @{ ACTION_Controller_Name : self, ACTION_Controller_Data : goods };

    [self RouteMessage:ACTION_SHOW_BANGBANG_GOODSDETAIL
           withContext:dic];
}

#pragma mark
#pragma mark-- UIButtonAction

- (void)onBtnSelectView:(UIButton*)sender
{
    _selctView.hidden = !_selctView.hidden;
    [self.view.window addSubview:_selctView];
}

-(void)onTapSelectView:(UITapGestureRecognizer *)sender{
    _selctView.hidden = YES;
}

//筛选
- (void)onselectBtn:(UIButton*)sender
{

    [_dataModel.data removeAllObjects];

    if (sender.tag >= 100 && sender.tag <= 102) {

        _getType = sender.tag;

        UIButton* selecButton = (UIButton*)[_selctView viewWithTag:sender.tag];
        selecButton.selected = !selecButton.selected;
        _oldSelectButton.selected = !_oldSelectButton.selected;
        _oldSelectButton = selecButton;
    }
    else if (sender.tag >= 200) {

        if (sender.tag == 200) {

            _shopType = @"";
        }
        else {
            TribeCategoryModel* categoryModel = ((NSArray*)_selectData.data)[sender.tag - 201];
            _shopType = [NSString stringWithFormat:@"%d", categoryModel.tribeId];
        }

        UIButton* typeButton = (UIButton*)[_selctView viewWithTag:sender.tag];
        typeButton.selected = !typeButton.selected;
        _oldTypeButton.selected = !_oldTypeButton.selected;
        _oldTypeButton = typeButton;
    }
    [_locationManager startUpdatingLocation]; //重新开始定位

    [self initData];

    _selctView.hidden = !_selctView.hidden;
}

#pragma mark
#pragma mark-- CLLocationManagerDelegate
//协议中定义的方法，坐标改变时被调用
- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations
{
    CLLocation* location = locations[0];
    //location.coordinate.latitude;//纬度
    //location.coordinate.longitude;//经度
    _mapX = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    _mapY = [NSString stringWithFormat:@"%f", location.coordinate.latitude];

    [_locationManager stopUpdatingLocation];
}

//协议中定义的方法，定位出错被调用
- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
    [self.view makeToast:@"定位出错" duration:1 position:nil];
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
#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    
    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
    _isRefresh = YES;
    _shopType = @"";
    [self loadData];
}

//UISearchBarDelegate协议中定义的方法，当开始编辑时（搜索框成为第一响应者时）被调用。
- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar
{
    _searchBar.showsCancelButton = YES;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    _searchBar.text = @"";
    if (_dataModel) {
        _dataModel.nextCursor = 0;
        _dataModel.previousCursor = 0;
    }
    _isRefresh = YES;
    [self loadData];
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无商家哦!";
    [_tableView hideFooterViewAndHeadViewState];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_OPAQUE_b9};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

@end