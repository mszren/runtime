//
//  APISDK+Home.m
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HomeAPI.h"

@implementation HomeAPI
/**
 *  获取兴趣群
 *  @param keyword    搜索关键字
 *  @param sorttype    类型
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */

+ (ASIHTTPRequest*)getGroupListV6:(NSString*)keyword sorttype:(NSString*)sorttype nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{

    NSDictionary* params = @{
        @"keyword" : keyword,
        @"sorttype" : sorttype,
        @"mid" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getGroupListV6"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
/**
 *  获取通讯录
 *  @param userID     当前登录用户
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */

+ (ASIHTTPRequest*)getFamilyListNew:(NSInteger)userId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{

    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId]
    };
    return [self post:@"getFamilyListNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
/**
 *  获得朋友圈信息
 *
 *  @param userID     当前登录用户
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */
+ (ASIHTTPRequest*)getFriendsCircleNewBy:(NSInteger)userID nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"user_id" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor] };
    return [self post:@"getFriendsCircleNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取小区留言
 *
 *  @param userID         用户ID
 *  @param community_name 社区名称
 *  @param nextCursor     分页游标
 *  @param callback       回调函数
 */
+ (ASIHTTPRequest*)getNeighbourCircleInfoNew:(NSInteger)userID nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"user_id" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor],

    };

    return [self post:@"getNeighbourCircleInfoNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  点赞
 *
 *  @param user_id        用户id
 *  @param life_circle_id 生活圈内容Id
 *  @param type           类型
 *  @param callback       回调函数
 */
+ (ASIHTTPRequest*)priseLifeCircle:(NSInteger)user_id life_circle_id:(NSInteger)life_circle_id type:(NSInteger)type callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"user_id" : [NSString stringWithFormat:@"%ld", (long)user_id],
        @"life_circle_id" : [NSString stringWithFormat:@"%ld", (long)life_circle_id],
        @"type" : [NSString stringWithFormat:@"%ld", (long)type]
    };
    return [self post:@"priseLifeCircle"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取我家评论列表
 *
 *  @param comment_id 大家聊或在你家发布的信息的id
 *  @param flag        大家聊:4,我家:5
 *  @param nextCursor 分页所用1,2,3
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getNewReplyCommentList:(NSInteger)comment_id flag:(NSInteger)flag nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"comment_id" : [NSString stringWithFormat:@"%ld", (long)comment_id],
        @"flag" : [NSString stringWithFormat:@"%ld", (long)flag],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getNewReplyCommentList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  发布我家评论
 *
 *  @param user_id    用户id
 *  @param flag        类型  等于talk 为大家聊评论
 *  @param comment_id 要评论的信息id
 *  @param content    评论内容
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)replyNewComment:(NSInteger)user_id Flag:(NSString*)Flag comment_id:(NSInteger)comment_id content:(NSString*)content
                          callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)user_id],
        @"flag" : Flag,
        @"comment_id" : [NSString stringWithFormat:@"%ld", (long)comment_id],
        @"content" : content
    };
    return [self post:@"replyNewComment"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获得大家聊列表
 *
 *  @param nextCursor  分页用的
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getNewTalkList:(NSInteger)nextCursor
                         callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getNewTalkList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  大家聊点赞
 *
 *  @param talkId   信息id
 *  @param userId   点赞人id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)praiseTalk:(NSInteger)talkId userId:(NSInteger)userId
                     callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"talkId" : [NSString stringWithFormat:@"%ld", (long)talkId],
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId]
    };
    return [self post:@"praiseTalk"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  发布信息
 *
 *  @param userId    用户ID
 *  @param content   内容
 *  @param life_type 小区、亲友
 *  @param imageUrl  图片，多个以逗号隔开，并加排序，如
 *  @param callback  回调函数
 */
+ (ASIHTTPRequest*)addLifeCircleInfo:(NSInteger)userId content:(NSString*)content life_type:(NSInteger)life_type imageUrl:
                                                                                                                     (NSString*)imageUrl
                            callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"content" : content,
        @"life_type" : [NSString stringWithFormat:@"%ld", (long)life_type],
        @"imageUrl" : imageUrl
    };
    return [self post:@"addLifeCircleInfoForIOS"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  发布大家聊信息
 *
 *  @param userId    用户ID
 *  @param content   内容
 *  @param life_type 小区、亲友
 *  @param imageUrl  图片，多个以逗号隔开，并加排序，如
 *  @param callback  回调函数
 */
+ (ASIHTTPRequest*)insertTalk:(NSInteger)userId content:(NSString*)content imageUrl:
                                                                               (NSString*)imageUrl
                     callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"messageInfo" : content,
        @"imageUrl" : imageUrl
    };
    return [self post:@"insertTalkForIOS"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}


/**
 *  管理申请加入群
 *
 *  @param roomId     群ID
 *  @param roomname   群名
 *  @param roomUserId 申请人ID
 *  @param status     状态 2 同意 4 忽略
 *  @param callback   回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)ManagerRoomMember:(NSInteger)roomId roomname:(NSString*)roomname roomUserId:
(NSInteger )roomUserId status:(NSInteger)status callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"roomId" : [NSString stringWithFormat:@"%ld", (long)roomId],
                             @"roomname" : roomname,
                             @"roomUserId" : [NSString stringWithFormat:@"%ld", (long)roomUserId],
                             @"status" : [NSString stringWithFormat:@"%ld", (long)status]
                             };
    return [self post:@"user/ManagerRoomMember"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  群成员列表
 *
 *  @param name       群名
 *  @param nextCursor 分页
 *  @param callback   回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)getNewGroupMemberList:(NSString *)name nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"name" : name,
                             @"nextCursor" :[NSString stringWithFormat:@"%ld", (long)nextCursor]
                             };
    return [self post:@"getNewGroupMemberList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取获取待审核群成员列表
 *
 *  @param roomId   群ID
 *  @param callback 回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)GetAskMemberList:(NSInteger)roomId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             
                             @"userId" : [NSString stringWithFormat:@"%ld", (long)roomId]
                             };
    return [self post:@"user/GetAskMemberList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}


/**
 *  申请加入群
 *
 *  @param roomId   群ID
 *  @param reason   理由
 *  @param userId   用户ID
 *  @param callback 回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)AskForRoom:(NSInteger)roomId reason:(NSString*)reason userId:
(NSInteger)userId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"roomId" : [NSString stringWithFormat:@"%ld", (long)roomId],
                             @"reason" : reason,
                             @"userId" : [NSString stringWithFormat:@"%ld", (long)userId]
                             };
    return [self post:@"user/AskForRoom"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  群资料
 *
 *  @param name     群名
 *  @param callback 回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)getGroupInfoV6 :(NSString *)name callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"name" : name
                             };
    return [self post:@"getGroupInfoV6"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  通过手机号搜索好友
 *
 *  @param userId   用户ID
 *  @param uid      手机号
 *  @param state    状态 1
 *  @param callback 回调函数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)findFriendByPhone :(NSInteger )userId uid:(NSString *)uid state:(NSInteger)state callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
                             @"uid" : uid,
                             @"state" : [NSString stringWithFormat:@"%ld", (long)state]
                             };
    return [self post:@"getUserInfoNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  通讯录检测
 *
 *  @param userId   当前用户ID
 *  @param num      手机号 多个可拼接
 *  @param callback 回调参数
 *
 *  @return <#return value description#>
 */
+ (ASIHTTPRequest*)contactsCheckNew :(NSInteger )userId num:(NSString *)num  callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
                             @"num" : num
                             };
    return [self post:@"contactsCheckNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

@end
