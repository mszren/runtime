//
//  HomeService.m
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HomeService.h"
#import "MsgModel.h"
#import "HomeAPI.h"
#import "MsgCommentModel.h"
#import "MsgListModel.h"
#import "GrounpInfoModel.h"
#import "GroupModel.h"
#import "User.h"

static HomeService* homeService;
@implementation HomeService
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeService = [[self alloc] init];
    });
    return homeService;
}

/**
 *  获取兴趣群
 *  @param keyword    搜索关键字
 *  @param sorttype    类型
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */
- (ASIHTTPRequest*)getGroupListV6:(NSString*)keyword sorttype:(NSString*)sorttype nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getGroupListV6:keyword
                          sorttype:sorttype
                        nextCursor:nextCursor
                          callback:^(DataModel* dataModel) {
                              if (dataModel.code == 200) {
                                  NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                  for (id data in dataModel.data) {
                                      [dataArry addObject:[GroupModel JsonInfoParse:data]];
                                  }
                                  dataModel.data = dataArry;
                              }
                              onSuccess(dataModel);
                          }];
}


/**
 *  获取通讯录
 *  @param userID     当前登录用户
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */

- (ASIHTTPRequest*)getFamilyListNew:(NSInteger)userId nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getFamilyListNew:userId
                          nextCursor:nextCursor
                            callback:^(DataModel* dataModel) {
                                if (dataModel.code == 200) {
                                    NSDictionary* dic = dataModel.data;
                                    //            NSMutableArray *dataArry=[[NSMutableArray alloc]initWithCapacity:0];
                                    //            for (id data in dataModel.data) {
                                    //                [dataArry addObject:[User JsonParse:data]];
                                    //            }
                                    dataModel.data = dic;
                                }
                                onSuccess(dataModel);
                            }];
}


/**
 *  获取通讯录
 *  @param userID     当前登录用户
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */
- (ASIHTTPRequest*)Addfriends:(NSInteger)userId nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getFamilyListNew:userId
                          nextCursor:nextCursor
                            callback:^(DataModel* dataModel) {
                                if (dataModel.code == 200) {
                                    
                                                NSMutableArray *dataArry=[[NSMutableArray alloc]initWithCapacity:0];
                                                for (id data in dataModel.data) {
                                                    [dataArry addObject:[User JsonParse:data]];
                                                }
                                    dataModel.data = dataArry;
                                }
                                onSuccess(dataModel);
                            }];
}

/**
 *  获得朋友圈信息
 *
 *  @param userID     当前登录用户
 *  @param nextCursor 分页用到的
 *  @param callback   <#callback description#>
 */
- (ASIHTTPRequest*)getFriendsCircleNewBy:(NSInteger)userID nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getFriendsCircleNewBy:userID
                               nextCursor:nextCursor
                                 callback:^(DataModel* dataModel) {

                                     if (dataModel.code == 200) {

                                         dataModel.data = [MsgListModel JsonParse:[dataModel.data objectAtIndex:0]];
                                     }
                                     onSuccess(dataModel);
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
- (ASIHTTPRequest*)getNeighbourCircleInfoNew:(NSInteger)userID nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getNeighbourCircleInfoNew:userID
                                   nextCursor:nextCursor
                                     callback:^(DataModel* dataModel) {
                                         if (dataModel.code == 200) {
                                             dataModel.data = [MsgListModel JsonParse:[dataModel.data objectAtIndex:0]];
                                         }
                                         onSuccess(dataModel);
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
- (ASIHTTPRequest*)priseLifeCircle:(NSInteger)user_id life_circle_id:(NSInteger)life_circle_id type:(NSInteger)type onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI priseLifeCircle:user_id
                     life_circle_id:life_circle_id
                               type:type
                           callback:^(DataModel* dataModel) {
                               onSuccess(dataModel);
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
- (ASIHTTPRequest*)getNewReplyCommentList:(NSInteger)comment_id flag:(NSInteger)flag nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess
{

    return [HomeAPI getNewReplyCommentList:comment_id
                                      flag:flag
                                nextCursor:nextCursor
                                  callback:^(DataModel* dataModel) {
                                      if (dataModel.code == 200) {
                                          NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                          for (id data in dataModel.data) {
                                              [dataArry addObject:[MsgCommentModel JsonParse:data]];
                                          }
                                          dataModel.data = dataArry;
                                      }
                                      onSuccess(dataModel);
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
- (ASIHTTPRequest*)replyNewComment:(NSInteger)user_id Flag:(NSString*)Flag comment_id:(NSInteger)comment_id content:(NSString*)content
                         onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI replyNewComment:user_id
                               Flag:Flag
                         comment_id:comment_id
                            content:content
                           callback:^(DataModel* dataModel) {
                               onSuccess(dataModel);
                           }];
}

/**
 *  获得大家聊列表
 *
 *  @param nextCursor  分页用的
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getNewTalkList:(NSInteger)nextCursor
                        onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI getNewTalkList:nextCursor
                          callback:^(DataModel* dataModel) {
                              if (dataModel.code == 200) {
                                  NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                  for (id data in dataModel.data) {
                                      [dataArry addObject:[MsgModel JsonParse:data]];
                                  }
                                  dataModel.data = dataArry;
                              }

                              onSuccess(dataModel);
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
- (ASIHTTPRequest*)addLifeCircleInfo:(NSInteger)userId content:(NSString*)content life_type:(NSInteger)life_type imageUrl:
                                                                                                                     (NSString*)imageUrl
                           onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI addLifeCircleInfo:userId
                              content:content
                            life_type:life_type
                             imageUrl:imageUrl
                             callback:^(DataModel* dataModel) {
                                 onSuccess(dataModel);
                             }];
}

/**
 *  发布大家聊信息
 *
 *  @param userId    用户ID
 *  @param content   内容
 *  @param imageUrl  图片，多个以逗号隔开，并加排序，如
 *  @param callback  回调函数
 */
- (ASIHTTPRequest*)insertTalk:(NSInteger)userId content:(NSString*)content imageUrl:
                                                                               (NSString*)imageUrl
                    onSuccess:(onSuccess)onSuccess
{
    return [HomeAPI insertTalk:userId
                       content:content
                      imageUrl:imageUrl
                      callback:^(DataModel* dataModel) {
                          onSuccess(dataModel);
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
- (ASIHTTPRequest*)ManagerRoomMember:(NSInteger)roomId roomname:(NSString*)roomname roomUserId:
(NSInteger )roomUserId status:(NSInteger)status onSuccess:(onSuccess)onSuccess{
    return [HomeAPI ManagerRoomMember:roomId roomname:roomname roomUserId:roomUserId status:status callback:^(DataModel *dataModel) {
       
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)getNewGroupMemberList:(NSString *)name nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess{
    return [HomeAPI getNewGroupMemberList:name nextCursor:nextCursor callback:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
                dataModel.data = [GrounpInfoModel JsonParse:[dataModel.data objectAtIndex:0]];
            }
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)GetAskMemberList:(NSInteger)roomId onSuccess:(onSuccess)onSuccess{
    return [HomeAPI GetAskMemberList:roomId callback:^(DataModel *dataModel) {
        
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)AskForRoom:(NSInteger)roomId reason:(NSString*)reason userId:(NSInteger)userId onSuccess:(onSuccess)onSuccess{
    return [HomeAPI AskForRoom:roomId reason:reason userId:userId callback:^(DataModel *dataModel) {
        
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)getGroupInfoV6 :(NSString *)name onSuccess:(onSuccess)onSuccess{
    return [HomeAPI getGroupInfoV6:name callback:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
            for (id data in dataModel.data) {
                [dataArry addObject:[GrounpInfoModel JsonParse:data]];
            }
            dataModel.data = dataArry;
        }
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)findFriendByPhone :(NSInteger )userId uid:(NSString *)uid state:(NSInteger)state onSuccess:(onSuccess)onSuccess{
    return [HomeAPI findFriendByPhone:userId uid:uid state:state callback:^(DataModel *dataModel) {
        
        if (dataModel.code == 200) {
            
            dataModel.data = [User JsonParse:[dataModel.data objectAtIndex:0]];
        }
        onSuccess(dataModel);
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
- (ASIHTTPRequest*)contactsCheckNew :(NSInteger )userId num:(NSString *)num  onSuccess:(onSuccess)onSuccess{
    return [HomeAPI contactsCheckNew:userId num:num callback:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            dataModel.data = [User JsonParse:[dataModel.data objectAtIndex:0]];
        }
        onSuccess(dataModel);
    }];
}
@end
