//
//  UUBaseMessageController.m
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//



#import "UUBaseMessageController.h"

@interface UUBaseMessageController ()<UITableViewDataSource,UITableViewDelegate>{

}

@end

@implementation UUBaseMessageController

#pragma mark
#pragma mark --  initialize & delloc
- (id) init{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _currentPage = 0;
    
    _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight-20-ChatBarHeight)];
    _chatTableView.dataSource = self;
    _chatTableView.delegate = self;
    _chatTableView.backgroundColor = [UIColor clearColor];
    _chatTableView.backgroundView = nil;
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_chatTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setWhiteNavBg];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark --  initialize view


#pragma mark
#pragma mark -- UIKeyboardWillHideNotification
- (void) changeTableViewFrameByInputHeightGrowing:(CGFloat)lheight{
    _chatTableView.frame = CGRectMake(_chatTableView.frame.origin.x, _chatTableView.frame.origin.y, _chatTableView.frame.size.width, SCREEN_HEIGHT-TopBarHeight-20- lheight);
    [self tableViewScrollToBottom];
}


#pragma mark
#pragma mark -- tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (_dataList.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataList.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark
#pragma mark -- tableView delegate  & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark
#pragma mark -- table view display
- (void)tableView:(UITableView *)ltableView didEndDisplayingCell:(UITableViewCell *)lcell forRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)tableView:(UITableView *)ltableView willDisplayCell:(UITableViewCell *)lcell forRowAtIndexPath:(NSIndexPath *)indexPath{

}




@end

