//
//  FilePathHandler.m
//  Common
//
//  Created by 曹亮 on 15/4/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "FilePathHandler.h"

@implementation FilePathHandler



+ (BOOL) checkFileExist:(NSString *) aUrl
{
    if ([aUrl hasPrefix:@"http"]) {
        
        //获取文件路径，除去域名
        NSString * temp;
        if ([aUrl hasPrefix:File_SERVER]) {
            temp = [aUrl substringFromIndex:File_SERVER.length];
        }else if ([aUrl hasPrefix:File_SERVER]){
            temp = [aUrl substringFromIndex:File_SERVER.length];
        }
        
        NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString* path = [cachesPath stringByAppendingPathComponent:temp];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] ) {
            return YES;
        }else{
            return NO;
        }
    }else{
        NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString* path = [cachesPath stringByAppendingPathComponent:aUrl];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] ) {
            return YES;
        }else{
            return NO;
        }
    }
}

//获取本地路径，并创建所需的文件夹
+ (NSString *) changeLocalFilePath:(NSString *) aUrl
{
    NSString * resultStr;
    if ([aUrl hasPrefix:@"http"]) {
        NSString * temp;
        if ([aUrl hasPrefix:@"http://file.wevaluing.com//"]) {
            temp = [aUrl substringFromIndex:@"http://file.wevaluing.com//".length];
        }else if ([aUrl hasPrefix:@"http://file.wevaluing.com/"]){
            temp = [aUrl substringFromIndex:@"http://file.wevaluing.com/".length];
        }
        resultStr = temp;
    }else{
        resultStr = aUrl;
    }
    NSString * toPathName = [resultStr lastPathComponent];
    NSString * targePath= [[PathHelper cacheDirectoryPathWithName:[resultStr stringByDeletingLastPathComponent]] stringByAppendingPathComponent:toPathName];
    return targePath;
}


+ (NSURL *) getFileUrl:(NSString *) aStrPath withType:(CHAT_INFO_TYPE) chatInfoType
{
    
    if ([aStrPath hasPrefix:@"http"]) {
        return [NSURL URLWithString:aStrPath];
    }else{
        NSFileManager * fileManager = [NSFileManager defaultManager];
        
        NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString* path = [cachesPath stringByAppendingPathComponent:aStrPath];
        
        if ([fileManager fileExistsAtPath:path]) {
            return [NSURL fileURLWithPath:path];
        }else{
            if (chatInfoType == CHATINFO_FIL_IMG) {
                return [NSURL URLWithString:getOriginalImage(aStrPath)];
            }else if (chatInfoType == CHATINFO_FIL_Voice){
                return [NSURL URLWithString:getFileURL(aStrPath)];
            }else if (chatInfoType == CHATINFO_FIL_Video){
                return [NSURL URLWithString:getFileURL(aStrPath)];
            }else{
                return [NSURL URLWithString:getFileURL(aStrPath)];
            }
        }
    }
}


@end