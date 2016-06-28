//
//  DownLoadInfo.m
//  EMBA
//
//  Created by caoliang on 13-8-22.
//  Copyright (c) 2013年 Beijing Qeebu Technology Co., Ltd. All rights reserved.
//

#import "DownLoadInfo.h"

#import "AFDownloadRequestOperation.h"

@implementation DownLoadInfo

- (id)initWithRequest:(NSURLRequest *)urlRequest targetPath:(NSString *)targetPath shouldResume:(BOOL)shouldResume{
    self = [super initWithRequest:urlRequest targetPath:targetPath shouldResume:shouldResume];
    if (self) {

    }
    return self;
}

- (float) showProgress{
    
    __block float p;
    [self setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
        p = percentDone;
    }];
    return p;
}



@end
