//
//  HTTPRequest+Login.h
//  CustomHTTP
//
//  Created by 我 on 16/3/25.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import "HTTPRequest+Private.h"

@interface LoginManager : HTTPRequest

+ (instancetype)shareInstance;

//短信验证
-(void)verifyWithPhone:(NSString *)phone responseBlock:(HTTPRequestResponseBlock)responseBlock;;

@end
