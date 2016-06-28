//
//  MessageManage.m
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//


#import "UserDao.h"
#import "MessageInfoDao.h"
#import "UserMessageDao.h"

#import "MessageInfoModel.h"

#import "MessageManage.h"


@interface MessageManage()

@end

static MessageManage * messageManage;
@implementation MessageManage

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype) shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      messageManage = [[self alloc] init];
                  });
    return messageManage;
}

- (id) init{
    self = [super init];
    if (self) {
        userDao = [[UserDao alloc] init];
        messageInfoDao = [[MessageInfoDao alloc] init];
        userMessageDao = [[UserMessageDao alloc] init];
    }
    return self;
}


#pragma mark
#pragma mark -- user chat message manage
- (void) insertWithMessageCache:(MessageInfoModel *) messageInfoModel withUserMessage:(UserMessageModel *)userMessageModel
{
    if (messageInfoModel.chatType == CHATTYPE_CHAT) {
        [userDao insertWithChatUser:messageInfoModel.toUser];
        [messageInfoDao insertWithModel:messageInfoModel];
        [userMessageDao insertWithModel:userMessageModel];
    }else{
        [userDao insertWithChatUser:messageInfoModel.toUser];
        [messageInfoDao insertWithModel:messageInfoModel];
        [userMessageDao insertWithModel:userMessageModel];
    }
}

- (void) insertMyMessageToCache:(MessageInfoModel *) messageInfoModel
{
    UserMessageModel * userMessageModel = [UserMessageModel parseWithMessageInfoModel:messageInfoModel];
    userMessageModel.num = 0;
    if (messageInfoModel.chatType == CHATTYPE_CHAT) {
        [userDao insertWithChatUser:messageInfoModel.toUser];
        [messageInfoDao insertWithModel:messageInfoModel];
        [userMessageDao insertWithModel:userMessageModel];
    }else{
        [messageInfoDao insertWithModel:messageInfoModel];
        [userMessageDao insertWithModel:userMessageModel];
    }

}

- (User *) selectUserInfoByUsername:(NSString *) username
{
    return [userDao selectedOnlyUserByUsername:username];
}

- (void) updateSendMessageState:(MessageInfoModel *) messageInfoModel
{
    [messageInfoDao updateSendMessageState:messageInfoModel];
}

- (void) updateSendMessageTime:(MessageInfoModel *) messageInfoModel
{
    [messageInfoDao updateSendMessageTime:messageInfoModel];
}

- (void) updateUserMessage:(MessageInfoModel *)messageInfoModel
{
    [userMessageDao insertWithModel:[UserMessageModel parseWithMessageInfoModel:messageInfoModel]];
}

//修改未读消息数目
- (void) updateUserMessageNum:(UserMessageModel *) aUserMessageModel
{
    [userMessageDao updateUserMessageNum:aUserMessageModel];
}
- (void) clearUserMessageNum:(NSString *) aUserMessageName
{
    [userMessageDao updateClearUserMessageNum:aUserMessageName];
}

//修改是否为好友
- (void) updateUserMessageIsFriend:(UserMessageModel *) aUserMessageModel
{
    [userMessageDao  updateUserMessageIsFriend:aUserMessageModel.name withIsFriends:aUserMessageModel.is_friends.integerValue];
}

- (long) selectBadgeNum
{
    return [userMessageDao selectbadgeNum];
}
#pragma mark
#pragma mark -- user chat cache
- (NSMutableArray *) selectUserCacheData:(User *) aUser withPage:(NSUInteger ) aPage
{
    return [messageInfoDao selectUserCacheData:aUser withPage:aPage];
}

- (NSMutableArray *) selectGroupCacheData:(UserMessageModel *) aUserMessageModel withPage:(NSUInteger ) aPage{
    return [messageInfoDao selectGroupCacheData:aUserMessageModel withPage:aPage];
}

- (MessageInfoModel *) selectMessageInfoModelByMessageInfoModel:(MessageInfoModel *) messageInfoModel
{
    NSMutableArray * temp = [messageInfoDao selectMessageInfoModel:messageInfoModel];
    if (temp.count) {
        return [temp objectAtIndex:0];
    }else{
        return nil;
    }
}


#pragma mark
#pragma mark --  del 当前聊天数据
- (void) delChatMessageCachebyUserName:(UserMessageModel *) aUserMessageModel
{
    if (aUserMessageModel.type == CHATTYPE_CHAT) {
        [messageInfoDao deleteUserChatGroupCache:aUserMessageModel];
        [userMessageDao deleteChatGroupCache:aUserMessageModel.name];
    }else{
        [messageInfoDao deleteGroupChatGroupCache:aUserMessageModel];
        [userMessageDao deleteChatGroupCache:aUserMessageModel.name];
    }
}

#pragma mark
#pragma mark --  查询所有聊天的分组
- (NSMutableArray *) selectAllChatGroup{
    return [userMessageDao selectCurrentList];
}
- (NSMutableArray *) selectSearchChatGroup:(NSString *) serarchKey{
    return [userMessageDao selectSerachKeyList:serarchKey];
}

@end
