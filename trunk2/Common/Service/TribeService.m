//
//  TribeService.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeService.h"
#import "TopicModel.h"
#import "TagModel.h"
#import "TribeModel.h"
#import "TribeCategoryModel.h"
#import "BangBangAPI.h"
#import "TribeListModel.h"
#import "GoodsModel.h"
#import "MsgModel.h"
#import "ActivityModel.h"
#import "ActivityListModel.h"
#import "CommentModel.h"
#import "QDModel.h"

static TribeService* tribe;
@implementation TribeService

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tribe = [[self alloc] init];
    });
    return tribe;
}

/**
 *  根据部落ID查询该部落所关注的所有标签.
 *
 *  @param tribeId  部落ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTagsByTribeId:(NSInteger)tribeId
                          OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getTagsByTribeId:tribeId
                                callback:^(DataModel* dataModel) {
                                    NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];
                                    if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                        for (id data in dataModel.data) {
                                            [dataArray addObject:[TagModel JsonParse:data]];
                                        }
                                    }
                                    dataModel.data = dataArray;
                                    onSuccess(dataModel);
                                }];
}

/**
 *  根据用户ID查询该用户所关注的和未关注的所有标签attentionList是已关注的, noAttentionList是未关注的
 *
 *  @param userid   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTagsInterByUserID:(NSInteger)userID OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTagsByUserId:userID
                               callback:^(DataModel* dataModel) {
                                   if (dataModel.code == 200) {
                                       NSDictionary* dic = [dataModel.data objectAtIndex:0];
                                       NSArray* attentionList = [dic objectForKey:@"attentionList"];
                                       NSArray* noAttentionList = [dic objectForKey:@"noAttentionList"];
                                       NSMutableDictionary* dataArray = [[NSMutableDictionary alloc] init];
                                       NSMutableArray* myattentionList = [[NSMutableArray alloc] initWithCapacity:0];
                                       NSMutableArray* mynoAttentionList = [[NSMutableArray alloc] initWithCapacity:0];

                                       if (noAttentionList.count > 0) {
                                           for (int i = 0; i < noAttentionList.count; i++) {
                                               [mynoAttentionList addObject:[TagModel JsonParse:[noAttentionList objectAtIndex:i]]];
                                           }
                                           [dataArray setObject:mynoAttentionList forKey:@"mynoAttentionList"];
                                       }
                                       if (attentionList.count > 0) {
                                           for (int i = 0; i < attentionList.count; i++) {
                                               [myattentionList addObject:[TagModel JsonParse:[attentionList objectAtIndex:i]]];
                                           }

                                           [dataArray setObject:myattentionList forKey:@"myattentionList"];
                                       }
                                       dataModel.data = dataArray;
                                   }
                                   onSuccess(dataModel);
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
- (ASIHTTPRequest*)publishTopicWith:(NSString*)title tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId oper:(NSInteger)operId tag:(NSString*)tag images:(NSString*)images contentInfo:(NSString*)contentInfo
                          OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI publishTopicWith:title
                                 tribeId:tribeId
                                    type:typeId
                                    oper:operId
                                     tag:tag
                                  images:images
                             contentInfo:contentInfo
                                callback:^(DataModel* dataModel) {
                                    onSuccess(dataModel);
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
- (ASIHTTPRequest*)rewardTopicby:(NSInteger)objectid type:(NSInteger) typeid userID:(NSInteger)userID
                          target:(NSInteger)targetID
                           prise:(NSInteger)prise
                       OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI rewardTopicby:objectid
                                 type:typeid
                               userID:userID
                               target:targetID
                                prise:prise
                             callback:^(DataModel* dataModel) {
                                 onSuccess(dataModel);
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
- (ASIHTTPRequest*)getTagsInterby:(NSInteger)userID title:(NSString*)title nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTagsInterby:userID
                                 title:title
                            nextCursor:nextCursor
                              callback:^(DataModel* dataModel) {
                                  if (dataModel.code == 200) {
                                      NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                      if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                          for (id data in dataModel.data) {
                                              [dataArray addObject:[TopicModel JsonParse:data]];
                                          }
                                      }
                                      dataModel.data = dataArray;
                                  }

                                  onSuccess(dataModel);

                              }];
}

/**
 *  获取帮详情
 *
 *  @param shopID   部落id
 *  @param userID   用户id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTribeInfoBy:(NSInteger)shopID userID:(NSInteger)userID OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTribeInfoBy:shopID
                                userID:userID
                              callback:^(DataModel* dataModel) {
                                  if (dataModel.code == 200) {
                                      dataModel.data = [TribeModel JsonParse:[dataModel.data objectAtIndex:0]];
                                  }
                                  onSuccess(dataModel);
                              }];
}

/**
 *  获取帮互动列表
 *
 *  @param shopID   帮id
 *  @param typeID   类型Id  1互动  2活动
 *  @param callback 分页用的
 */
- (ASIHTTPRequest*)getTribeInteBy:(NSInteger)shopID typeID:(NSInteger)typeID OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTribeInteBy:shopID
                                typeID:typeID
                              callback:^(DataModel* dataModel) {
                                  if (dataModel.code == 200) {

                                      NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                      if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                          for (id data in dataModel.data) {
                                              [dataArray addObject:[TopicModel JsonParse:data]];
                                          }
                                          dataModel.data = dataArray;
                                      }
                                  }
                                  onSuccess(dataModel);

                              }];
}

/**
 *  获取帮商品
 *
 *  @param shopID    当前登录用户id
 *  @param nexCurror 可选,根据帮名搜索
 *  @param callback  分页用的
 */
- (ASIHTTPRequest*)getTribeGoodsBy:(NSInteger)shopID nexCurror:(NSInteger)nexCurror OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTribeGoodsBy:shopID
                              nexCurror:nexCurror
                               callback:^(DataModel* dataModel) {
                                   if (dataModel.code == 200) {
                                       NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                       if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                           for (id data in dataModel.data) {
                                               [dataArray addObject:[GoodsModel JsonParse:data]];
                                           }
                                       }
                                       dataModel.data = dataArray;
                                   }

                                   onSuccess(dataModel);
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
- (ASIHTTPRequest*)getMoreTribeBy:(NSString*)title userID:(NSInteger)userID nexCurror:(NSInteger)nexCurror OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getMoreTribeBy:title
                                userID:userID
                             nexCurror:nexCurror
                              callback:^(DataModel* dataModel) {
                                  if (dataModel.code == 200) {
                                      NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                      if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                          for (id data in dataModel.data) {
                                              [dataArray addObject:[TribeModel JsonParse:data]];
                                          }
                                      }
                                      dataModel.data = dataArray;
                                  }

                                  onSuccess(dataModel);
                              }];
}

/**
 *  获取某互动详情
 *
 *  @param topicID  要查询的互动的id
 *  @param typeID   类型Id  1互动  2活动
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTribeTopicDetailBy:(NSInteger)topicID typeID:(NSInteger)typeID OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTribeTopicDetailBy:topicID
                                       typeID:typeID
                                     callback:^(DataModel* dataModel) {

                                         if (dataModel.code == 200) {
                                             dataModel.data = [TopicModel JsonParse:[dataModel.data objectAtIndex:0]];
                                         }

                                         onSuccess(dataModel);
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
- (ASIHTTPRequest*)getTribeTopicBy:(NSInteger)userID typeID:(NSInteger)typeID title:(NSString*)title nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getTribeTopicBy:userID
                                 typeID:typeID
                                  title:title
                             nextCursor:nextCursor
                               callback:^(DataModel* dataModel) {

                                   NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                   if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                       for (id data in dataModel.data) {
                                           [dataArray addObject:[TopicModel JsonParse:data]];
                                       }
                                   }
                                   dataModel.data = dataArray;

                                   onSuccess(dataModel);
                               }];
}

/**
 *  互动点赞
 *
 *  @param userID    当前用户id
 *  @param objecteId 互动id
 *  @param callback  回调函数
 */
- (ASIHTTPRequest*)priseInterBy:(NSInteger)userID objecteId:(NSInteger)objecteId
                      OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI priseInterBy:userID
                           objecteId:objecteId
                            callback:^(DataModel* dataModel) {
                                onSuccess(dataModel);
                            }];
}

/**
 *  获取某互动评论回复列表
 *
 *  @param publishId  互动id
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getTribeDiscussReplyListBy:(NSInteger)publishId typeId:(NSInteger)typeId type:(NSInteger)type nextCursor:(NSInteger)nextCursor
                                    OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getTribeDiscussReplyListBy:publishId typeId:typeId type:type
                                        nextCursor:nextCursor
                                          callback:^(DataModel* dataModel) {
                                              if (dataModel.code == 200 && dataModel.data != [NSNull null]) {
                                                  dataModel.data = [TopicModel JsonParse:[dataModel.data objectAtIndex:0]];
                                              }
                                              onSuccess(dataModel);
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
- (ASIHTTPRequest*)discussInterBy:(NSInteger)userId content:(NSString*)content hudongId:(NSInteger)hudongId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId images:(NSString*)images OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI discussInterBy:userId
                               content:content
                              hudongId:hudongId
                               tribeId:tribeId
                                typeId:typeId
                                images:images
                              callback:^(DataModel* dataModel) {
                                  onSuccess(dataModel);
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
- (ASIHTTPRequest*)replyDiscussBy:(NSInteger)userId content:(NSString*)content parentId:(NSInteger)parentId tribeId:(NSInteger)tribeId typeId:(NSInteger)typeId publishId:(NSInteger)publishId images:(NSString*)images OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI replyDiscussBy:userId
                               content:content
                              parentId:parentId
                               tribeId:tribeId
                                typeId:typeId
                                publishId:publishId 
                                images:images
                              callback:^(DataModel* dataModel) {
                                  onSuccess(dataModel);
                              }];
}

/**
 *  互动置顶
 *
 *  @param topicID  当前用户要置顶的互动ID
 *  @param callback 回调代码块
 */
- (ASIHTTPRequest*)topTopicBy:(NSInteger)topicID OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI topTopicBy:topicID
                          callback:^(DataModel* dataModel) {
                              onSuccess(dataModel);
                          }];
}

/**
 *  用户添加关注标签
 *
 *  @param userID   用户Id
 *  @param tagsID   标签Id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)addUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI addUserAttentionTags:userId
                                      tagsID:tagsId
                                    callback:^(DataModel* dataModel) {
                                        onSuccess(dataModel);
                                    }];
}

/**
 *  用户取消关注标签
 *
 *  @param userId   用户Id
 *  @param tagsId   标签Id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)removeUserAttentionTags:(NSInteger)userId tagsID:(NSInteger)tagsId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI removeUserAttentionTags:userId
                                         tagsID:tagsId
                                       callback:^(DataModel* dataModel) {
                                           onSuccess(dataModel);
                                       }];
}

/**
 *  添加关注帮
 *
 *  @param userId   用户Id
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)addUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI addUserAttentionTribe:userId
                                      tribeId:tribeId
                                     callback:^(DataModel* dataModel) {
                                         onSuccess(dataModel);
                                     }];
}

/**
 * 取消帮关注
 *
 *  @param userId   用户Id
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)removeUserAttentionTribe:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI removeUserAttentionTribe:userId
                                         tribeId:tribeId
                                        callback:^(DataModel* dataModel) {
                                            onSuccess(dataModel);
                                        }];
}

/**
 *  帮成员列表
 *
 *  @param tribeId  帮Id
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTribeUserList:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getTribeUserList:tribeId
                              nextCursor:nextCursor
                                callback:^(DataModel* dataModel) {

                                    NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                    for (id data in dataModel.data) {
                                        [dataArry addObject:[User JsonParse:data]];
                                    }
                                    dataModel.data = dataArry;
                                    onSuccess(dataModel);
                                }];
}

/**
 *  我关注的帮
 *
 *  @param tribeId  帮名称（搜索用，可空）
 *  @param shopname userId ：用户Id
 *  @param callback <#callback description#>
 */
- (ASIHTTPRequest*)getAttentionTribeList:(NSInteger)userId shopname:(NSString*)shopname OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getAttentionTribeList:userId
                                     shopname:shopname
                                     callback:^(DataModel* dataModel) {

                                         if (dataModel.code == 200) {
                                             dataModel.data = [TribeListModel JsonParse:[dataModel.data objectAtIndex:0]];
                                         }
                                         onSuccess(dataModel);
                                     }];
}

/**
 *  获取用户发送的互动列表  |
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId title:(NSString*)title nextCursor:(NSInteger)nextCursor
                                     OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getTribeInterActionByUserId:userId
                                             typeId:typeId
                                              title:title
                                         nextCursor:nextCursor
                                           callback:^(DataModel* dataModel) {
                                               if (dataModel.code == 200) {
                                                   dataModel.data = [TopicModel JsonParse:[dataModel.data objectAtIndex:0]];
                                               }
                                               onSuccess(dataModel);
                                           }];
}

/**
 *  获取用户信息
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getUserInfoV2:(NSInteger)userId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getUserInfoV2:userId
                             callback:^(DataModel* dataModel) {

                                 if (dataModel.code == 200) {
                                     dataModel.data = [MsgModel JsonParse:[dataModel.data objectAtIndex:0]];
                                 }
                                 onSuccess(dataModel);
                             }];
}

/**
 *  活动列表
 *
 *  @param shopId    帮ID
 *  @param nextCursor
 *  @param onSuccess
 */
- (ASIHTTPRequest*)getBangActivityList:(NSInteger)shopId nextCursor:(NSInteger)nextCursor
                             OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getBangActivityList:shopId
                                 nextCursor:nextCursor
                                   callback:^(DataModel* dataModel) {

                                       NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                       if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                           for (id data in dataModel.data) {
                                               [dataArray addObject:[ActivityModel JsonParse:data]];
                                           }
                                       }
                                       dataModel.data = dataArray;

                                       onSuccess(dataModel);

                                   }];
}

/**
 *  活动详情
 *
 *  @param activityId 活动ID
 *  @param onSuccess  回调函数
 */
- (ASIHTTPRequest*)getBangActivityDetail:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI getBangActivityDetail:activityId
                                     callback:^(DataModel* dataModel) {

                                         if (dataModel.code == 200) {
                                             dataModel.data = [ActivityModel JsonParse:[dataModel.data objectAtIndex:0]];
                                         }
                                         onSuccess(dataModel);

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
- (ASIHTTPRequest*)addMyCollect:(NSInteger)userId type:(NSInteger)type
                       objectId:(NSInteger)objectId
                      OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI addMyCollect:userId
                                type:type
                            objectId:objectId
                            callback:^(DataModel* dataModel) {
                                onSuccess(dataModel);

                            }];
}

/**
 *  报名参加活动
 *
 *  @param userId   用户ID
 *  @param objectId 活动ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)joinBangActivity:(NSInteger)userId activityId:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI joinBangActivity:userId
                              activityId:activityId
                                callback:^(DataModel* dataModel) {
                                    onSuccess(dataModel);
                                }];
}

- (ASIHTTPRequest*)getJoinMoreList:(NSInteger)activityId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getJoinMoreList:activityId
                               callback:^(DataModel* dataModel) {
                                   if (dataModel.code == 200) {

                                       NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                       if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                           for (id data in dataModel.data) {
                                               [dataArray addObject:[ActivityListModel JsonParse:data]];
                                           }
                                       }
                                       dataModel.data = dataArray;
                                   }

                                   onSuccess(dataModel);

                               }];
}

/**
 *  获取活动评论列表
 *
 *  @param activityId 活动id
 *  @param nextCursor 分页用的
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getActivityReplyList:(NSInteger)activityId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getActivityReplyList:activityId
                                  nextCursor:nextCursor
                                    callback:^(DataModel* dataModel) {

                                        if (dataModel.code == 200) {

                                            NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];

                                            if ([dataModel.data isKindOfClass:[NSArray class]]) {
                                                for (id data in dataModel.data) {
                                                    [dataArray addObject:[CommentModel JsonParse:data]];
                                                }
                                            }
                                            dataModel.data = dataArray;
                                        }

                                        onSuccess(dataModel);

                                    }];
}

/**
 *  活动评论点赞
 *
 *  @param userId   用户ID
 *  @param objectId 对象ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)priseActivityReply:(NSInteger)userId objectId:(NSInteger)objectId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI priseActivityReply:userId
                                  objectId:objectId
                                  callback:^(DataModel* dataModel) {
                                      onSuccess(dataModel);
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
- (ASIHTTPRequest*)commentActivityReply:(NSInteger)userId replyId:(NSInteger)replyId content:(NSString*)content OnSuccess:(onSuccess)onSuccess
{

    return [BangBangAPI commentActivityReply:userId
                                     replyId:replyId
                                     content:content
                                    callback:^(DataModel* dataModel) {
                                        onSuccess(dataModel);
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
- (ASIHTTPRequest*)addInformAgainst:(NSInteger)userId objectId:(NSInteger)objectId content:(NSString*)content objectType:(NSInteger)objectType triberId:(NSInteger)triberId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI addInformAgainst:userId
                                objectId:objectId
                                 content:content
                              objectType:objectType
                                triberId:triberId
                                callback:^(DataModel* dataModel) {
                                    onSuccess(dataModel);
                                }];
}

/**
 *  帮签到规则信息
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getSignInfoA:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getSignInfoA:userId
                             tribeId:tribeId
                            callback:^(DataModel* dataModel) {
                                if (dataModel.code == 200) {
                                    dataModel.data = [QDModel JsonParse:[dataModel.data objectAtIndex:0]];
                                }

                                onSuccess(dataModel);
                            }];
}

/**
 *  帮签到
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)bangSignIn:(NSInteger)userId tribeId:(NSInteger)tribeId OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI bangSignIn:userId
                           tribeId:tribeId
                          callback:^(DataModel* dataModel) {

                              onSuccess(dataModel);
                          }];
}

/**
 *  帮签到记录
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getSignInfoB:(NSInteger)userId tribeId:(NSInteger)tribeId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI getSignInfoB:userId
                             tribeId:tribeId
                          nextCursor:nextCursor
                            callback:^(DataModel* dataModel) {

                                NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                for (id data in dataModel.data) {
                                    [dataArry addObject:[QDModel JsonParse:data]];
                                }
                                dataModel.data = dataArry;
                                onSuccess(dataModel);
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
- (ASIHTTPRequest*)publishActivityReply:(NSInteger)user_id reply_content:(NSString*)reply_content activity_id:(NSInteger)activity_id images:(NSString*)images OnSuccess:(onSuccess)onSuccess
{
    return [BangBangAPI publishActivityReply:user_id
                               reply_content:reply_content
                                 activity_id:activity_id
                                      images:images
                                    callback:^(DataModel* dataModel) {
                                        onSuccess(dataModel);

                                    }];
}

@end
