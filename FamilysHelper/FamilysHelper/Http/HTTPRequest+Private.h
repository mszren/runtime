//
//  HTTPRequest+Private.h
//  CustomHTTP
//
//  Created by 我 on 16/3/24.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest (Private)

NSString *HTTPRequestPrivateBaseURL();

typedef void(^HTTPRequestResponseBlock)(NSUInteger code,
                                      NSString *message,
                                      id data);

+ (void)post:(NSString *)url
         parameters:(NSDictionary *)parameters
      responseBlock:(HTTPRequestResponseBlock)responseBlock;

+ (void)post:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeout:(NSTimeInterval)timeout
      responseBlock:(HTTPRequestResponseBlock)responseBlock;

@end
