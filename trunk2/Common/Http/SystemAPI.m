//
//  APISDK.m
//  WGOrganization
//
//  Created by chs_net on 13-5-9.
//  Copyright (c) 2013年 dean. All rights reserved.
//

#import "SystemAPI.h"
@implementation SystemAPI

/**
 *  登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)loginWithUserName:(NSString*)username pwd:(NSString*)password callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"username" : username,
        @"password" : password };
    return [self post:@"doLogin"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
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
+ (ASIHTTPRequest*)findpass:(NSString*)username num:(NSString*)num pwd:(NSString*)password callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"username" : username,
        @"num" : num,
        @"password" : password };
    return [self post:@"user/findpass"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
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
+ (ASIHTTPRequest*)userRegister:(NSString*)username pwd:(NSString*)password nickname:(NSString*)nickname num:(NSString*)num face:(NSString*)face callback:(NetConnBlock)callback
{
    NSDictionary* params = @{ @"username" : username,
        @"nickname" : nickname,
        @"face" : face,
        @"num" : num,
        @"password" : password };
    return [self post:@"register"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  获取验证码
 *
 *  @param username 用户名
 *  @param callback 回调参数
 */
+ (ASIHTTPRequest*)getNewIndentifyCode:(NSString*)username callback:(NetConnBlock)callback
{

    NSDictionary* params = @{ @"username" : username };
    return [self post:@"getNewIndentifyCode"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  找回密码获取验证码
 *
 *  @param username 用户名
 *  @param callback 回调参数
 */
+ (ASIHTTPRequest*)getResetCode:(NSString*)username callback:(NetConnBlock)callback
{
    
    NSDictionary* params = @{ @"username" : username };
    return [self post:@"user/getResetCode"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  短信验证
 *
 *  @param username  用户名
 *  @param num      验证码
 *  @param callback 回调参数
 */
+ (ASIHTTPRequest*)checkNumNew:(NSString*)username num:(NSString*)num callback:(NetConnBlock)callback
{

    NSDictionary* params = @{ @"username" : username,
        @"num" : num };
    return [self post:@"checkNumNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
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
+ (ASIHTTPRequest*)editpass:(NSInteger)userId oldpass:(NSString*)oldpass newpass:(NSString*)newpass callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"oldpass" : oldpass,
        @"newpass" : newpass
    };
    return [self post:@"/user/editpass"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
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
+ (ASIHTTPRequest*)completePersonInfoNew:(NSInteger)userId nickname:(NSString*)nickname
                                birthday:(NSString*)birthday
                                     sex:(NSString*)sex
                                    face:(NSString*)face
                                  cityId:(NSString*)cityId
                             communityId:(NSString*)communityId
                               signature:(NSString*)signature
                                 address:(NSString*)address
                                callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"nickname" : (nickname==nil)?@"" : nickname,
        @"birthday" : (birthday==nil)?@"" : birthday,
        @"sex" : (sex==nil)?@"" : sex,
        @"face" : (face==nil)?@"" : face,
        @"cityId" : (cityId==nil)?@"" : cityId,
        @"communityId" : (communityId==nil)||(communityId==NULL)?@"" : communityId,
        @"signature" : (signature==nil)?@"" : signature,
        @"address" : (address==nil)?@"" : address
    };
    return [self post:@"completePersonInfoNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}

/**
 *  搜号码
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getUserInfoNew:(NSInteger)userId uid:(NSString*)uid callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
        @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
        @"uid" : uid
    };
    return [self post:@"getUserInfoNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
/**
 *  获取城市数据
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getNewAllCityInfo:(NetConnBlock)callback
{
    NSDictionary* params = @{

    };
    return [self post:@"getNewAllCityInfo"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
/**
 *  获取小区
 *
 *  @param userId   当前用户
 *  @param uid      要查询的用户的用户名或手机号或家人号
 *  @param callback 回调函数
 */
+ (ASIHTTPRequest*)getNewAllcommunityInfo:(NetConnBlock)callback
{
    NSDictionary* params = @{};
    return [self post:@"getNewAllcommunityInfo"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
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
+ (ASIHTTPRequest*)addFamilyNew:(NSInteger)userId num:(NSString*)num callback:(NetConnBlock)callback
{
    NSDictionary* params = @{
                             @"userId" : [NSString stringWithFormat:@"%ld", (long)userId],
                             @"num" : num
                             };
    return [self post:@"addFamilyNew"
               params:params
             callback:^(DataModel* model) {
                 callback(model);
             }];
}
@end
