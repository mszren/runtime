//
//  UserDao.m
//  EMBA
//
//  Created by caoliang on 13-8-7.
//  Copyright (c) 2013年 Beijing Qeebu Technology Co., Ltd. All rights reserved.
//

#import "User.h"
#import "UserDao.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation UserDao

#pragma mark -
#pragma mark Initialization and teardown
- (id) init{
    return [self initWithTableName:@"friends" ClassName:@"User"];
}
#pragma mark -
#pragma mark
// INSERT
- (void)insertDicListIntoDB:(NSArray *) aDicArr{
    NSUInteger num = aDicArr.count;
    User * agendaModel;
    for (int i = 0; i < num; i++) {
        NSDictionary * temp = [aDicArr objectAtIndex:i];
        agendaModel = [User JsonParse:temp];
        [self insertWithModel:agendaModel];
    }
}

// Delete
- (BOOL) deleteAllFriends{
    BOOL success = YES;
    NSString * newSql = [NSString stringWithFormat:@"DELETE FROM friends "];
    [db executeUpdate:newSql];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

- (void)insertWithModel:(User *)aUser{
    NSDictionary * values = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithInteger:aUser.uid],@"id",
                             aUser.username,@"username",
                             aUser.nickname,@"nickname",
                             aUser.face,@"face",
                             aUser.isSign,@"isSign",
                             aUser.telNumber,@"telNumber",
                             aUser.markName,@"markName",
                             nil];
    [self insertWithDictionary:values];
}

// UPDATE
- (void)updateDicListIntoDB:(NSArray *) aDicArr{
    NSUInteger num = aDicArr.count;
    User * agendaModel;
    for (int i = 0; i < num; i++) {
        NSDictionary * temp = [aDicArr objectAtIndex:i];
        agendaModel = [User JsonParse:temp];
        [self updateWithModel:agendaModel];
    }
}
- (BOOL)updateWithModel:(User *)aAgenda{
//    NSArray *values = [[NSArray alloc ] initWithObjects:aAgenda.nickName,aAgenda.mobile_no,aAgenda.email,aAgenda.position,aAgenda.avatar_o,aAgenda.avatar_s,aAgenda.company,aAgenda.weiChat,aAgenda.memo,aAgenda.comdesc,aAgenda.qq,aAgenda.weibo,[NSNumber numberWithInteger:aAgenda.groupId],[NSNumber numberWithInteger:aAgenda.uid],nil];
//    NSString *sql = @"UPDATE schoolmate SET nickName = ?,mobile_no = ?,email = ?,position = ?,avatar = ?,avatar_s = ?,company = ?,weixin = ?,memo =? ,comdesc =? , qq =?,weibo =?,groupId=? WHERE userId = ?";
//    BOOL success = [self updateWithSql:sql andArray:values];
    
    BOOL success = true;
    
    return success;
}

// DELETE
- (void)deleteDicListIntoDb:(NSArray *) aDicArr{
//    int num = aDicArr.count;
//    User * agendaModel = [[User alloc] init];
//    for (int i = 0; i < num; i++) {
//        NSDictionary * temp = [aDicArr objectAtIndex:i];
//        agendaModel.uid = [[temp objectForKey:@"uid"] integerValue];//[Agenda dicToSchedule:temp];
//        [self deleteWithModel:agendaModel];
//    }
}
- (BOOL)deleteWithModel:(User *)aAgenda{
    BOOL success = YES;
//    NSString * newSql = [NSString stringWithFormat:@"DELETE FROM schoolmate WHERE userId = ?"];
//    [db executeUpdate:newSql,[NSNumber numberWithInteger:aAgenda.uid]];
//    if ([db hadError]) {
//        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
//        success = NO;
//    }
    return success;
}


-(NSMutableArray *)selectedAllUsersList{
    NSString * newSql = [NSString stringWithFormat:@"SELECT * FROM  %@ order by username",self.tableName];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}

#pragma mark
#pragma mark -- select user info
- (User *)selectedOnlyUserByUsername:(NSString *) username
{
    NSString * newSql = [NSString stringWithFormat:@"SELECT * FROM users where name = '%@'",username];
    NSMutableArray * resultArr = [self query:newSql];
    if(resultArr.count){
        return [resultArr objectAtIndex:0];
    }else{
        return nil;
    }
}

#pragma mark
#pragma mark -- insert chat user info
- (BOOL)insertWithChatUser:(User *) chatUser{
    User * tempUser = [self selectedOnlyUserByUsername:chatUser.username];
    BOOL success = YES;
    if (tempUser) {

        NSString * newSql = [NSString stringWithFormat:@"UPDATE users SET nick = ? , face = ? WHERE name = ?"];
        [db executeUpdate:newSql, chatUser.nickname,chatUser.face,chatUser.username];

        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
        }
        return success;
    }else{
        NSString * newSql = [NSString stringWithFormat:@"insert into users(name,uid,nick,face) values('%@',%ld,'%@','%@')",chatUser.username,chatUser.uid, chatUser.nickname,chatUser.face];
        [db executeUpdate:newSql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
        }
        return success;
    }
}




@end
