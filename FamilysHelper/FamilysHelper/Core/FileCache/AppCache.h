//
//  AppCache.h
//  Common
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentAccount.h"

@interface AppCache : NSObject
+ (id)loadCache:(NSString*)cacheKey;
+ (void)saveCache:(NSString*)cacheKey Data:(id)cacheData;
+ (void)removeCache:(NSString*)cacheKey;
+ (BOOL)clearCache;
@end
