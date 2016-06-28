//
//  UserMessageDao.h
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseDao.h"

@class UserMessageModel;

@interface UserMessageDao : BaseDao


//查询所有当前聊天
- (NSMutableArray *) selectCurrentList;
- (NSMutableArray *) selectSerachKeyList:(NSString *) keyStr;

//查询未读消息数目
- (long) selectbadgeNum;


//插入当前聊天数据
- (void)insertWithModel:(UserMessageModel *)aModel;

- (BOOL)deleteChatGroupCache:(NSString *) username;


- (BOOL)updateUserMessageNum:(UserMessageModel *)aModel;
- (BOOL)updateClearUserMessageNum:(NSString * )aUserMessageName;

- (BOOL)updateUserMessageIsFriend:(NSString * )aUserMessageName withIsFriends:(NSUInteger) aIsFriend;
@end

