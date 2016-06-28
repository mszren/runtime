//
//  NSDictionaryAdditional.m
//  Dolphin
//
//  Created by Jim Huang on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionaryAdditional.h"


@implementation NSDictionary (NSDictionaryAdditional)

-(NSString*)stringForKey:(NSString*)key
{
    NSString* result = [self objectForKey:key];
    if([result isKindOfClass:[NSNull class]])
    {
        result = @"";
    }
    else if ([result isKindOfClass:[NSNumber class]])
    {
        NSNumber* number = (NSNumber*)result;
        result = [number stringValue];
    }
    
    return result;
}

@end
