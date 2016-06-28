//
//  ChatHomeController.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//
#import "EGOTableView.h"

@class UserMessageDao;

@interface ChatHomeController : BaseViewController<EGOTableViewDelegate>
{
    NSMutableArray * _dataList;
    NSMutableArray * _searchDataList;
    EGOTableView * _tableView;
    
    UISearchBar * _addressSearchBar;
    UISearchDisplayController * _searchBarController;
    
    UIView * _tableHeaderView;
}


@end