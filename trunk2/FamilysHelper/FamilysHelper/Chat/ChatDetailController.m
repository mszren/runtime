//
//  ChatDetailController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "UUMessageFrame.h"

#import "UUInputFunctionView.h"

#import "PersonController.h"
#import "ChatDetailController.h"

@interface ChatDetailController () <UUInputFunctionViewDelegate, UUMessageCellDelegate, UITableViewDataSource, UITableViewDelegate> {
}
@end

static MessageManage* messageManage = nil;
static XMPPManager* xmppManager = nil;
@implementation ChatDetailController

#pragma mark
#pragma mark--  initialize & delloc
- (id)init
{
    self = [super init];
    if (self) {
        messageManage = [MessageManage shareInstance];
        xmppManager = [XMPPManager shareInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeWhiteBackgroudView:self.currentUserModel.nickname];
//    _currentUserModel.username = [CurrentAccount currentAccount].username;
    
    [self addRefreshViews];
    [self loadBaseViewsAndData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:NSNotificationCenterNewMessageName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSendMessageStatus:) name:NSNotificationCenterSendMessageStatusName object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark--  initialize view
- (void)addRefreshViews
{
    __weak typeof(self) weakSelf = self;

    //load more
    _head = [MJRefreshIndicatorHeaderView header];
    _head.scrollView = self.chatTableView;
    _head.beginRefreshingBlock = ^(MJRefreshBaseView* refreshView) {
        weakSelf.currentPage++;

        NSMutableArray* ldata = [messageManage selectUserCacheData:weakSelf.currentUserModel withPage:weakSelf.currentPage];

        if (ldata.count > 0) {
            [weakSelf.dataList insertObjects:ldata atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, ldata.count)]];
            [UUMessageFrame changeParseToChatModel:weakSelf.dataList];

            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:ldata.count - 1 inSection:0];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.chatTableView reloadData];
                [weakSelf.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
        }

        if (ldata.count < ChatCachePerCount) {
            [weakSelf.head setNoData];
        }

        [weakSelf.head endRefreshing];
    };
}
#pragma mark
#pragma mark-- NSNotificationCenterSendMessageStatusName
- (void)changeSendMessageStatus:(NSNotification*)sender
{
    NSObject* obj = [sender object];
    if ([obj isKindOfClass:[MessageInfoModel class]]) {
        MessageInfoModel* lmessageInfoModel = (MessageInfoModel*)obj;

        NSUInteger num = _dataList.count;

        for (int i = 0; i < num; i++) {
            NSObject* temp = [_dataList objectAtIndex:i];
            if ([temp isKindOfClass:[UUMessageFrame class]]) {
                UUMessageFrame* messageFrame = (UUMessageFrame*)temp;
                if (messageFrame.messageInfoModel.msgId == lmessageInfoModel.msgId) {
                    messageFrame.messageInfoModel.state = lmessageInfoModel.state;

                    UUMessageCell* cell = (UUMessageCell*)[_chatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    if (cell) {
                        cell.stateBtn.hidden = lmessageInfoModel.state;
                    }
                }
            }
        }
    }
}

- (void)newMessage:(NSNotification*)sender
{
    NSObject* obj = [sender object];
    if ([obj isKindOfClass:[MessageInfoModel class]]) {
        MessageInfoModel* messageInfoModel = (MessageInfoModel*)obj;
        if ([messageInfoModel.toUser.username isEqualToString:_currentUserModel.username]) {
            UUMessageFrame* messageFrame = [[UUMessageFrame alloc] init];
            [messageFrame setMessageInfoModel:messageInfoModel];

            [_dataList addObject:messageFrame];

            [self.chatTableView reloadData];
            [self tableViewScrollToBottom];
            [messageManage clearUserMessageNum:_currentUserModel.username];
        }
    }
}

#pragma mark
#pragma mark-- data manage
- (void)loadBaseViewsAndData
{
    self.chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    [_dataList removeAllObjects];

    NSMutableArray* ldata = [messageManage selectUserCacheData:_currentUserModel withPage:_currentPage];
    [_dataList insertObjects:ldata atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, ldata.count)]];

    [UUMessageFrame changeParseToChatModel:_dataList];

    IFView = [[UUInputFunctionView alloc] initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];

    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark
#pragma mark-- tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (_dataList.count == 0)
        return;

    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_dataList.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark
#pragma mark--  InputFunctionViewDelegate
- (void)UUInputFunctionView:(UUInputFunctionView*)funcView sendMessage:(NSString*)message
{
    MessageInfoModel* messageInfoModel = [[MessageInfoModel alloc] initWithMessageContent:message withType:CHATINFO_NML withToUser:_currentUserModel];
    messageInfoModel.groupName = _currentUserModel.username;
    messageInfoModel.chatType = CHATTYPE_CHAT;
    messageInfoModel.groupFace = _currentUserModel.face;
    messageInfoModel.isSend = 1;
    [self sendMessage:messageInfoModel];
}

- (void)UUInputFunctionView:(UUInputFunctionView*)funcView sendPicture:(NSString*)imageUrl
{
    MessageInfoModel* messageInfoModel = [[MessageInfoModel alloc] initWithMessageContent:imageUrl withType:CHATINFO_FIL_IMG withToUser:_currentUserModel];
    messageInfoModel.groupName = _currentUserModel.username;
    messageInfoModel.chatType = CHATTYPE_CHAT;
    messageInfoModel.groupFace = _currentUserModel.face;
    messageInfoModel.isSend = 1;
    messageInfoModel.file_url = getOriginalImage(imageUrl);
    messageInfoModel.file_ext = CHAT_Image_file_ext_Name;
    [self sendMessage:messageInfoModel];
}

- (void)UUInputFunctionView:(UUInputFunctionView*)funcView sendVoice:(NSString*)messageUrl time:(NSInteger)second
{
    MessageInfoModel* messageInfoModel = [[MessageInfoModel alloc] initWithMessageContent:messageUrl withType:CHATINFO_FIL_Voice withToUser:_currentUserModel];
    messageInfoModel.groupName = _currentUserModel.username;
    messageInfoModel.chatType = CHATTYPE_CHAT;
    messageInfoModel.groupFace = _currentUserModel.face;
    messageInfoModel.isSend = 1;
    messageInfoModel.file_url = getFileURL(messageUrl);
    messageInfoModel.file_ext = CHAT_Voice_file_ext_Name;
    [self sendMessage:messageInfoModel];
}

- (void)inviteFriends:(BOOL)isAgree
{
    if (isAgree) {
        _currentUserModel.isF = 1;
        UserMessageModel* model = [[UserMessageModel alloc] init];
        model.name = _currentUserModel.username;
        model.type = CHATTYPE_CHAT;
        model.is_friends = @"1";
        [messageManage updateUserMessageIsFriend:model];
        [_chatTableView reloadData];

        MessageInfoModel* messageInfoModel = [[MessageInfoModel alloc] initWithMessageContent:@"我俩现在是好友了，现在开始聊聊天吧！" withType:CHATINFO_YFM withToUser:_currentUserModel];
        messageInfoModel.groupName = _currentUserModel.username;
        messageInfoModel.chatType = CHATTYPE_CHAT;
        [xmppManager.xmppMessageManager sendMessage:messageInfoModel];

        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:AddFriendUrl]];
        [request addPostValue:[NSNumber numberWithInteger:_currentUserModel.uid] forKey:@"id"];
        [request addPostValue:@"1" forKey:@"status"];

        [request addRequestHeader:@"X-DJT-TOKEN" value:[CurrentAccount currentAccount].token];
        [request buildRequestHeaders];

        request.delegate = self;
        request.timeOutSeconds = HTTP_TIMEOUT;
        [request setDidFinishSelector:@selector(AddFriendsRequestResult:)];
        [request setDidFailSelector:@selector(AddFriendsRequestErr:)];
        [request startAsynchronous];
    }
    else {
        UserMessageModel* model = [[UserMessageModel alloc] init];
        model.name = _currentUserModel.username;
        model.type = CHATTYPE_CHAT;
        [messageManage delChatMessageCachebyUserName:model];

        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark
#pragma mark-- ASIHTTPRequestDelegate
- (void)AddFriendsRequestResult:(ASIHTTPRequest*)aRequest
{
    NSData* data = [aRequest responseData];
    //解析json
    NSError* error = nil;
    NSDictionary* totlaDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

    NSString* errCode = [totlaDic objectForKey:@"errCode"];

    if (errCode && [errCode isEqualToString:@"000001"]) {
        [[AppDelegate shareDelegate] loadLoginController];
    }
    else if (totlaDic) {
        User* temp = [User JsonParse:totlaDic];
    }
    else {
        //TODO  用户手机号不存在，弹出短信
    }
}
- (void)AddFriendsRequestErr:(ASIHTTPRequest*)aRequest
{
}

#pragma mark
#pragma mark-- send xmpp message and deal message cache
- (void)sendMessage:(MessageInfoModel*)messageInfoModel
{
    //message cache manage
    [messageManage insertMyMessageToCache:messageInfoModel];
    
    messageInfoModel.toUser.username = [CurrentAccount currentAccount].username;
    //find insert MessageInfoModel
    MessageInfoModel* temp = [messageManage selectMessageInfoModelByMessageInfoModel:messageInfoModel];
    messageInfoModel.msgId = temp.msgId;

    [_dataList addObject:messageInfoModel];
    [UUMessageFrame changeParseToChatModel:_dataList];

    if (messageInfoModel.chatInfoType == CHATINFO_FIL_Voice) {
        messageInfoModel.content = getFileURL(messageInfoModel.content);
    }
    else if (messageInfoModel.chatInfoType == CHATINFO_FIL_IMG) {
        messageInfoModel.content = getOriginalImage(messageInfoModel.content);
    }
    else if (messageInfoModel.chatInfoType == CHATINFO_FIL_Video) {
        messageInfoModel.content = getFileURL(messageInfoModel.content);
    }
    [xmppManager.xmppMessageManager sendMessage:messageInfoModel];

    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark
#pragma mark-- tableView delegate  & datasource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* cellIdentifier = @"UUMessageCellIdentifier";
    UUMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.isFriend = _currentUserModel.isF;
    [cell setMessageFrame:_dataList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [_dataList[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.view endEditing:YES];

    [IFView hideMoreView];
}

#pragma mark
#pragma mark-- table view display
- (void)tableView:(UITableView*)ltableView didEndDisplayingCell:(UITableViewCell*)lcell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    UUMessageCell* cell = (UUMessageCell*)lcell;
    [cell cancelAllBtnImageLoad];
}
- (void)tableView:(UITableView*)ltableView willDisplayCell:(UITableViewCell*)lcell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    UUMessageCell* cell = (UUMessageCell*)lcell;
    [cell loadHeadImg:_dataList[indexPath.row]];
}

#pragma mark
#pragma mark-- UUMessageCell  cellDelegate
- (void)headImageDidClick:(UUMessageCell*)cell userId:(NSString*)userId
{
    PersonController* controller = [[PersonController alloc] init];
    if (cell.messageFrame.messageInfoModel.isSend) {
        controller.currentUser = [CurrentAccount currentAccount];
    }
    else {
        controller.currentUser = cell.messageFrame.messageInfoModel.toUser;
    }
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)messageState:(UUMessageCell*)cell withModel:(MessageInfoModel*)messageInfoModel
{
    messageInfoModel.time = [NSDate currentTimeByJava];
    messageInfoModel.groupName = _currentUserModel.nickname;
    messageInfoModel.state = SUCCESS;
    messageInfoModel.isSend = 1;

    [_dataList removeObject:cell.messageFrame];
    [messageManage updateSendMessageTime:messageInfoModel];
    [messageManage updateUserMessage:messageInfoModel];

    [_dataList addObject:messageInfoModel];
    [UUMessageFrame changeParseToChatModel:_dataList];

    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];

    [xmppManager.xmppMessageManager sendMessage:messageInfoModel];
}

@end
