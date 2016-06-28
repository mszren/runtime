//
//  NetConnection.h
//  SDK
//
//  Created by xuanqiang on 11/07/12.
//  Copyright (c) 2012年 Ecpalm. All rights reserved.
//
#import "NetConnection.h"
#import "Reachability.h"
#import "DataModel.h"

@implementation NetConnection

+ (BOOL)isNetworkReachable
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    return [reach isReachable];
}

+ (NSString*)generateParameterString:(NSDictionary*)parameter
{
    NSMutableString* result = [[NSMutableString alloc] init];
    int i = 0;
    for (NSString* key in parameter) {
        NSString* value = [parameter objectForKey:key];
        if (value != nil || [value isEqualToString:@""]) {
            if (i == 0) {
                [result appendString:@"/"];
            }
            else {
                [result appendString:@"/"];
            }
            i++;
            [result appendFormat:@"%@/%@", key, value];
        }
    }
    
    return result;
}

+ (void)generateBodyDic:(NSMutableDictionary*)bodyDic
                paraKey:(NSString*)key
              paraValue:(NSString*)value
{
    if (value != nil) {
        [bodyDic setObject:value forKey:key];
    }
}

+ (void)returnFail:(NetConnBlock)callback
        failedCall:(NetConnFailedBlock)failedCall
{
    NSString* error = @"请求失败，请稍后再试！";
    DataModel* model = [[DataModel alloc] init];
    model.code = 10000;
    model.error = error;
    callback(model);
}

+ (ASIHTTPRequest*)get:(NSString*)urlString
                params:(NSDictionary*)params
              callback:(NetConnBlock)callback
{
    return [self get:urlString params:params callback:callback failedCall:nil];
}

+ (ASIHTTPRequest*)get:(NSString*)urlString
                params:(NSDictionary*)params
              callback:(NetConnBlock)callback
            failedCall:(NetConnFailedBlock)failedCall
{
    NSString* requstURL =
        [NSString stringWithFormat:@"%@ibsApp/ibs/%@%@", JAVA_API, urlString,
                  [self generateParameterString:params]];
    NSLog(@"url:%@", requstURL);
    if (![self isNetworkReachable]) {
        [self returnFail:callback failedCall:failedCall];
        return nil;
    }
    NSURL* url = [[NSURL alloc] initWithString:requstURL];
    __block ASIHTTPRequest* request = [[ASIHTTPRequest alloc] initWithURL:url];
    //    UserAccount *user =[UserAccount currentAccount];
    //    if (user.token) {
    //        [request addRequestHeader:@"X-DJT-TOKEN" value:user.token];
    //    }else
    //    {
    //        [request addRequestHeader:@"X-DJT-TOKEN" value:@""];
    //
    //    }
    __unsafe_unretained ASIHTTPRequest* weakRequest = request;
    [request setShouldAttemptPersistentConnection:NO];
    [request setCompletionBlock:^{
        NSData* data = [weakRequest responseData];
        NSString* str =
            [[NSString alloc] initWithData:data
                                  encoding:NSUTF8StringEncoding];
        NSLog(@"Server responseString: %@", str);
        NSError* error = nil;
        NSDictionary* dicData =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableLeaves
                                              error:&error];

        DataModel* model = [[DataModel alloc] initWithDictionary:dicData];

        if (callback) {
            callback(model);
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"request failed:%@", [weakRequest responseString]);
        NSString* error = @"请求失败，请稍后再试！";
        DataModel* model = [[DataModel alloc] init];
        model.code = 10000;
        model.error = error;
        callback(model);
    }];
    [request startAsynchronous];
    return request;
}

+ (ASIHTTPRequest*)post:(NSString*)urlString
                 params:(NSDictionary*)params
               callback:(NetConnBlock)callback
{
    return
        [self post:urlString
                   params:params
            requestBefore:nil
                 callback:callback];
}
+ (ASIHTTPRequest*)post:(NSString*)urlString
                 params:(NSDictionary*)params
               callback:(NetConnBlock)callback
             failedCall:(NetConnFailedBlock)failedCall
{
    return [self post:urlString
               params:params
        requestBefore:nil
             callback:callback
           failedCall:failedCall];
}
+ (ASIHTTPRequest*)postUTF8:(NSString*)urlString
                     params:(NSDictionary*)params
                   callback:(NetConnBlock)callback
                 failedCall:(NetConnFailedBlock)failedCall
{
    return [self post:urlString
               params:params
        requestBefore:nil
             callback:callback
           failedCall:failedCall
             encoding:NSUTF8StringEncoding];
}

+ (ASIHTTPRequest*)post:(NSString*)urlString
                 params:(NSDictionary*)params
          requestBefore:(NetConnFormRequestBlock)requestBefore
               callback:(NetConnBlock)callback
{
    return [self post:urlString
               params:params
        requestBefore:requestBefore
             callback:callback
           failedCall:nil];
}

+ (ASIHTTPRequest*)post:(NSString*)urlString
                 params:(NSDictionary*)params
          requestBefore:(NetConnFormRequestBlock)requestBefore
               callback:(NetConnBlock)callback
             failedCall:(NetConnFailedBlock)failedCall
               encoding:(NSStringEncoding)encoding
{

    NSString* requstURL =
        [NSString stringWithFormat:@"%@ibsApp/ibs/%@", JAVA_API, urlString];
    NSLog(@"requstURL  %@", requstURL);
    if (![self isNetworkReachable]) {
        DataModel* model = [[DataModel alloc] init];
        model.code = 800;
        model.error = @"世界上最遥远的距离就是没网。请检查网络！";
        callback(model);
        return nil;
    }

    NSURL* url = [[NSURL alloc] initWithString:requstURL];
    __block ASIFormDataRequest* request =
        [[ASIFormDataRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    for (id key in params) {
        id value = [params objectForKey:key];
        [request addPostValue:value forKey:key];
        NSLog(@"paramer key:%@ => value:%@", key, value);
    }
    //    UserAccount *user =[UserAccount currentAccount];
    //    if (user.token) {
    //        [request addRequestHeader:@"X-DJT-TOKEN" value:user.token];
    //
    //    }else
    //    {
    //        [request addRequestHeader:@"X-DJT-TOKEN" value:@""];
    //
    //    }

    if (requestBefore) {
        requestBefore(request);
    }
    __unsafe_unretained ASIHTTPRequest* weakRequest = request;
    if (encoding != -1) {
        weakRequest.defaultResponseEncoding = encoding;
    }
    [request setCompletionBlock:^{
        if (weakRequest.responseStatusCode == 200) {
            NSData* data = [weakRequest responseData];
            NSString* str =
                [[NSString alloc] initWithData:data
                                      encoding:NSUTF8StringEncoding];
            NSLog(@"Server responseString: %@", str);
            NSError* error = nil;
            NSDictionary* dicData =
                [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
            DataModel* model = [[DataModel alloc] initWithDictionary:dicData];
            if (callback) {
                callback(model);
            }
        }

    }];
    [request setFailedBlock:^{
        NSError* err = weakRequest.error;
        DataModel* model = [[DataModel alloc] init];
        model.code = err.code;
        model.error = err.description;
        NSLog(@"request failed:%@,%@", err.description, err.debugDescription);
        NSLog(@"responseString:%@", [weakRequest responseString]);
        callback(model);
    }];
    [request startAsynchronous];
    return request;
}

+ (ASIHTTPRequest*)post:(NSString*)urlString
                 params:(NSDictionary*)params
          requestBefore:(NetConnFormRequestBlock)requestBefore
               callback:(NetConnBlock)callback
             failedCall:(NetConnFailedBlock)failedCall
{
    return [self post:urlString
               params:params
        requestBefore:requestBefore
             callback:callback
           failedCall:failedCall
             encoding:-1];
}

+ (NSString*)UnicodeToISO88591:(NSString*)src
{

    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* dataString = [src dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:dataString
                                 encoding:encoding]; // data为NSData类型
}

@end
