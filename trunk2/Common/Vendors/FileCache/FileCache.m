//
//  FileCache.m
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "FileCache.h"
#import "PathHelper.h"
#import <CommonCrypto/CommonDigest.h>

#include <dirent.h>
#include <sys/stat.h>

@implementation FileCache
+ (NSString*)getFilePath:(NSArray*)fileNames withFileName:(NSString*)filename
{
    NSMutableString* Path = [NSMutableString stringWithString:FILEHOMENAME];
    for (NSString* temp in fileNames) {
        [Path appendFormat:@"/%@", temp];
    }
    NSString* filePath = [[PathHelper documentDirectoryPathWithName:Path]
        stringByAppendingPathComponent:filename];
    return filePath;
}
+ (NSString*)getStoragePath:(NSString*)filename
{
    NSString* filePath = [[PathHelper documentDirectoryPathWithName:FILEHOMENAME] stringByAppendingPathComponent:filename];
    return filePath;
}
+ (id)loadObjectWithFilename:(NSString*)filename
{
    NSString* filePath = [self getStoragePath:filename];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return obj;
}
+ (void)storageObject:(id)obj filename:(NSString*)filename
{
    NSString* filePath = [self getStoragePath:filename];
    [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
}
+ (id)loadObjectWithUrl:(NSString*)url
{
    return [self loadObjectWithFilename:[self md5:url]];
}
+ (void)storageObject:(id)obj url:(NSString*)url
{
    [self storageObject:obj filename:[self md5:url]];
}

+ (void)removeAllobjectWithurl:(NSString*)url
{
    NSString* filePath = [self getStoragePath:[self md5:url]];
    NSFileManager* manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
}
+ (NSString*)md5:(NSString*)str
{
    const char* cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    return [NSString stringWithFormat:
                         @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]];
}
+ (long)fileSizeForDir:(NSString*)path
{

    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    long size = 0;
    NSUInteger num = array.count;
    for (int i = 0; i < num; i++) {
        NSString* fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if (!([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir)) {
            NSDictionary* fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }
    }
    return size;
}

+ (long long)folderSize:(const char*)folderPath
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) {
        return 0;
    }
    struct dirent* child;
    while ((child = readdir(dir)) != NULL) {
        if (child->d_type == DT_DIR
            && (child->d_name[0] == '.' && child->d_name[1] == 0)) {
            continue;
        }

        if (child->d_type == DT_DIR
            && (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0)) {
            continue;
        }

        long folderPathLength = strlen(folderPath);
        char childPath[1024];
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength - 1] != '/') {
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }

        stpcpy(childPath + folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR) {
            folderSize += [self folderSize:childPath];
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                folderSize += st.st_size;
            }
        }
        else if (child->d_type == DT_REG || child->d_type == DT_LNK) {
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                folderSize += st.st_size;
            }
        }
    }
    return folderSize;
}

+ (NSUInteger)numFoldersWithPath:(NSString*)path
{
    NSArray* list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return list.count;
}

+ (BOOL)clearCache
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:[PathHelper documentDirectoryPathWithName:FILEHOMENAME] error:nil];
}

+ (void)copyFile:(NSString*)fromPath to:(NSString*)toPath
{
    NSError* error = nil;
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSString* destinationDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    NSString* destFile = [destinationDirectory stringByAppendingPathComponent:toPath];

    [fileManager moveItemAtPath:fromPath toPath:destFile error:&error];

    NSLog(@"copy error=%@", [error description]);
}

@end
