//
//  AppCache.m
//  Common
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AppCache.h"
#import "FileCache.h"

@implementation AppCache

+ (id)loadCache:(NSString*)cacheKey
{
    return [FileCache loadObjectWithUrl:cacheKey];
}

+ (void)saveCache:(NSString*)cacheKey Data:(id)cacheData
{
    [FileCache storageObject:cacheData url:cacheKey];
}

+ (void)removeCache:(NSString*)cacheKey
{
    [FileCache storageObject:nil url:cacheKey];
}

+ (BOOL)clearCache
{
    return [FileCache clearCache];
}
@end
