//
//  PathHelper.h
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PathHelper : NSObject {

}
+ (BOOL)createPathIfNecessary:(NSString*)path;
+ (NSString*)documentDirectoryPathWithName:(NSString*)name;
+ (NSString*)cacheDirectoryPathWithName:(NSString*)name;
@end
