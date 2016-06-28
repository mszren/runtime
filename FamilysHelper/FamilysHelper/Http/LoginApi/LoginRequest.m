//
//  HTTPRequest+Login.m
//  CustomHTTP
//
//  Created by 我 on 16/3/25.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import "LoginManager.h"
#import "HTTPRequest+Private.h"

#define kBasePort @"http://demo.berui.com/"
@implementation LoginManager

+ (instancetype)shareInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

//短信验证
-(void)verifyWithPhone:(NSString *)phone responseBlock:(HTTPRequestResponseBlock)responseBlock{
    NSParameterAssert(phone.length > 0);
    
    NSDictionary *parameters = @{@"admin_mobile" : phone};
    
    [HTTPRequest post:@"VerifyCode"
           parameters:parameters
        responseBlock:^(DataModel *model) {
            responseBlock(model);
        }];
    
}

@end
