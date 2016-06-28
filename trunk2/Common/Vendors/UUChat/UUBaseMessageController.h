//
//  UUBaseMessageController.h
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseViewController.h"

#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "UUMessageFrame.h"
#import "UUInputFunctionView.h"

@interface UUBaseMessageController : BaseViewController
{
    UUInputFunctionView *IFView;
    
    NSMutableArray * _dataList;
    NSUInteger  _currentPage;
    MJRefreshIndicatorHeaderView * _head;
    UITableView * _chatTableView;
}
@property (strong, nonatomic) NSMutableArray * dataList;
@property (assign, nonatomic) NSUInteger  currentPage;
@property (strong, nonatomic) MJRefreshIndicatorHeaderView * head;
@property (strong, nonatomic) UITableView * chatTableView;

- (void) tableViewScrollToBottom;

- (void) changeTableViewFrameByInputHeightGrowing:(CGFloat)lheight;
@end
