//
//  MyTopicViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TopicDetailController.h"
#import "EGOTableView.h"
#import "TribeService.h"
#import "TopicModel.h"
#import "TopicDetailCell.h"
#import "activityCommentView.h"
#import "SelectTopicView.h"
#import "UIView+Toast.h"
@interface TopicDetailController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, EGOTableViewDelegate> {
}
@end

@implementation TopicDetailController {
    EGOTableView* _tableView;
    UILabel* _labelTitle;
    UIView* _headerView;
    NSMutableArray* _dataSource; //请求数据
    DataModel* _dataModel;
    NSInteger type;
    SelectTopicView* selecttopicView;
    ASIHTTPRequest* _request;
    ASIHTTPRequest* _saveRequest;
    BOOL _Refresh;
    MBProgressHUD *_hud;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
     _Refresh = NO;
    [self initView];
    [self loadData];
    
}

- (void)loadData
{
    if (_request) {
        [_request cancel];
    }
    _request = [[TribeService shareInstance]
        getTribeDiscussReplyListBy:_publishID
                            typeId:1
                              type:type
                        nextCursor:_dataModel.nextCursor
                         OnSuccess:^(DataModel* dataModel) {
                             if (dataModel.code == 200) {

                                 if (_dataModel && !_Refresh) {
                                     TopicModel* temp = dataModel.data;
                                     if ((TopicModel*)_dataModel.data) {
                                         [((TopicModel*)_dataModel.data).commentList addObjectsFromArray:temp.commentList];
                                     }
                                     _dataModel.code = dataModel.code;
                                     _dataModel.error = dataModel.error;
                                     _dataModel.nextCursor = dataModel.nextCursor;
                                     _dataModel.previousCursor = dataModel.previousCursor;
                                 }
                                 else
                                     _dataModel = dataModel;
                                 
                                 _labelTitle.text = ((TopicModel*)_dataModel.data).topic;

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

- (void)initView
{
    
    UIBarButtonItem* rightItem =
    [[UIBarButtonItem alloc] initWithTitle:@"筛选"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    

    selecttopicView = [[SelectTopicView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [_headerView setBackgroundColor:[UIColor whiteColor]];

    UIImageView* bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_detail_top"]];
    bgImage.frame = CGRectMake(0, 12, bgImage.frame.size.width, bgImage.frame.size.height);
    [_headerView addSubview:bgImage];

    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH, 33)];
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    [_labelTitle setFont:FONT_SIZE_15];
    [_labelTitle setTextColor:HomeNavBarBgColor];
    [_headerView addSubview:_labelTitle];
    UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(SCREEN_WIDTH - 55, 5, 40, 25);
    [saveButton setTitle:@"收藏" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    saveButton.layer.borderWidth = 0.8;
    saveButton.layer.cornerRadius = 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
    CGColorSpaceRelease(colorSpace);
    saveButton.layer.borderColor = borderColorRef;
    CGColorRelease(borderColorRef);
    [saveButton setTitleColor:RedColor1 forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(onBtnSave:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:saveButton];

    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20) style:UITableViewStylePlain];
    _tableView.backgroundColor = AllTableViewColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView*)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 33;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((TopicModel*)_dataModel.data).commentList.count + 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {

        static NSString* myTopicIdentifier = @"MyTopicIdentifier";
        TopicDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:myTopicIdentifier];
        if (!cell) {
            cell = [[TopicDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myTopicIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tribeID = _tribeId;
            cell.messageListner = self;
            cell.floorNum = indexPath.row;
        }
        ((TopicModel*)_dataModel.data).tribeld = _tribeId;
        if (indexPath.row == 0) {
            
            [cell bindTopic:(TopicModel*)_dataModel.data];
        }
        else {
            CommentModel *commentModel = ((TopicModel*)_dataModel.data).commentList[indexPath.row - 1];
            commentModel.publishId = ((TopicModel*)_dataModel.data).publishId;
            [cell bindComment:commentModel];
        }

        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    if (indexPath.row == 0) {
        return ((TopicModel*)_dataModel.data).contentHeight + ((TopicModel*)_dataModel.data).imageHeight + 92;
    }
    else {
        CommentModel* _comentModel = ((TopicModel*)_dataModel.data).commentList[indexPath.row - 1];
        return _comentModel.contentHeight + _comentModel.imageHeight + _comentModel.replyContentHeight + 92;
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
    _Refresh = YES;
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    _Refresh = NO;
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
}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView tableViewDidEndDragging:scrollView];
}
#pragma mark
#pragma mark--UIButtonAction
- (void)onBtnSave:(UIButton*)sender
{

    if (_saveRequest) {
        [_saveRequest cancel];
    }
    _saveRequest = [[TribeService shareInstance] addMyCollect:[CurrentAccount currentAccount].uid
                                                         type:1
                                                     objectId:_publishID
                                                    OnSuccess:^(DataModel* dataModel) {

                                                        if (dataModel.code == 202) {
                                                            [ToastManager showToast:@"收藏成功" withTime:Toast_Hide_TIME];
                                                        }
                                                        else {

                                                            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                        }
                                                    }];
}
- (void)rightItemAction:(id)sender
{
    
        selecttopicView.blockComment = ^(NSInteger _type) {

            type = _type;
            if (_dataModel) {
                _dataModel.nextCursor = 0;
                _dataModel.previousCursor = 0;
            }
            _Refresh = YES;
            [self loadData];

        };
        selecttopicView.type = type;
        [self.view addSubview:selecttopicView];
}

#pragma mark RouteMessage Delegate
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    if ([message isEqualToString:NOTIFICATION_ANSWER]) {
        NSDictionary* dic = context;
        CommentModel* commentModel = [dic objectForKey:NOTIFICATION_DATA];
        [((TopicModel*)_dataModel.data).commentList addObject:commentModel];

        [_tableView reloadData];
    }
    else {
        [self.messageListner RouteMessage:message withContext:context];
    }
}

@end
