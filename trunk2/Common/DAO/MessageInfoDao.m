//
//  MessageInfoDao.m
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MessageInfoDao.h"
#import "MessageInfoModel.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation MessageInfoDao

#pragma mark -
#pragma mark Initialization and teardown
- (id) init{
    return [self initWithTableName:@"messages" ClassName:@"MessageInfoModel"];
}


//insert
- (void)insertWithModel:(MessageInfoModel *)aModel{
    NSMutableDictionary * values = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    aModel.toUser.username,@"name",
                                    aModel.groupName,@"group_name",
                                    aModel.content,@"content",
                                    aModel.time,@"time",
                                    [NSNumber numberWithInteger:aModel.isSend],@"is_sender",
                                    [NSNumber numberWithInt:aModel.state],@"is_failure",
                                    [NSNumber numberWithInt:aModel.chatType],@"type",
                                    [NSNumber numberWithInt:aModel.chatInfoType],@"ChatType",
                                    nil];
    if (aModel.subjectStr) {
        [values setObject:aModel.subjectStr forKey:@"subject"];
    }
    [self insertWithDictionary:values];
}

//select user chat cache
- (NSMutableArray *) selectUserCacheData:(User *) aUser withPage:(NSUInteger ) aPage
{
    NSString * newSql = [NSString stringWithFormat:@"select * from (select me.*,us.nick,us.uid,us.face from messages as me left join users as us on us.name = me.name   where me.name = '%@' and me.group_name = '%@'  order by time desc limit %u,%d ) order by time asc",aUser.username,aUser.username,aPage*ChatCachePerCount,ChatCachePerCount];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}
//select group chat cache
- (NSMutableArray *) selectGroupCacheData:(UserMessageModel *) aUserMessageModel withPage:(NSUInteger ) aPage
{
    NSString * newSql = [NSString stringWithFormat:@"select * from (select me.*,us.nick,us.uid,us.face from messages as me left join users as us on us.name = me.name   where  me.group_name = '%@' order by time desc limit %u,%d) order by time asc",aUserMessageModel.name,aPage*ChatCachePerCount,ChatCachePerCount];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}

- (NSMutableArray *) selectMessageInfoModel:(MessageInfoModel *) messageInfoModel
{
    NSMutableArray * resultArr;
    if (messageInfoModel.chatType == CHATTYPE_CHAT) {
        
        NSString * newSql;
        if (messageInfoModel.toUser.username) {
            
           newSql = [NSString stringWithFormat:@"select * from %@ where  name = '%@' and group_name = '%@' and content = '%@' and time = '%@'",tableName,messageInfoModel.toUser.username,messageInfoModel.toUser.username,messageInfoModel.content,messageInfoModel.time];
        }
        else
            
             newSql = [NSString stringWithFormat:@"select * from %@ where  name = '%@' and group_name = '%@' and content = '%@' and time = '%@'",tableName,messageInfoModel.toUser.nickname,messageInfoModel.toUser.username,messageInfoModel.content,messageInfoModel.time];
        
        resultArr = [self query:newSql];
    }else{
        
        NSString * newSql;
        if (messageInfoModel.toUser.username) {
            
           newSql = [NSString stringWithFormat:@"select * from %@ where  name = '%@' and group_name = '%@' and content = '%@' and time = '%@'",tableName,messageInfoModel.toUser.username,messageInfoModel.groupName,messageInfoModel.content,messageInfoModel.time];
        }else
            newSql = [NSString stringWithFormat:@"select * from %@ where  name = '%@' and group_name = '%@' and content = '%@' and time = '%@'",tableName,messageInfoModel.toUser.nickname,messageInfoModel.groupName,messageInfoModel.content,messageInfoModel.time];
        

        resultArr = [self query:newSql];
    }
    return resultArr;
}


- (BOOL)updateSendMessageState:(MessageInfoModel *)aModel
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set is_failure = %d where id = '%d'",tableName,aModel.state,aModel.msgId];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

- (BOOL)updateSendMessageTime:(MessageInfoModel *)aModel
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set time = '%@' where id = '%d'",tableName,aModel.time,aModel.msgId];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}



#pragma mark
#pragma mark -- del user message  info
- (BOOL)deleteUserChatGroupCache:(UserMessageModel *) aUserMessageModel
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"Delete from %@ where name = '%@' and group_name = '%@' and type = %d",tableName,aUserMessageModel.name,aUserMessageModel.name,aUserMessageModel.type];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}
- (BOOL)deleteGroupChatGroupCache:(UserMessageModel *) aUserMessageModel
{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"Delete from %@ where group_name = '%@' and type = %d",tableName,aUserMessageModel.name,aUserMessageModel.type];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

@end
