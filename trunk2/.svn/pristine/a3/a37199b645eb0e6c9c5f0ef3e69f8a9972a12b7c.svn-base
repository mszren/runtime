//
//  NSString+NSString___APIEncoding.m
//  Core
//
//  Created by LuoQi on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+APIEncoding.h"
#import "GTMBase64.h"

@implementation NSString (APIEncoding)

+(NSString*)encryptAPIString:(NSString*)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [GTMBase64 stringByEncodingData:data];
    NSMutableString *headStr = [[NSMutableString alloc] init];
    NSMutableString *tailStr = [[NSMutableString alloc] init];
    int len = (int)base64Str.length;
    int headlen = len/2;
    int taillen = len - headlen;
    while (headlen) {
        [headStr appendString:[NSString stringWithFormat:@"%c",[base64Str characterAtIndex:--headlen]]];
    }
    while (taillen) {
        [tailStr appendString:[NSString stringWithFormat:@"%c",[base64Str characterAtIndex:--len]]];
        --taillen;
    }
    base64Str = [NSString stringWithFormat:@"%@%@",headStr,tailStr];
    [headStr release];
    [tailStr release];
    return base64Str;
    
}

+(NSString*)decryptAPIString:(NSString*)str
{
    int len = (int)str.length;
    int headlen = len/2;
    int taillen = len - headlen;
    NSMutableString *headStr = [[NSMutableString alloc] init];
    NSMutableString *tailStr = [[NSMutableString alloc] init];
    while (headlen) {
        [headStr appendString:[NSString stringWithFormat:@"%c",[str characterAtIndex:--headlen]]];
    }
    while (taillen) {
        [tailStr appendString:[NSString stringWithFormat:@"%c",[str characterAtIndex:--len]]];
        --taillen;
    }
    str = [NSString stringWithFormat:@"%@%@",headStr,tailStr];
    [headStr release];
    [tailStr release];
    NSData *data = [GTMBase64 decodeString:str];
    NSString *finalStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    return finalStr;
}


+ (NSString *)_859ToUTF8:(NSString *)oldStr
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    
    return [NSString stringWithUTF8String:[oldStr cStringUsingEncoding:enc]];
}
@end
