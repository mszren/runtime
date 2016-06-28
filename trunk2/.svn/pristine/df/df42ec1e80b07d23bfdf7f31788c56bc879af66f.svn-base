//
//  MessageInfoDao.h
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseDao.h"

@class MessageInfoModel;

@interface MessageInfoDao : BaseDao


- (void)insertWithModel:(MessageInfoModel *)aModel;

//查询用户聊天缓存
- (NSMutableArray *) selectUserCacheData:(User *) aUser withPage:(NSUInteger ) aPage;

- (NSMutableArray *) selectGroupCacheData:(UserMessageModel *) aUserMessageModel withPage:(NSUInteger ) aPage;

- (NSMutableArray *) selectMessageInfoModel:(MessageInfoModel *) messageInfoModel;

//del user message  info
- (BOOL)deleteUserChatGroupCache:(UserMessageModel *) aUserMessageModel;
- (BOOL)deleteGroupChatGroupCache:(UserMessageModel *) aUserMessageModel;

#pragma mark
#pragma mark -- 修改消息的属性
- (BOOL)updateSendMessageState:(MessageInfoModel *)aModel;
- (BOOL)updateSendMessageTime:(MessageInfoModel *)aModel;

@end
