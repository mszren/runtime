//
//  InteractionViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GoodsViewController.h"
#import "SegmentBarView.h"
#import "InteractionCell.h"
#import "TribeService.h"

@interface GoodsViewController ()<UITableViewDataSource,UITableViewDelegate,EGOTableViewDelegate>
{
    DataModel *_dataModel;
}
@end

@implementation GoodsViewController{
    
    NSMutableArray *_dataSource;
}

-(id) init{
    self=[super init];
    if (self) {
        _tableView = [[EGOTableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight- TopBarHeight-20) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.pullingDelegate = self;
        _tableView.autoScrollToNextPage = NO;
        
        [_tableView setBackgroundColor:AllTableViewColor];
        
        [self.view addSubview:_tableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}


- (void)loadData
{
    [[TribeService shareInstance] getTribeInteBy:_tribeID typeID:1 OnSuccess:^(DataModel *dataModel) {
        
        if (dataModel.code==200) {
            
            if (_dataModel) {
                [(NSMutableArray*)_dataModel.data addObjectsFromArray:dataModel.data];
                _dataModel.code=dataModel.code;
                _dataModel.error=dataModel.error;
                _dataModel.nextCursor=dataModel.nextCursor;
                _dataModel.previousCursor=dataModel.previousCursor;
            }
            else
                _dataModel=dataModel;
            
            if (_dataModel.previousCursor == _dataModel.nextCursor) {
                _tableView.reachedTheEnd = YES;
            }else{
                _tableView.reachedTheEnd = NO;
            }
            [_tableView reloadData];
        }
        else{
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
            _tableView.reachedTheEnd = NO;
        }
        [_tableView tableViewDidFinishedLoading];
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
    
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _segBarView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    return 40;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * listModel=_dataModel.data;
    return listModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier=@"InteractionIdentifier";
    InteractionCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell=[[InteractionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSArray * listModel=_dataModel.data;
    [cell bindTopic:listModel[indexPath.row]];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark EGOTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView *)tableView{
    
    if (_dataModel) {
        _dataModel.nextCursor=0;
        _dataModel.previousCursor=0;
        [((NSMutableArray*)_dataModel.data) removeAllObjects];
    }
    [self loadData];
    //[self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView *)tableView{
    _dataModel.nextCursor++;
    [self loadData];
    //[self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [NSDate date];
}
- (NSDate *)pullingTableViewLoadingFinishedDate{
    return [NSDate date];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tableView tableViewDidEndDragging:scrollView];
}



@end
