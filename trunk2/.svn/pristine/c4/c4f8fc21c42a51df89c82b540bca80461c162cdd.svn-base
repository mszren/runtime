//
//  NSString+Formater.m
//  Core
//
//  Created by qluo on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Formater.h"

@implementation NSString (Formater)

- (NSString*)trimExtraWhiteBlank
{
    NSMutableString* result = [[[NSMutableString alloc] init] autorelease];
    for (NSInteger i = 0; i < [self length]; i++) 
    {
        unichar ch = [self characterAtIndex:i];
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:ch]) 
        {
            NSString* str = [NSString stringWithUnichar:ch];
            [result appendString:str];
        }
    }
    return result;
}

-(NSString*)validUrlStringWithSpaces{
    NSMutableString* temp = [[[NSMutableString alloc] init] autorelease];
    for (NSInteger i = 0; i < [self length]; i++)
    {
        unichar ch = [self characterAtIndex:i];
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:ch])
        {
            NSString* str = [NSString stringWithUnichar:ch];
            [temp appendString:str];
        }else
            [temp appendString:@"%20"]; // %20 replaces space in url
    }
    return temp;
}

-(NSString*)trimPreSpaces{
    NSInteger firstNotEmptyIndex = 0;
    for (; firstNotEmptyIndex < [self length]; ++firstNotEmptyIndex) {
        if ([self characterAtIndex:firstNotEmptyIndex] != ' ') {
            break;
        }
    }
    if (firstNotEmptyIndex != 0) {
        return [self substringFromIndex:firstNotEmptyIndex];
    }else
        return self;
}

+ (NSString*)stringWithUnichar:(unichar)value
{
    NSString* str = [NSString stringWithFormat:@"%c",value];
    return str;
}

-(NSString*)replaceNewlineWithEmpty{
    NSMutableString *ret = [self mutableCopy];
    [ret replaceOccurrencesOfString:@"\n" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
    return [ret autorelease];
}

@end
