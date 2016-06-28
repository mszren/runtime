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

+(CurrentAccount*) getCurrentUser{
   return [FileCache loadObjectWithUrl:CurrentUser];
}

+(void) saveCurrentUser:(CurrentAccount*)user
{
    [FileCache storageObject:user url:CurrentUser];
}

@end
