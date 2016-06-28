//
//  UserService.m
//  Common
//
//  Created by Owen on 15/5/21.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UserService.h"
#import "UserTagModel.h"
#import "OrderModel.h"
#import "SystemAPI.h"
#import "PersonAPI.h"
#import "TopicModel.h"
#import "AttestationModel.h"
#import "MyCollectionModel.h"
#import "MyRedPacketModel.h"
#import "MyYaoyouModel.h"
static UserService* user;
@implementation UserService

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
    });
    return user;
}

- (ASIHTTPRequest*)LoginBy:(NSString*)username password:(NSString*)password
                 OnSuccess:(onSuccess)onSuccess
{

    return [SystemAPI loginWithUserName:username
                                    pwd:password
                               callback:^(DataModel* model) {
                                   model.data = [CurrentAccount JsonParse:[model.data objectAtIndex:0]];
                                   onSuccess(model);
                               }];
}

/**
 *  获取我的订单
 *
 *  @param userId     用户ID
 *  @param nextCursor 分页用的
 *  @param onSuccess  回调函数
 */
- (ASIHTTPRequest*)getMyOrderList:(NSInteger)userId payStatus:(NSString*)payStatus nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [PersonAPI getMyOrderList:userId
                           payStatus:payStatus
                          nextCursor:nextCursor
                            callback:^(DataModel* dataModel) {
                                if (dataModel.code == 200) {
                                    NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                    for (id data in dataModel.data) {
                                        [dataArry addObject:[OrderModel JsonParse:data]];
                                    }
                                    dataModel.data = dataArry;
                                }
                                onSuccess(dataModel);
                            }];
}

/**
 *  批量删除订单
 *
 *  @param orderNum  订单编号
 *  @param onSuccess 回调函数
 *
 *  @return <#return value description#>
 */
- (ASIHTTPRequest*)deleteMyOrder:(NSString *)orderNum  OnSuccess:(onSuccess)onSuccess{
    return [PersonAPI deleteMyOrder:orderNum callback:^(DataModel *dataModel) {
        onSuccess(dataModel);
    }];
}

/**
 *  退款详情
 *
 *  @param orderId   订单编号
 *  @param onSuccess 回调函数
 *
 *  @return <#return value description#>
 */
- (ASIHTTPRequest*)getRefundInfoByMobile:(NSString *)orderId  OnSuccess:(onSuccess)onSuccess{
    return [PersonAPI getRefundInfoByMobile:orderId callback:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            dataModel.data = [OrderModel JsonParse:[dataModel.data objectAtIndex:0]];
        }
        onSuccess(dataModel);
    }];
}

/**
 *  批量删除收藏
 *
 *  @param orderNum  收藏编号
 *  @param onSuccess 回调函数
 *
 *  @return <#return value description#>
 */
- (ASIHTTPRequest*)deleteMyCollect:(NSString *)collectId  OnSuccess:(onSuccess)onSuccess{
    return [PersonAPI deleteMyCollect:collectId callback:^(DataModel *dataModel) {
        onSuccess(dataModel);
    }];
}

/**
 *  我的互动 |
 *
 *  @param userId   用户ID
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId title:(NSString*)title nextCursor:(NSInteger)nextCursor
                                     OnSuccess:(onSuccess)onSuccess
{
    return [PersonAPI getTribeInterActionByUserId:userId
                                           typeId:typeId
                                            title:title
                                       nextCursor:nextCursor
                                         callback:^(DataModel* dataModel) {
                                             if (dataModel.code == 200) {
                                                 NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                                 for (id data in dataModel.data) {
                                                     [dataArry addObject:[TopicModel JsonParse:data]];
                                                 }
                                                 dataModel.data = dataArry;
                                             }
                                             onSuccess(dataModel);
                                         }];
}

/**
 *  申请经纪人认证
 *
 *  @param brokerName <#brokerName description#>
 *  @param cardId     <#cardId description#>
 *  @param callback   <#callback description#>
 */
- (ASIHTTPRequest*)addRecommendBrokerNew:(NSInteger)userId brokerName:(NSString*)brokerName brokerPhone:(NSString*)brokerPhone cardId:(NSString*)cardId
                               OnSuccess:(onSuccess)onSuccess
{

    return [PersonAPI addRecommendBrokerNew:userId
                                 brokerName:brokerName
                                brokerPhone:brokerPhone
                                     cardId:cardId
                                   callback:^(DataModel* dataModel) {
                                       onSuccess(dataModel);
                                   }];
}
/**
 *  我的收藏
 *
 *  @param userId     用户id
 *  @param nextCursor 分页参数
 *  @param title 检索条件
 *  @param type 检索类型（1：互动 2：活动 3：商品）
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getMyCollectList:(NSString*)title type:(NSInteger)type nextCursor:(NSInteger)nextCursor userId:(NSInteger)userId OnSuccess:(onSuccess)onSuccess
{
    return [PersonAPI getMyCollectList:title
                                  type:type
                            nextCursor:nextCursor
                                userId:userId
                              callback:^(DataModel* dataModel) {
                                  if (dataModel.code == 200) {
                                      NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                      for (id data in dataModel.data) {
                                          [dataArry addObject:[MyCollectionModel JsonParse:data]];
                                      }
                                      dataModel.data = dataArry;
                                  }
                                  onSuccess(dataModel);

                              }];
}

/**
 *  我领取的红包
 *
 *  @param userId     用户id
 *  @param nextCursor 分页参数
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getNewMyGetRedPacket:(NSInteger)userId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [PersonAPI getNewMyGetRedPacket:userId
                                nextCursor:nextCursor
                                  callback:^(DataModel* dataModel) {
                                      if (dataModel.code == 200) {
                                          NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                          for (id data in dataModel.data) {
                                              [dataArry addObject:[MyRedPacketModel JsonParse:data]];
                                          }
                                          dataModel.data = dataArry;
                                      }
                                      onSuccess(dataModel);

                                  }];
}

/**
 *  我发送的红包
 *
 *  @param userId     用户id
 *  @param nextCursor 分页参数
 *  @param callback   回调函数
 */
- (ASIHTTPRequest*)getNewMyFaSongRedPacket:(NSInteger)userId nextCursor:(NSInteger)nextCursor OnSuccess:(onSuccess)onSuccess
{
    return [PersonAPI getNewMyFaSongRedPacket:userId
                                   nextCursor:nextCursor
                                     callback:^(DataModel* dataModel) {
                                         if (dataModel.code == 200) {
                                             NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
                                             for (id data in dataModel.data) {
                                                 [dataArry addObject:[MyRedPacketModel JsonParse:data]];
                                             }
                                             dataModel.data = dataArry;
                                         }

                                         onSuccess(dataModel);

                                     }];
}

/**
 *  获取申请经纪人信息
 *
 *
 *  @param userId     userId description
 *  @param callback   <#callback description#>
 */
- (ASIHTTPRequest*)getRecommendBrokerdatailNew:(NSInteger)userId OnSuccess:(onSuccess)onSuccess
{

    return [PersonAPI getRecommendBrokerdatailNew:userId
                                         callback:^(DataModel* dataModel) {
                                             if (dataModel.code == 200) {
                                                 dataModel.data = [AttestationModel JsonParse:[dataModel.data objectAtIndex:0]];
                                             }
                                             onSuccess(dataModel);
                                         }];
}

- (ASIHTTPRequest*)getMyYaoyou:(NSInteger)userId OnSuccess:(onSuccess)onSuccess
{

    return [PersonAPI getMyYaoyou:userId
                         callback:^(DataModel* dataModel) {
                             if (dataModel.code == 200) {
                                 dataModel.data = [MyYaoyouModel JsonParse:[dataModel.data objectAtIndex:0]];
                             }
                             onSuccess(dataModel);
                         }];
}

@end
