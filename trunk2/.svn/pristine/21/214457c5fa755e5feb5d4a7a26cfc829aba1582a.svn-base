//
//  NetConnection.h
//  SDK
//
//  Created by xuanqiang on 11/07/12.
//  Copyright (c) 2012年 Ecpalm. All rights reserved.
//

#import "DataModel.h"
#define REQUEST_FAIL_TIME   @"REQUEST_FAIL_TIME"

typedef void (^NetConnBlock)(DataModel *dataModel);
typedef void (^NetConnFailedBlock)(int, NSString *);
typedef void (^NetConnFormRequestBlock)(ASIFormDataRequest *);
@interface NetConnection : NSObject
+ (ASIHTTPRequest *)get:(NSString *)urlString  params:(NSDictionary *)params callback:(NetConnBlock)callback;
+ (ASIHTTPRequest *)get:(NSString *)urlString  params:(NSDictionary *)params callback:(NetConnBlock)callback failedCall:(NetConnFailedBlock)failedCall;
+ (ASIHTTPRequest *)post:(NSString *)urlString params:(NSDictionary *)params callback:(NetConnBlock)callback;
+ (ASIHTTPRequest *)post:(NSString *)urlString params:(NSDictionary *)params callback:(NetConnBlock)callback failedCall:(NetConnFailedBlock)failedCall;
+ (ASIHTTPRequest *)post:(NSString *)urlString params:(NSDictionary *)params requestBefore:(NetConnFormRequestBlock)requestBefore callback:(NetConnBlock)callback;
+ (ASIHTTPRequest *)postUTF8:(NSString *)urlString params:(NSDictionary *)params callback:(NetConnBlock)callback failedCall:(NetConnFailedBlock)failedCall;
+ (ASIHTTPRequest *)post:(NSString *)urlString params:(NSDictionary *)params requestBefore:(NetConnFormRequestBlock)requestBefore callback:(NetConnBlock)callback failedCall:(NetConnFailedBlock)failedCall encoding:(NSStringEncoding)encoding;
+ (ASIHTTPRequest *)post:(NSString *)urlString params:(NSDictionary *)params requestBefore:(NetConnFormRequestBlock)requestBefore callback:(NetConnBlock)callback failedCall:(NetConnFailedBlock)failedCall;
+ (BOOL)isNetworkReachable;

@end

