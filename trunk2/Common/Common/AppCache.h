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

+(CurrentAccount*) getCurrentUser;

+(void) saveCurrentUser:(CurrentAccount*)user;
@end
