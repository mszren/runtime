//
//  MyGroupsController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GroupModel.h"
#import "GroupsCell.h"
#import "MyGroupsController.h"
#import "ChatGroupDetailController.h"

@interface MyGroupsController()<UITableViewDataSource,UITableViewDelegate>{

    UITableView * _tableView;
}
@end


@implementation MyGroupsController

#pragma mark
#pragma mark -- init
- (id) init{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initializeNavTitleView:@"亲友群"];
    [self initializeNavBackView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight -20)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self loadCacheData];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [request clearDelegatesAndCancel];
    request = nil;
}

#pragma mark
#pragma mark -- request method
- (void) requestData
{
    request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:MyGroupListUrl]];
    [request addPostValue:[CurrentAccount currentAccount].username forKey:@"phone"];
    request.delegate = self;
    request.timeOutSeconds = HTTP_TIMEOUT;
    [request setDidFinishSelector:@selector(requestResult:)];
    [request setDidFailSelector:@selector(requestErr:)];
    [request startAsynchronous];
}
#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestResult:(ASIHTTPRequest *)aRequest{
    NSData *data =[aRequest responseData];
    //解析json
    NSError *error = nil;
    NSDictionary *totlaDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"totlaDic==%@",[[NSString alloc] initWithData:[aRequest responseData] encoding:NSUTF8StringEncoding]);
    
    NSArray * dataList= [totlaDic objectForKey:@"o"];
    NSInteger num = dataList.count;
    [_dataList removeAllObjects];
    for (int i = 0 ; i < num; i++) {
        NSDictionary * dic = [dataList objectAtIndex:i];
        GroupModel * groupModel = [GroupModel JsonParse:dic];
        [_dataList addObject:groupModel];
    }
    [self saveCacheData];
    [_tableView reloadData];
}
- (void)requestErr:(ASIHTTPRequest *)request{
      [ToastManager showToast:Toast_NetWork_Bad withTime:Toast_Hide_TIME];
}

#pragma mark
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)ltableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
}
- (UIView *)tableView:(UITableView *)lTableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = LightGrayColor1;
    header.layer.borderWidth = 1.0f;
    header.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, 100.0, 17.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = RedColor1;
    headerLabel.font = [UIFont systemFontOfSize:14.0];
    if (section) {
        headerLabel.text = @"我加入的亲友群";
    }else{
        headerLabel.text = @"我的亲友群";
    }
    [header addSubview:headerLabel];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = @"GroupsCellIdentifier";
    GroupsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[GroupsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setViewDefault];
    }
    if (_dataList.count > indexPath.section) {
        GroupModel * aModel = [_dataList objectAtIndex:indexPath.section];
        [cell setViewData:aModel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableChatHomeCellHeight;
}

- (void)tableView:(UITableView *)ltableView didEndDisplayingCell:(UITableViewCell *)lcell forRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupsCell * cell = (GroupsCell *)lcell;
    [cell cancelAllBtnImageLoad];
}
- (void)tableView:(UITableView *)ltableView willDisplayCell:(UITableViewCell *)lcell forRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupsCell * cell =(GroupsCell *)lcell;
    if (_dataList.count > indexPath.section) {
        GroupModel * model = [_dataList objectAtIndex:indexPath.section];
        [cell loadHeadImg:model];
    }
}
#pragma mark
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataList.count > indexPath.section) {
        GroupModel * model = [_dataList objectAtIndex:indexPath.section];
        ChatGroupDetailController * controller = [[ChatGroupDetailController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.currentGroupModel = [UserMessageModel parseWithGroupModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }

}
#pragma mark -
#pragma mark DataManager
- (NSString *)FileStrName{
    NSString * str = [NSString stringWithFormat:@"MyGroupsController_%@_%lu",MyGroupListUrl,(unsigned long)[CurrentAccount currentAccount].uid];
    return str;
}
- (void)saveCacheData{
    NSArray *cacheDataArray = _dataList;
    [FileCache storageObject:cacheDataArray url:[self FileStrName]];
}
- (void)loadCacheData{
    NSArray *dataList = [FileCache loadObjectWithUrl:[self FileStrName]];
    [_dataList removeAllObjects];
    [_dataList addObjectsFromArray:dataList];
}
@end
