//
//  AddressBookController.h
//  qeebuConference
//
//  Created by caoliang on 13-9-24.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableView.h"
@class UserDao;

@interface AddressBookController : BaseViewController{
    UserDao *userdao;
    NSMutableDictionary * userDic;
    NSMutableArray *sortList;//按照23个字母分类
    NSMutableArray *usersArray;

    NSMutableArray *searchByName;
    
    EGOTableView * _tableView;
    UISearchBar * _addressSearchBar;
    UISearchDisplayController * _searchBarController;
    
    ASIFormDataRequest * request;
}

@property (nonatomic, assign) NSUInteger groupId;
@end