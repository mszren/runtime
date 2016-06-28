//
//  UserMessageDao.m
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UserMessageDao.h"
#import "UserMessageModel.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation UserMessageDao

#pragma mark -
#pragma mark Initialization and teardown
- (id) init{
    return [self initWithTableName:@"groups" ClassName:@"UserMessageModel"];
}


#pragma mark
#pragma mark -- 查询所有当前聊天
- (NSMutableArray *) selectCurrentList
{
    NSString * newSql = [NSString stringWithFormat:@"Select * from groups order by time desc"];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}

- (NSMutableArray *) selectSerachKeyList:(NSString *) keyStr
{
    NSString * newSql = [NSString stringWithFormat:@"Select * from groups where nick like '%%%@%%' or room_nick like '%%%@%%' order by time desc",keyStr,keyStr];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}


- (long) selectbadgeNum{
    NSString * newSql = [NSString stringWithFormat:@"Select sum(num) from  groups"];
    long num = [db longForQuery:newSql];
    return num;
}


//insert
- (void)insertWithModel:(UserMessageModel *)aModel{
    UserMessageModel * temp = [self selectedOnlyUserByUsername:aModel.name];
    if (temp) {
        NSString * newSql = [NSString stringWithFormat:@"UPDATE %@ SET  nick = ?,room_nick = ? , face = ? ,content = ?,time = ? , num = num + ? ,type = ?,msg_type = ? , msg_bg = ? ,is_failure = ?,is_exit = ? , is_remind = ? ,is_friends = ?,creator = ?,position = ? WHERE name = ?",self.tableName];
        [db executeUpdate:newSql,aModel.nick, aModel.room_nick,aModel.face, aModel.content,aModel.time, [NSNumber numberWithInteger:aModel.num.integerValue],[NSNumber numberWithInteger:aModel.type] , [NSNumber numberWithInteger:aModel.msg_type],aModel.msg_bg, aModel.is_failure,aModel.is_exit, aModel.is_remind,aModel.is_friends, aModel.creator,aModel.position,aModel.name];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
    }else{
        NSMutableDictionary * values = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        aModel.name,@"name",
                                        aModel.nick,@"nick",
                                        aModel.time,@"time",
                                        nil];
        if (aModel.face) {
            [values setValue:aModel.face forKey:@"face"];
        }
        if (aModel.content) {
            [values setValue:aModel.content forKey:@"content"];
        }
        
        if (aModel.msg_bg) {
            [values setValue:aModel.msg_bg forKey:@"msg_bg"];
        }
        if (aModel.room_nick) {
            [values setValue:aModel.room_nick forKey:@"room_nick"];
        }
        if (aModel.num) {
            [values setValue:aModel.num forKey:@"num"];
        }
        [values setValue:[NSNumber numberWithInteger:aModel.type] forKey:@"type"];
        [values setValue:[NSNumber numberWithInteger:aModel.msg_type] forKey:@"msg_type"];
        if (aModel.is_failure) {
            [values setValue:aModel.is_failure forKey:@"is_failure"];
        }
        if (aModel.is_exit) {
            [values setValue:aModel.is_exit forKey:@"is_exit"];
        }
        if (aModel.is_remind) {
            [values setValue:aModel.is_remind forKey:@"is_remind"];
        }
        if (aModel.is_friends) {
            [values setValue:aModel.is_friends forKey:@"is_friends"];
        }
        if (aModel.creator) {
            [values setValue:aModel.creator forKey:@"creator"];
        }
        if (aModel.position) {
            [values setValue:aModel.position forKey:@"position"];
        }
        
        [self insertWithDictionary:values];
    }
}

#pragma mark
#pragma mark -- select user message  info
- (UserMessageModel *)selectedOnlyUserByUsername:(NSString *) username
{
    NSString * newSql = [NSString stringWithFormat:@"SELECT * FROM groups where name = '%@'",username];
    NSMutableArray * resultArr = [self query:newSql];
    if(resultArr.count){
        return [resultArr objectAtIndex:0];
    }else{
        return nil;
    }
}

- (BOOL)updateUserMessageNum:(UserMessageModel *)aModel
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set num = '%ld' where id = '%ld'",tableName,(long)aModel.num.integerValue,(long)aModel.userMessageId];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

- (BOOL)updateClearUserMessageNum:(NSString * )aUserMessageName
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set num = 0 where name = '%@'",tableName,aUserMessageName];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

- (BOOL)updateUserMessageIsFriend:(NSString * )aUserMessageName withIsFriends:(NSUInteger) aIsFriend
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set is_friends = %ld where name = '%@'",tableName,aIsFriend,aUserMessageName];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

#pragma mark
#pragma mark -- del user message  info
- (BOOL)deleteChatGroupCache:(NSString *) username
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"Delete from %@ where name = '%@'",tableName,username];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

@end
