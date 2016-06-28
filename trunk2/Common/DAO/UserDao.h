//
//  UserDao.h
//  EMBA
//
//  Created by caoliang on 13-8-7.
//  Copyright (c) 2013年 Beijing Qeebu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDao.h"
#import "User.h"

@interface UserDao : BaseDao


- (NSMutableArray *)selectedAllUsersList;

//根据用户名查询用户
- (User *)selectedOnlyUserByUsername:(NSString *) username;

//插入聊天用户
- (BOOL)insertWithChatUser:(User *) chatUser;

- (void)insertDicListIntoDB:(NSArray *) aDicArr;

- (BOOL) deleteAllFriends;
@end
