//
//  SystemService.m
//  Common
//
//  Created by shenbinbin on 15/6/19.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SystemService.h"
#import "SystemAPI.h"
#import "CityModel.h"
#import "CommunityModel.h"
static SystemService* systemService;
@implementation SystemService
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemService = [[self alloc] init];
    });
    return systemService;
}

/**
 *  登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)loginWithUserName:(NSString*)username pwd:(NSString*)password onSuccess:(onSuccess)onSuccess
{

    return [SystemAPI loginWithUserName:username
                                    pwd:password
                               callback:^(DataModel* dataModel) {
                                   if (dataModel.code == 200) {
                                   }
                                   onSuccess(dataModel);
                               }];
}

/**
 *  找回密码
 *
 *  @param username 用户名
 *  @param num      验证码
 *  @param password 密码
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)findpass:(NSString*)username num:(NSString*)num pwd:(NSString*)password onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI findpass:username
                           num:num
                           pwd:password
                      callback:^(DataModel* dataModel) {

                          if (dataModel.code == 202) {
                          }
                          onSuccess(dataModel);
                      }];
}

/**
 *  用户注册
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param nickname 昵称
 *  @param num      验证码
 *  @param face     头像地址
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)userRegister:(NSString*)username pwd:(NSString*)password nickname:(NSString*)nickname num:(NSString*)num face:(NSString*)face onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI userRegister:username
                               pwd:password
                          nickname:nickname
                               num:num
                              face:face
                          callback:^(DataModel* dataModel) {
                              if (dataModel.code == 202) {
                              }
                              onSuccess(dataModel);
                          }];
}

/**
 *  获取验证码
 *
 *  @param username 用户名
 *  @param callback 回调参数
 */
- (ASIHTTPRequest*)getNewIndentifyCode:(NSString*)username onSuccess:(onSuccess)onSuccess
{

    return [SystemAPI getNewIndentifyCode:username
                                 callback:^(DataModel* dataModel) {

                                     onSuccess(dataModel);
                                 }];
}

/**
 *  重置密码获取验证码
 *
 *  @param username 用户名
 *  @param callback 回调参数
 */
- (ASIHTTPRequest*)getResetCode:(NSString*)username onSuccess:(onSuccess)onSuccess{
    return [SystemAPI getResetCode:username callback:^(DataModel *dataModel) {
        onSuccess(dataModel);
    }];
}

/**
 *  短信验证
 *
 *  @param username  用户名
 *  @param num      验证码
 *  @param callback 回调参数
 
 */
- (ASIHTTPRequest*)checkNumNew:(NSString*)username num:(NSString*)num onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI checkNumNew:username
                              num:num
                         callback:^(DataModel* dataModel) {

                             onSuccess(dataModel);
                         }];
}

/**
 *  修改密码
 *
 *  @param userId   用户ID
 *  @param oldpass  旧密码
 *  @param newpass  新密码
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)editpass:(NSInteger)userId oldpass:(NSString*)oldpass newpass:(NSString*)newpass onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI editpass:userId
                       oldpass:oldpass
                       newpass:newpass
                      callback:^(DataModel* dataModel) {

                          onSuccess(dataModel);
                      }];
}

/**
 *  个人资料保存
 *
 *  @param userId      用户ID
 *  @param nickname    用户昵称
 *  @param birthday    生日
 *  @param sex         性别
 *  @param face        头像
 *  @param cityId      城市ID
 *  @param communityId 小区ID
 *  @param signature   签名
 *  @param address     地址
 *  @param callback    回调函数
 */
- (ASIHTTPRequest*)completePersonInfoNew:(NSInteger)userId
                                nickname:(NSString*)nickname
                                birthday:(NSString*)birthday
                                     sex:(NSString*)sex
                                    face:(NSString*)face
                                  cityId:(NSString*)cityId
                             communityId:(NSString*)communityId
                               signature:(NSString*)signature
                                 address:(NSString*)address
                               onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI completePersonInfoNew:userId
                                   nickname:nickname
                                   birthday:birthday
                                        sex:sex
                                       face:face
                                     cityId:cityId
                                communityId:communityId
                                  signature:signature
                                    address:address
                                   callback:^(DataModel* dataModel) {

                                       onSuccess(dataModel);
                                   }];
}

/**
 *  搜号码
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getUserInfoNew:(NSInteger)userId uid:(NSString*)uid onSuccess:(onSuccess)onSuccess
{
    return [SystemAPI getUserInfoNew:userId
                                 uid:uid
                            callback:^(DataModel* dataModel) {
                                if (dataModel.code == 200) {

                                    dataModel.data = [User JsonParse:[dataModel.data objectAtIndex:0]];
                                }
                                onSuccess(dataModel);
                            }];
}
/**
 *  获取小区数据
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getNewAllcommunityInfo:(onSuccess)onSuccess
{
    return [SystemAPI getNewAllcommunityInfo:^(DataModel* dataModel) {
        if (dataModel.code == 200) {
            NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
            for (id dic in dataModel.data) {

                [dataArry addObject:[CommunityModel JsonParse:dic]];
            }
            dataModel.data = dataArry;
        }
        onSuccess(dataModel);
    }];
}
/**
 *  获取城市数据
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
- (ASIHTTPRequest*)getNewAllCityInfo:(onSuccess)onSuccess
{
    return [SystemAPI getNewAllCityInfo:^(DataModel* dataModel) {
        if (dataModel.code == 200) {
            NSMutableArray* dataArry = [[NSMutableArray alloc] initWithCapacity:0];
            for (id data in dataModel.data) {
                [dataArry addObject:[CityModel JsonParse:data]];
            }
            dataModel.data = dataArry;
        }
        onSuccess(dataModel);
    }];
}

/**
 *  添加好友
 *
 *  @param userId   当前用户ID
 *  @param num      要添加好友的手机号
 *  @param callback 回调参数
 *
 *  @return <#return value description#>
 */
- (ASIHTTPRequest*)addFamilyNew:(NSInteger)userId num:(NSString*)num onSuccess:(onSuccess)onSuccess{
    return [SystemAPI addFamilyNew:userId num:num callback:^(DataModel *dataModel) {
        
        onSuccess(dataModel);
    }];
}
@end
