//
//  NSMutableURLRequest+MakeRequest.m
//  Core
//
//  Created by Foster Yin on 10/16/12.
//
//

#import "NSMutableURLRequest+MakeRequest.h"

@implementation NSMutableURLRequest (MakeRequest)

+ (NSMutableURLRequest *)requestWithRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:request.URL];
    [theRequest setAllHTTPHeaderFields:[request allHTTPHeaderFields]];
    [theRequest setHTTPMethod:[request HTTPMethod]];
    [theRequest setHTTPBody:[request HTTPBody]];
    [theRequest setHTTPShouldHandleCookies:[request HTTPShouldHandleCookies]];
    [theRequest setHTTPShouldUsePipelining:[request HTTPShouldUsePipelining]];
    [theRequest setCachePolicy:[request cachePolicy]];
    [theRequest setTimeoutInterval:[request timeoutInterval]];
    [theRequest setMainDocumentURL:[request mainDocumentURL]];
    [theRequest setNetworkServiceType:[request networkServiceType]];
    
    //iOS 6 methods
    if ([theRequest respondsToSelector:@selector(setAllowsCellularAccess:)] && [request respondsToSelector:@selector(allowsCellularAccess)])
    {
        [theRequest setAllowsCellularAccess:[request allowsCellularAccess]];
    }
    
    return theRequest;
}

@end
