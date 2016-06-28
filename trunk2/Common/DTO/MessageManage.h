//
//  MessageManage.h
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//


@class UserDao;
@class MessageInfoDao;
@class UserMessageDao;



@interface MessageManage : NSObject{
    UserDao * userDao;
    MessageInfoDao * messageInfoDao;
    UserMessageDao * userMessageDao;
}

+ (instancetype) shareInstance;


//插入接收 单聊缓存
- (void) insertWithMessageCache:(MessageInfoModel *) messageInfoModel withUserMessage:(UserMessageModel *)userMessageModel;

- (void) insertMyMessageToCache:(MessageInfoModel *) messageInfoModel;

//查询聊天用户详细信息
- (User *) selectUserInfoByUsername:(NSString *) username;
- (NSMutableArray *) selectUserCacheData:(User *) aUser withPage:(NSUInteger ) aPage;
- (NSMutableArray *) selectGroupCacheData:(UserMessageModel *) aUserMessageModel withPage:(NSUInteger ) aPage;

//修改消息属性
- (void) updateSendMessageState:(MessageInfoModel *) messageInfoModel;
- (void) updateSendMessageTime:(MessageInfoModel *) messageInfoModel;
- (void) updateUserMessage:(MessageInfoModel *)messageInfoModel;

//del 当前聊天数据
- (void) delChatMessageCachebyUserName:(UserMessageModel *) aUserMessageModel;
- (MessageInfoModel *) selectMessageInfoModelByMessageInfoModel:(MessageInfoModel *) messageInfoModel;


//修改未读消息数目
- (void) updateUserMessageNum:(UserMessageModel *) aUserMessageModel;
- (void) clearUserMessageNum:(NSString *) aUserMessageName;
- (long) selectBadgeNum;


//修改是否为好友
- (void) updateUserMessageIsFriend:(UserMessageModel *) aUserMessageModel;

//查询所有聊天的分组
- (NSMutableArray *) selectAllChatGroup;
- (NSMutableArray *) selectSearchChatGroup:(NSString *) serarchKey;

@end