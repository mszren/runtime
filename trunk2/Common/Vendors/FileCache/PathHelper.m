//
//  PathHelper.m
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "PathHelper.h"


@implementation PathHelper
+ (BOOL)createPathIfNecessary:(NSString*)path {
	BOOL succeeded = YES;
	
	NSFileManager* fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:path]) {
		succeeded = [fm createDirectoryAtPath: path
				  withIntermediateDirectories: YES
								   attributes: nil
										error: nil];
	}
	
	return succeeded;
}
+ (NSString*)documentDirectoryPathWithName:(NSString*)name {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* cachesPath = [paths objectAtIndex:0];
	NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
	
	[PathHelper createPathIfNecessary:cachesPath];
	[PathHelper createPathIfNecessary:cachePath];
	
	return cachePath;
}
+ (NSString*)cacheDirectoryPathWithName:(NSString*)name {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* cachesPath = [paths objectAtIndex:0];
	NSString* cachePath = [cachesPath stringByAppendingPathComponent:name];
	
	[PathHelper createPathIfNecessary:cachesPath];
	[PathHelper createPathIfNecessary:cachePath];
	
	return cachePath;
}

@end
