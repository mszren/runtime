//
//  ChatHomeController.m
//  FamilysHelper
//  消息
//  Created by 曹亮 on 15/3/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UserMessageModel.h"
#import "UserMessageDao.h"

#import "ChatHomeCell.h"
#import "ChatHomeDefaultCell.h"
#import "ChatHomeFirstCell.h"

#import "AllChatController.h"
#import "ChatHomeController.h"
#import "MyGroupsController.h"
#import "ChatDetailController.h"
#import "ChatGroupDetailController.h"
#import "InterestGroupController.h"
#import "AddressBookController.h"
#import "PersonController.h"

@interface ChatHomeController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@end

static XMPPManager* xmppManager = nil;
static MessageManage* messageManage = nil;
@implementation ChatHomeController{
    
    AllChatController *_allChatController;
}
@synthesize messageListner;

- (id)init
{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] initWithCapacity:0];
        _searchDataList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    messageManage = [MessageManage shareInstance];

    _inviteBtn.hidden = NO;

    [self initializeTableHeaderView];
    [self initializeSearchView];
    [self initializeMyView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_dataList removeAllObjects];
    _dataList = [messageManage selectAllChatGroup];
    [_tableView reloadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:NSNotificationCenterNewMessageName object:nil];
}

#pragma mark
#pragma mark-- NSNotificationCenter manager
- (void)newMessage:(id)sender
{
    //TODO 修改为分条遍历，修改文字
    [_dataList removeAllObjects];
    _dataList = [messageManage selectAllChatGroup];
    [_tableView reloadData];
}

#pragma mark
#pragma mark-- private method
- (void)initializeTableHeaderView
{
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableHeaderView.backgroundColor = [UIColor redColor];
    // AllTableViewColor;
    _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight);

    _addressSearchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    _addressSearchBar.delegate = self;
    [_addressSearchBar sizeToFit];
    _addressSearchBar.showsCancelButton = NO;
    _addressSearchBar.placeholder = @"搜索";
    _addressSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _addressSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _addressSearchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight);
    _addressSearchBar.backgroundColor = COLOR_GRAY_LIGHT;
    _addressSearchBar.keyboardType = UIKeyboardAppearanceDefault;
    _addressSearchBar.barTintColor = TableSeparatorColor;
    [_addressSearchBar.layer setBorderWidth:1];
    [_addressSearchBar.layer setBorderColor:TableSeparatorColor.CGColor];
    [_tableHeaderView addSubview:_addressSearchBar];
}
- (void)initializeSearchView
{
    _searchBarController = [[UISearchDisplayController alloc] initWithSearchBar:_addressSearchBar contentsController:self];
    _searchBarController.searchResultsDataSource = self;
    _searchBarController.searchResultsDelegate = self;
    _searchBarController.delegate = self;
    _searchBarController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
- (void)initializeMyView
{
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20 - TabBarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.tableHeaderView = _addressSearchBar;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark-- UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _searchBarController.searchResultsTableView) {
        return _searchDataList.count;
    }
    else {
        return 1 + _dataList.count;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return TableChatHomeCellHeight;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == _searchBarController.searchResultsTableView) {
        NSString* chatSearchHomeCellIdentifier = @"chatSearchHomeCellIdentifier";
        ChatHomeCell* cell = [tableView dequeueReusableCellWithIdentifier:chatSearchHomeCellIdentifier];

        if (!cell) {
            cell = [[ChatHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatSearchHomeCellIdentifier];
            [cell setViewDefault];
        }
        if (_searchDataList.count > indexPath.row) {
            UserMessageModel* model = [_searchDataList objectAtIndex:indexPath.row];
            [cell setViewData:model];
        }
        return cell;
    }
    else {
        if (indexPath.row == 0) {
            NSString* chatHomeFirstCellIdentifier = @"ChatHomeFirstCellIdentifier";
            ChatHomeFirstCell* cell = [tableView dequeueReusableCellWithIdentifier:chatHomeFirstCellIdentifier];
            if (!cell) {
                cell = [[ChatHomeFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatHomeFirstCellIdentifier];
                [cell setViewDefault];
                cell.chatHomeController = self;
                cell.messageListner = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        else {
            NSString* chatHomeCellIdentifier = @"ChatHomeCellIdentifier";
            ChatHomeCell* cell = [tableView dequeueReusableCellWithIdentifier:chatHomeCellIdentifier];

            if (!cell) {
                cell = [[ChatHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatHomeCellIdentifier];
                [cell setViewDefault];
            }
            if (_dataList.count > indexPath.row - 1) {
                UserMessageModel* model = [_dataList objectAtIndex:indexPath.row - 1];
                [cell setViewData:model];
            }
            return cell;
        }
    }
}
#pragma mark
#pragma mark-- table edit
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == _searchBarController.searchResultsTableView) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == _searchBarController.searchResultsTableView) {
    }
    else {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            UserMessageModel* model = [_dataList objectAtIndex:indexPath.row - 1];
            [messageManage delChatMessageCachebyUserName:model];

            [_dataList removeObjectAtIndex:indexPath.row - 1];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationSendChangeUNReadMessageNum object:nil];
        }
        else if (editingStyle == UITableViewCellEditingStyleInsert) {
        }
    }
}

#pragma mark
#pragma mark-- show table image
- (void)tableView:(UITableView*)ltableView didEndDisplayingCell:(UITableViewCell*)lcell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row > 1) {
        ChatHomeCell* cell = (ChatHomeCell*)lcell;
        [cell cancelAllBtnImageLoad];
    }
}
- (void)tableView:(UITableView*)ltableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    ChatHomeCell* chatHomeCell = (ChatHomeCell*)cell;
    if (ltableView == _searchBarController.searchResultsTableView) {
        UserMessageModel* model = [_searchDataList objectAtIndex:indexPath.row];
        [chatHomeCell loadHeadImg:model];
    }
    else {
        if (_dataList.count > indexPath.row - 1) {
            UserMessageModel* model = [_dataList objectAtIndex:indexPath.row - 1];
            [chatHomeCell loadHeadImg:model];
        }
    }
}

#pragma mark
#pragma mark-- UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == _searchBarController.searchResultsTableView) {
        [_addressSearchBar resignFirstResponder];
        UserMessageModel* model = [_searchDataList objectAtIndex:indexPath.row];

        if (model.type == CHATTYPE_CHAT) {
            ChatDetailController* controller = [[ChatDetailController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.currentUserModel = [messageManage selectUserInfoByUsername:model.name];
            controller.currentUserModel.isF = [model.is_friends integerValue];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else {
            ChatGroupDetailController* controller = [[ChatGroupDetailController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.currentGroupModel = model;
            [self.navigationController pushViewController:controller animated:YES];
        }
        model.num = @"0";
        [messageManage updateUserMessageNum:model];
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationSendChangeUNReadMessageNum object:nil];
    }
    else {

        if (_dataList.count > indexPath.row - 1) {
            UserMessageModel* model = [_dataList objectAtIndex:indexPath.row - 1];

            if (model.type == CHATTYPE_CHAT) {
                ChatDetailController* controller = [[ChatDetailController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                controller.currentUserModel = [messageManage selectUserInfoByUsername:model.name];
                controller.currentUserModel.isF = [model.is_friends integerValue];
                [self.navigationController pushViewController:controller animated:YES];
            }
            else {
                ChatGroupDetailController* controller = [[ChatGroupDetailController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                controller.currentGroupModel = model;
                [self.navigationController pushViewController:controller animated:YES];
            }
            model.num = @"0";
            [messageManage updateUserMessageNum:model];
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationSendChangeUNReadMessageNum object:nil];
        }
    }
}

#pragma mark - UISearchBarDisplayDelegate
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController*)controller
{
    [_addressSearchBar setShowsScopeBar:YES];
    [_addressSearchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController*)controller
{
    [_addressSearchBar sizeToFit];
    [_addressSearchBar setShowsScopeBar:NO];
    [_addressSearchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark -
#pragma mark UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
    [_addressSearchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [_addressSearchBar resignFirstResponder];
    [self searchList:searchBar.text];
}
- (void)searchBar:(UISearchBar*)_searchBar textDidChange:(NSString*)searchText
{
    [self searchList:searchText];
}
- (void)modifyCancelButton
{
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消" forState:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBorderStyle:UITextBorderStyleNone];
}

- (void)searchList:(NSString*)aStr
{
    [_searchDataList removeAllObjects];
    [_searchDataList addObjectsFromArray:[messageManage selectSearchChatGroup:aStr]];
}

@end
