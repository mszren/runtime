//
//  AddressBookController.m
//  qeebuConference
//  通讯录
//  Created by caoliang on 13-9-24.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import "User.h"
#import "pinyin.h"
#import "UserDao.h"
#import "ASIHTTPRequest.h"
#import "AddressBookCell.h"
#import "SearchCoreManager.h"
#import "AddressBookController.h"
#import "HomeService.h"
#import "ChatDetailController.h"
#import "AddFriendsController.h"

@interface AddressBookController ()<UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ASIHTTPRequestDelegate,EGOTableViewDelegate>
@property (nonatomic,strong) DataModel *dataModel;
@property (nonatomic,assign) BOOL isRefresh;
@end


@implementation AddressBookController
@synthesize groupId = _groupId;

#pragma mark -
#pragma mark Initialization and teardown
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        userdao = [[UserDao alloc] init];
        usersArray = [[NSMutableArray alloc] initWithCapacity:0];
        userDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        sortList = [[NSMutableArray alloc] initWithCapacity:0];
        
        searchByName = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@synthesize messageListner;
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"通讯录"];
    
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
    
    _addressSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight)];
    _addressSearchBar.delegate = self;
    _addressSearchBar.placeholder = @"搜索";
    _addressSearchBar.keyboardType = UIKeyboardAppearanceDefault;
    _addressSearchBar.barTintColor = TableSeparatorColor;
    [_addressSearchBar.layer setBorderWidth:1];
    [_addressSearchBar.layer setBorderColor:TableSeparatorColor.CGColor];
    
    _addressSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _addressSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _addressSearchBar.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = _addressSearchBar;
    
    _searchBarController = [[UISearchDisplayController alloc] initWithSearchBar:_addressSearchBar contentsController:self];
    _searchBarController.searchResultsDataSource = self;
    _searchBarController.searchResultsDelegate = self;
    _searchBarController.delegate = self;
    _searchBarController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    [_tableView reloadData];
    
    [self manageAddressBookData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self addobjectsToContentsArray];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([_addressSearchBar isFirstResponder]) {
        [_addressSearchBar resignFirstResponder];
    }
    [self clearSearchCoreData];
    [request clearDelegatesAndCancel];
    request = nil;
}

#pragma mark
#pragma mark -- nav item action
- (void)rightItemAction:(id) sender
{
    AddFriendsController * controller = [[AddFriendsController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark http request method
- (void)loadData{
    [[HomeService shareInstance] getFamilyListNew:[CurrentAccount currentAccount].uid nextCursor:_dataModel.nextCursor onSuccess:^(DataModel *dataModel) {
        if (dataModel.code==200) {
            
            if (_dataModel && !_isRefresh) {
 
                [_dataModel.data addObjectsFromArray:dataModel.data];
                _dataModel.previousCursor=dataModel.previousCursor;
                _dataModel.nextCursor=dataModel.nextCursor;
            }
            else
                _dataModel=dataModel;
            
            
            NSArray *list=_dataModel.data;
            [userdao deleteAllFriends];
            [userdao insertDicListIntoDB:list];
            [self manageAddressBookData];
            
            
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
        [_tableView tableViewDidFinishedLoading];
        
    }];
    
}

#pragma mark -
#pragma mark private Method
NSInteger nickNameSort(id user1, id user2, void *context){
    User *u1,*u2;
    //类型转换
    u1 = (User*)user1;
    u2 = (User*)user2;
    return  [u1.nickname localizedCompare:u2.nickname];
}

- (void) manageAddressBookData{
    [userDic removeAllObjects];
    [sortList removeAllObjects];
    [usersArray removeAllObjects];
    
    usersArray = [userdao selectedAllUsersList];
    
    NSString *firstStr;
    for (User *aUser in usersArray) {
        if (aUser && aUser.nickname && aUser.nickname.length>0) {
            firstStr=nil;
            firstStr = [NSString stringWithFormat:@"%c",pinyinFirstLetter([aUser.nickname characterAtIndex:0])];
            firstStr = [firstStr  uppercaseString];
            NSMutableArray *marr = (NSMutableArray *)[userDic objectForKey:firstStr];
            if (!marr) {
                marr = [[NSMutableArray alloc] initWithCapacity:0];
                [userDic setObject:marr forKey:firstStr];
            }
            [marr addObject:aUser];
        }
    }
    [sortList addObjectsFromArray:[[userDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    
}
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)ltableView{
    if (ltableView == _searchBarController.searchResultsTableView) {
        
        [searchByName removeAllObjects];
        for (User *model in usersArray) {
            if ([model.nickname rangeOfString:_addressSearchBar.text].location != NSNotFound) {
                
                [searchByName addObject:model];
            }
        }
        
        return 1;
    }else{
        return sortList.count;
    }
}
- (NSString *)tableView:(UITableView *)ltableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = [sortList objectAtIndex:section];
    return title;
}
- (CGFloat)tableView:(UITableView *)ltableView heightForHeaderInSection:(NSInteger)section{
    if (ltableView == _searchBarController.searchResultsTableView) {
        return 0.0f;
    }else{
        return 25.0;
    }
}
- (UIView *)tableView:(UITableView *)lTableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:lTableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = LightGrayColor1;
    header.layer.borderWidth = 1.0f;
    header.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 5.0, 100.0, 17.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = RedColor1;
    headerLabel.font = [UIFont systemFontOfSize:14.0];
    headerLabel.text = [sectionTitle capitalizedString];
    [header addSubview:headerLabel];
    return header;
}
- (NSInteger)tableView:(UITableView *)ltableView numberOfRowsInSection:(NSInteger)section{
    if (ltableView == _searchBarController.searchResultsTableView) {
        return searchByName.count;
    }else{
        NSString * key = [sortList objectAtIndex:section];
        NSArray * array = [userDic objectForKey:key];
        return array.count;
    }
}
- (CGFloat)tableView:(UITableView *)ltableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableChatHomeCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)ltableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * UserViewCellIdentifier = @"AddressBookCellIdentifier";
    AddressBookCell * cell = [ltableView dequeueReusableCellWithIdentifier:UserViewCellIdentifier];
    if (!cell) {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageListner = self;
        [cell setCellDefault];
    }
    if (ltableView == _searchBarController.searchResultsTableView) {
        User *model = searchByName[indexPath.row];
        [cell setCellData:model];
    }else{
        NSArray *array = [userDic objectForKey:[sortList objectAtIndex:[indexPath section]]];
        User * userModel = [array objectAtIndex:indexPath.row];
        [cell setCellData:userModel];
    }
    
    for (UIView *subview in [ltableView subviews])
    {
        if ([subview isKindOfClass:NSClassFromString(@"UITableViewIndex")]){
            [subview performSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor]];
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if([subview respondsToSelector:@selector(setIndexColor:)]){
            [subview performSelector:@selector(setIndexColor:) withObject:[UIColor lightGrayColor]];
        }
        if([subview respondsToSelector:@selector(setIndexBackgroundColor:)]){
            [subview performSelector:@selector(setIndexBackgroundColor:) withObject:[UIColor clearColor]];
        }
#pragma clang diagnostic pop
        
    }
    return cell;
}
- (void)tableView:(UITableView *)ltableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookCell * userCell = (AddressBookCell *)cell;
    [userCell cancelAllBtnImageLoad];
}
- (void)tableView:(UITableView *)ltableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookCell * userCell =(AddressBookCell *)cell;
    if (ltableView == _searchBarController.searchResultsTableView) {
        User *model = searchByName[indexPath.row];
        [userCell loadHeadImg:model];
    }else{
        NSArray *array = [userDic objectForKey:[sortList objectAtIndex:[indexPath section]]];
        User * userModel = [array objectAtIndex:indexPath.row];
        [userCell loadHeadImg:userModel];
    }
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
#pragma mark tableView section locion 定制tableView边上的定位
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return sortList;
    }
}
- (NSInteger)tableView:(UITableView *)ltableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (ltableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        if (title == UITableViewIndexSearch) {
            [ltableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else {
            return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1];
        }
    }
}

-(void)tableView:(UITableView *)ltableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    User *userModel =nil;
    if (ltableView == _searchBarController.searchResultsTableView) {
        NSNumber *localID =nil;
        if (indexPath.row<searchByName.count) {
            localID =[searchByName objectAtIndex:indexPath.row];
        }
        userModel =[usersArray objectAtIndex:[localID integerValue]];
        if (!userModel) {
            return;
        }
        
        ChatDetailController * controller = [[ChatDetailController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.currentUserModel = [userModel copy];
        controller.currentUserModel.isF = 1;
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
        NSArray *array = [userDic objectForKey:[sortList objectAtIndex:[indexPath section]]];
        userModel = [array objectAtIndex:indexPath.row];
        if (!userModel) {
            return;
        }
        ChatDetailController * controller = [[ChatDetailController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.currentUserModel = [userModel copy];
        controller.currentUserModel.isF = 1;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark 将好友添加到搜索数据记录中
-(void)addobjectsToContentsArray{
    for (int contentsArraycount = 0; contentsArraycount<[usersArray count]; contentsArraycount++)
    {
        [[SearchCoreManager share] DeleteContact:[NSNumber numberWithInt:contentsArraycount]];
    }
    [[SearchCoreManager share] Reset];
    if ([usersArray count]>0) {
        for (int i =0 ; i< [usersArray count];i++) {
            User *userModel = [usersArray objectAtIndex:i];
            NSNumber *localId = [NSNumber numberWithInt:i];
            [[SearchCoreManager share] AddContact:localId name:userModel.nickname phone:[NSArray arrayWithObject:userModel.username]];
        }
    }
}
- (void)clearSearchCoreData{
    for (int contentsArraycount = 0; contentsArraycount<[usersArray count]; contentsArraycount++) {
        [[SearchCoreManager share] DeleteContact:[NSNumber numberWithInt:contentsArraycount]];
    }
    [[SearchCoreManager share] Reset];
}

#pragma mark - UISearchBarDisplayDelegate
-(void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [_addressSearchBar setShowsScopeBar:YES];
    [_addressSearchBar setShowsCancelButton:YES animated:YES];
}
-(void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [_addressSearchBar sizeToFit];
    [_addressSearchBar setShowsScopeBar:NO];
    [_addressSearchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark -
#pragma mark UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [_addressSearchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_addressSearchBar resignFirstResponder];
    [[SearchCoreManager share] Search:searchBar.text searchArray:nil nameMatch:searchByName phoneMatch:nil];
}
- (void)searchBar:(UISearchBar *)_searchBar textDidChange:(NSString *)searchText{
    [[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:searchByName phoneMatch:nil];
}
-(void) modifyCancelButton{
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消" forState:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBorderStyle:UITextBorderStyleNone];
}

@end
