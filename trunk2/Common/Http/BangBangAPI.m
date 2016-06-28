//
//  APISDK+BangBang.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangBangAPI.h"

@implementation BangBangAPI

/**
 *  根据部落ID查询该部落所关注的所有标签.
 *
 *  @param tribeId  部落ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTagsByTribeId:(NSInteger)tribeId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId] };
    return [self post:@"getTagsByTribeId"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  根据用户ID查询该用户所关注的和未关注的所有标签attentionList是已关注的, noAttentionList是未关注的
 *
 *  @param userid   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTagsByUserId:(NSInteger)userid callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"userId" : [NSString stringWithFormat:@"%ld", (long)userid] };
    return [self post:@"getTagsByUserId"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  发布互动
 *
 *  @param title       标题
 *  @param tribeId     所属部落id
 *  @param type        类型id(1:互动)
 *  @param oper        创建者id
 *  @param tag         标签
 *  @param images      图片
 *  @param contentinfo 内容
 *  @param callback    回调函数
 */
+ (ASIHTTPRequest*)publishTopicWith:(NSString*)title tribeId:(NSInteger)tribeId type:(NSInteger)type oper:(NSInteger)oper tag:(NSString*)tag images:(NSString*)images contentInfo:(NSString*)contentinfo callback:(NetConnBlock)callback

{

    NSDictionary* params = @{ @"type_id" : [NSString stringWithFormat:@"%ld", (long)type],
        @"oper_id" : [NSString stringWithFormat:@"%ld", (long)oper],
        @"tribe_id" : [NSString stringWithFormat:@"%ld", (long)tribeId],
        @"topic" : title,
        @"tags" : tag,
        @"images" : images,
        @"content_info" : contentinfo
    };
    return [self post:@"publishInterAction"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  互动打赏
 *
 *  @param objectid 要打赏的id
 *  @param typeid   类型id(1:互动,2:评论或回复)
 *  @param userID   打赏人id
 *  @param targetID 被打赏人id
 *  @param prise    打赏金额
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)rewardTopicby:(NSInteger)objectid type:(NSInteger) typeid userID:(NSInteger)userID
                          target:(NSInteger)targetID
                           prise:(NSInteger)prise
                        callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"object_id" : [NSString stringWithFormat:@"%ld", (long)objectid],
        @"type_id" : [NSString stringWithFormat:@"%ld", (long)typeid],
        @"user_id" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"target_user_id" : [NSString stringWithFormat:@"%ld", (long)targetID],
        @"tip_prise" : [NSString stringWithFormat:@"%ld", (long)prise]
    };
    return [self post:@"onlyAReward"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获得我关注的标签话题
 *
 *  @param userID     用户id
 *  @param title      互动标题（可选）
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getTagsInterby:(NSInteger)userID title:(NSString*)title nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"userId" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"title" : title,
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor] };

    return [self post:@"getTagsInterAction"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取帮详情
 *
 *  @param shopID   部落id
 *  @param userID   用户id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTribeInfoBy:(NSInteger)shopID userID:(NSInteger)userID callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"shopId" : [NSString stringWithFormat:@"%ld", (long)shopID],
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userID] };
    return [self post:@"getTribeInfo"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取帮互动列表
 *
 *  @param shopID   帮
 *  @param typeID   类型Id  1互动  2活动
 *  @param callback 分页用的
 */
+ (ASIHTTPRequest*)getTribeInteBy:(NSInteger)shopID typeID:(NSInteger)typeID callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"shopId" : [NSString stringWithFormat:@"%ld", (long)shopID],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeID] };
    return [self post:@"getTribeInterAction"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取帮商品
 *
 *  @param shopID    当前登录用户id
 *  @param nexCurror 可选,根据帮名搜索
 *  @param callback  分页用的
 */
+ (ASIHTTPRequest*)getTribeGoodsBy:(NSInteger)shopID nexCurror:(NSInteger)nexCurror callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"shopId" : [NSString stringWithFormat:@"%ld", (long)shopID],
        @"nexCurror" : [NSString stringWithFormat:@"%ld", (long)nexCurror] };
    return [self post:@"getTribeGoods"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取更多帮
 *
 *  @param title     可选,根据帮名搜索
 *  @param userID    当前登录用户id
 *  @param nexCurror 分页用的
 *  @param callback  回调函数
 */
+ (ASIHTTPRequest*)getMoreTribeBy:(NSString*)title userID:(NSInteger)userID nexCurror:(NSInteger)nexCurror callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"title" : title,
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"nexCurror" : [NSString stringWithFormat:@"%ld", (long)nexCurror]
    };
    return [self post:@"getMoreTribe"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取某互动详情
 *
 *  @param topicID  要查询的互动的id
 *  @param typeID   类型Id  1互动  2活动
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTribeTopicDetailBy:(NSInteger)topicID typeID:(NSInteger)typeID callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"id" : [NSString stringWithFormat:@"%ld", (long)topicID],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeID]
    };
    return [self post:@"getTribeInterActionDetail"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取用户发的互动列表
 *
 *  @param userID     用户id
 *  @param typeID     类型Id  1互动  2活动
 *  @param title      可选,根据互动标题搜索我关注的互动
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getTribeTopicBy:(NSInteger)userID typeID:(NSInteger)typeID title:(NSString*)title nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeID],
        @"title" : title,
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getTribeInterActionByUserId"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  互动点赞
 *
 *  @param userID    当前用户id
 *  @param objecteId 互动id
 *  @param callback  回调函数
 */
+ (ASIHTTPRequest*)priseInterBy:(NSInteger)userID objecteId:(NSInteger)objecteId
                       callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userID],
        @"objectId" : [NSString stringWithFormat:@"%ld", (long)objecteId]
    };
    return [self post:@"priseInterAction"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取某互动评论回复列表
 *
 *  @param publishId  互动id
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getTribeDiscussReplyListBy:(NSInteger)publishId typeId:(NSInteger)typeId type:(NSInteger)type nextCursor:(NSInteger)nextCursor
                                     callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"publishId" : [NSString stringWithFormat:@"%ld", (long)publishId],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeId],
        @"type" : [NSString stringWithFormat:@"%ld", (long)type],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getTribeInterActionDetail"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  评论互动
 *
 *  @param userId   评论人
 *  @param content  内容
 *  @param hudongId 互动ID
 *  @param tribeId  所属部落id
 *  @param typeId   1评论互动  2回复互动  3评论活动  4回复活动
 *  @param callback 回调代码块
 */
+ (ASIHTTPRequest*)discussInterBy:(NSInteger)userId content:(NSString*)content hudongId:(NSInteger)hudongId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId images:(NSString*)images callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"content" : content,
        @"hudongId" : [NSString stringWithFormat:@"%ld", (long)hudongId],
        @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeId],
        @"images" : images
    };
    return [self post:@"discussInterAction"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  回复评论
 *
 *  @param userId   评论人
 *  @param content  内容
 *  @param parentId 回复的是哪个评论(评论id)
 *  @param tribeId  所属部落id
 *  @param typeId   1评论互动  2回复互动  3评论活动  4回复活动
 *  @param callback  回调代码块
 */
+ (ASIHTTPRequest*)replyDiscussBy:(NSInteger)userId content:(NSString*)content parentId:(NSInteger)parentId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId publishId:(NSInteger)publishId images:(NSString*)images callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"content" : content,
        @"parentId" : [NSString stringWithFormat:@"%ld", (long)parentId],
        @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeId],
        @"publishId" : [NSString stringWithFormat:@"%ld", (long)publishId],
        @"images" : images
    };
    return [self post:@"replyDiscuss"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  互动置顶
 *
 *  @param topicID  当前用户要置顶的互动ID
 *  @param callback 回调代码块
 */
+ (ASIHTTPRequest*)topTopicBy:(NSInteger)topicID callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"topicID" : [NSString stringWithFormat:@"%ld", (long)topicID],
        @"flag" : @"interAction"
    };
    return [self post:@"interActionTopsApp"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  用户添加关注标签
 *
 *  @param userID   用户Id
 *  @param tagsID   标签Id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)addUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"tagsId" : [NSString stringWithFormat:@"%ld", (long)tagsId]
    };
    return [self post:@"addUserAttentionTags"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  用户取消关注标签
 *
 *  @param userId   用户Id
 *  @param tagsId   标签Id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)removeUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"tagsId" : [NSString stringWithFormat:@"%ld", (long)tagsId]
    };
    return [self post:@"removeUserAttentionTags"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  添加关注帮
 *
 *  @param userId   用户Id
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)addUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId]
    };
    return [self post:@"addUserAttentionTribe"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  取消关注帮
 *
 *  @param userId   用户Id
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)removeUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId]
    };
    return [self post:@"removeUserAttentionTribe"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  帮成员列表
 *
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTribeUserList:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"tribeId" : [NSString stringWithFormat:@"%ld", (long)tribeId],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };

    return [self post:@"getTribeUserList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  我关注的帮
 *
 *  @param tribeId  帮名称（搜索用，可空）
 *  @param shopname userId ：用户Id
 *  @param callback <#callback description#>
 */
+ (ASIHTTPRequest*)getAttentionTribeList:(NSInteger)userId shopname:(NSString*)shopname callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"shopname" : shopname
    };
    return [self post:@"getAttentionTribeList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取用户发送的互动列表  |
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId
                                         title:(NSString*)title
                                    nextCursor:(NSInteger)nextCursor
                                      callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"typeId" : [NSString stringWithFormat:@"%ld", (long)typeId],
        @"title" : title,
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getTribeInterActionByUserId"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取用户信息
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getUserInfoV2:(NSInteger)userId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId]
    };
    return [self post:@"getUserInfoV2"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  帮签到规则信息
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getSignInfoA:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"bangId" : [NSString stringWithFormat:@"%ld", (long)tribeId],
    };
    return [self post:@"getSignInfoA"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  帮签到
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)bangSignIn:(NSInteger)userId tribeId:(NSInteger)tribeId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"bangId" : [NSString stringWithFormat:@"%ld", (long)tribeId],

    };
    return [self post:@"bangSignIn"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  帮签到记录
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getSignInfoB:(NSInteger)userId tribeId:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"bangId" : [NSString stringWithFormat:@"%ld", (long)tribeId],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getSignInfoB"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取帮活动列表
 *
 *  @param shopId     帮
 *  @param nextCursor  分页
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getBangActivityList:(NSInteger)shopId nextCursor:(NSInteger)nextCursor
                              callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"shopId" : [NSString stringWithFormat:@"%ld", (long)shopId],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getBangActivityList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  活动详情
 *
 *  @param activityId 活动ID
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getBangActivityDetail:(NSInteger)activityId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"activityId" : [NSString stringWithFormat:@"%ld", (long)activityId]
    };
    return [self post:@"getBangActivityDetail"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  添加收藏
 *
 *  @param userId   用户ID
 *  @param type     类型（1：互动 2：活动 3：商品）
 *  @param objectId 对象ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)addMyCollect:(NSInteger)userId type:(NSInteger)type
                       objectId:(NSInteger)objectId
                       callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"type" : [NSString stringWithFormat:@"%ld", (long)type],
        @"objectId" : [NSString stringWithFormat:@"%ld", (long)objectId]
    };
    return [self post:@"addMyCollect"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  报名参加活动
 *
 *  @param userId   用户ID
 *  @param objectId 活动ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)joinBangActivity:(NSInteger)userId activityId:(NSInteger)activityId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"activityId" : [NSString stringWithFormat:@"%ld", (long)activityId]
    };
    return [self post:@"joinBangActivity"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  .	帮活动详情查看更多参与人信息
 *
 *  @param activityId 活动ID
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getJoinMoreList:(NSInteger)activityId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"activityId" : [NSString stringWithFormat:@"%ld", (long)activityId]
    };
    return [self post:@"getJoinMoreList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取活动评论列表
 *
 *  @param activityId 活动id
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)getActivityReplyList:(NSInteger)activityId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"activityId" : [NSString stringWithFormat:@"%ld", (long)activityId],
        @"nextCursor" : [NSString stringWithFormat:@"%ld", (long)nextCursor]
    };
    return [self post:@"getActivityReplyList"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  活动评论点赞
 *
 *  @param userId   用户ID
 *  @param objectId 对象ID
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)priseActivityReply:(NSInteger)userId objectId:(NSInteger)objectId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"objectId" : [NSString stringWithFormat:@"%ld", (long)objectId]
    };
    return [self post:@"priseActivityReply"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  28.	活动评论回复
 *
 *  @param userId   用户ID
 *  @param objectId 对象ID
 *  @param content 回复内容
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)commentActivityReply:(NSInteger)userId replyId:(NSInteger)replyId content:(NSString*)content callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"replyId" : [NSString stringWithFormat:@"%ld", (long)replyId],
        @"content" : content
    };
    return [self post:@"commentActivityReply"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  举报
 *
 *  @param userId     举报人ID
 *  @param objectId   对象ID
 *  @param content    举报原因
 *  @param objectType 举报内容类型（1：互动 2：活动 3：商品）
 *  @param triberId   帮ID
 *  @param callback   回调函数
 */
+ (ASIHTTPRequest*)addInformAgainst:(NSInteger)userId objectId:(NSInteger)objectId content:(NSString*)content objectType:(NSInteger)objectType triberId:(NSInteger)triberId callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"objectId" : [NSString stringWithFormat:@"%ld", (long)objectId],
        @"content" : content,
        @"objectType" : [NSString stringWithFormat:@"%ld", (long)objectType],
        @"triberId" : [NSString stringWithFormat:@"%ld", (long)triberId]
    };
    return [self post:@"addInformAgainst"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  活动发布评论
 *
 *  @param user_id       用户ID
 *  @param reply_content 评论内容
 *  @param activity_id   评论活动ID
 *  @param images        评论图片
 *  @param callback      回调函数
 */
+ (ASIHTTPRequest*)publishActivityReply:(NSInteger)user_id reply_content:(NSString*)reply_content activity_id:(NSInteger)activity_id images:(NSString*)images callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"user_id" : [NSString stringWithFormat:@"%ld", (long)user_id],
        @"reply_content" : reply_content,
        @"activity_id" : [NSString stringWithFormat:@"%ld", (long)activity_id],
        @"images" : images
    };
    return [self post:@"publishActivityReply"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
@end
