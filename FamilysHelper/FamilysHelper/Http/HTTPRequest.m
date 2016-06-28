//
//  HTTPRequest.m
//  CustomHTTP
//
//  Created by 我 on 16/3/24.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import "HTTPRequest.h"
#import "HTTPRequest+Private.h"
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
#import "NSDictionary+Null.h"
#import "NSArray+Null.h"
#import <Reachability/Reachability.h>
#import "cJSON.h"
#import "CryptFunction.h"
#import "GlobalFunction.h"
#import "JSONKit.h"

#define desKey @"newland_Iportol@lx100$#3"

NSInteger const HTTPPageSize = 20;



static NSString * const kBaseURL  = @"index.php/Hkt";    // 公网服务器
#define kBasePort @"http://demo.berui.com/"

@implementation HTTPRequest

/**
 *  判断网络连接
 *
 *  @return
 */
+ (BOOL)isNetworkReachable{
    
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    return [reach isReachable];
}

#pragma mark - Private functions

static NSString* JSONStringFromDictionary(NSDictionary *dictionary) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    return JSONStringFromData(data);
}

NSString *AppRequestManagerDefaultHTTPContentType() {
    return @"text/html;charset=utf-8";
}

static NSString* JSONStringFromData(NSData *data) {
    
    cJSON *json = cJSON_Parse(data.bytes);
    if (!json) {
        NSLog(@"parse parameter JSON string failed! response is: %s", data.bytes);
        return @"";
    }
    
    char *cstring = cJSON_Print(json);
    NSString *jsonString = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
    free(cstring);
    cJSON_Delete(json);
    
    return jsonString;
}

#pragma mark - Public functions

NSString* HTTPRequestPrivateBaseURL() {
    return [NSString stringWithFormat:@"%@%@",kBasePort,kBaseURL];
}

#pragma mark - Private methods

+ (void)startRequest:(NSString *)url
                     method:(NSString *)method
                 parameters:(NSDictionary *)parameters
                    timeout:(NSTimeInterval)timeout
              responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    NSData *bodyData;
    if(parameters != nil){
        bodyData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
        // 构造请求参数
        NSLog(@"url is: %@, request parameters are: %@", url, JSONStringFromDictionary(parameters));
        bodyData = [CryptFunction TripleDESEncrypt:bodyData WithKey:desKey];
    }
    
    /**
    *  构造requestSerializer
    */
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [requestSerializer setValue:AppRequestManagerDefaultHTTPContentType() forHTTPHeaderField:@"Content-Type" ];
    [requestSerializer setTimeoutInterval:timeout];
    NSString *nonce = [GlobalFunction generateUUID];
    NSString *timestamp = [NSString stringWithFormat:@"%llu", (long long)[NSDate date].timeIntervalSince1970];
    [requestSerializer setValue:@"zuolinyouli" forHTTPHeaderField:@"consumerKey"];
    [requestSerializer setValue:nonce forHTTPHeaderField:@"nonce"];
    [requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
                  
    NSString *encripStr = [NSString stringWithFormat:@"%@&%@", nonce, timestamp];
    NSString *signature = [CryptFunction hmacsha1:encripStr secret:@"shiyanshi2015"];
    [requestSerializer setValue:signature forHTTPHeaderField:@"signature"];
    [requestSerializer methodForSelector:_cmd];
    [requestSerializer setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    
    /**
    *  构造AFHTTPSessionManager
    */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                  
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:bodyData progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject = [CryptFunction TripleDESDecrypt:responseObject WithKey:desKey];
        
        NSLog(@"%@ response JSON is: %@", NSStringFromClass(self.class), JSONStringFromData(responseObject));
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:NULL];
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            
            dict = [dict dictionaryWithoutNull];
            
            NSString *message = dict[@"tips"];
            NSNumber *code = dict[@"status"];
            NSDictionary *data = dict[@"data"];
            
            if (responseBlock) {
                responseBlock(code.unsignedIntegerValue, message, data);
            }
        }
        else {
            if (responseBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    responseBlock(-1, @"接口返回数据格式错误！", nil);
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"request failed, error is: %@", error);
        
        if (responseBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                responseBlock(error.code, error.userInfo[@"NSLocalizedDescription"], nil);
            });
        }
    }];
}

#pragma mark - Public methods

+ (void)post:(NSString *)url
         parameters:(NSDictionary *)parameters
      responseBlock:(HTTPRequestResponseBlock)responseBlock {
    return [self post:url parameters:parameters timeout:20 responseBlock:responseBlock];
}

+ (void)post:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeout:(NSTimeInterval)timeout
      responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    [self startRequest:url
                       method:@"POST"
                   parameters:parameters
                      timeout:timeout
                responseBlock:responseBlock];
}

@end
