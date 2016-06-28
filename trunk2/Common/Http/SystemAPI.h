//
//  APISDK.h
//  WGOrganization
//
//  Created by chs_net on 13-5-9.
//  Copyright (c) 2013年 dean. All rights reserved.
//

#import "NetConnection.h"
@interface SystemAPI : NetConnection
//登陆
+ (ASIHTTPRequest*)loginWithUserName:(NSString*)username pwd:(NSString*)password callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)findpass:(NSString*)username num:(NSString*)num pwd:(NSString*)password callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)userRegister:(NSString*)username pwd:(NSString*)password nickname:(NSString*)nickname num:(NSString*)num face:(NSString*)face callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)editpass:(NSInteger)userId oldpass:(NSString*)oldpass newpass:(NSString*)newpass callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)completePersonInfoNew:(NSInteger)userId nickname:(NSString*)nickname
                                birthday:(NSString*)birthday
                                     sex:(NSString*)sex
                                    face:(NSString*)face
                                  cityId:(NSString*)cityId
                             communityId:(NSString*)communityId
                               signature:(NSString*)signature
                                 address:(NSString*)address
                                callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getUserInfoNew:(NSInteger)userId uid:(NSString*)uid callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getNewAllcommunityInfo:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getNewAllCityInfo:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getNewIndentifyCode:(NSString*)username callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)checkNumNew:(NSString*)username num:(NSString*)num callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getResetCode:(NSString*)username callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addFamilyNew:(NSInteger)userId num:(NSString*)num callback:(NetConnBlock)callback;
@end
