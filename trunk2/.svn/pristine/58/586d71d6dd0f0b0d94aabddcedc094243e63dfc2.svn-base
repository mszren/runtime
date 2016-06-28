//
//  FileCache.h
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCache : NSObject {
}
+ (NSString*)getFilePath:(NSArray*)fileNames withFileName:(NSString*)filename;
+ (NSString*)getStoragePath:(NSString*)filename;
+ (id)loadObjectWithFilename:(NSString*)filename;
+ (void)storageObject:(id)obj filename:(NSString*)filename;
+ (id)loadObjectWithUrl:(NSString*)url;
+ (void)storageObject:(id)obj url:(NSString*)url;
+ (NSString*)md5:(NSString*)str;

+ (long)fileSizeForDir:(NSString*)path;
+ (long long)folderSize:(const char*)folderPath;

+ (NSUInteger)numFoldersWithPath:(NSString*)path;

+ (void)removeAllobjectWithurl:(NSString*)url;

+ (BOOL)clearCache;

+ (void)copyFile:(NSString*)fromPath
              to:(NSString*)toPath;

@end
