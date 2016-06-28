//
//  DownLoadListManager.m
//  EMBA
//
//  Created by caoliang on 13-8-22.
//  Copyright (c) 2013年 Beijing Qeebu Technology Co., Ltd. All rights reserved.
//

#import "DownLoadInfo.h"
#import "DownLoadListManager.h"


static DownLoadListManager * downLoadListManager;
@implementation DownLoadListManager
@synthesize downLoadList;

+ (id) shareDownLoadList{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      downLoadListManager = [[self alloc] init];
                      
                  });
    return downLoadListManager;
}

- (id)init{
    self = [super init];
    if (self) {
        queue = [[NSOperationQueue alloc] init];
        self.downLoadList = [[NSMutableArray alloc] initWithCapacity:0];
        
        [queue setMaxConcurrentOperationCount:3];
    }
    return self;
}
- (void)dealloc{
    [queue cancelAllOperations];
}

- (NSUInteger)addDownLoadOperation:(DownLoadInfo *) downLoadInfo{
    [queue addOperation:downLoadInfo];
    [self.downLoadList addObject:downLoadInfo];
    

    NSUInteger aIndex = [self.downLoadList indexOfObject:downLoadInfo];
    return aIndex;
}


- (void) addDownload:(NSString *) aUrl withTargetPath:(NSString *) aPath
{
    NSURL  * url = [NSURL URLWithString:aUrl];
    NSMutableURLRequest *lrequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:RequestFileTimeOutInterval];
    
    AFDownloadRequestOperation * operation = [[AFDownloadRequestOperation alloc] initWithRequest:lrequest targetPath:aPath shouldResume:YES];
    [operation start];
}

@end
