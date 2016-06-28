//
//  DownLoadListManager.h
//  EMBA
//
//  Created by caoliang on 13-8-22.
//  Copyright (c) 2013年 Beijing Qeebu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownLoadInfo;

@interface DownLoadListManager : NSObject{
    NSOperationQueue * queue;
    
    NSMutableArray * downLoadList;
}
@property (nonatomic, strong) NSMutableArray * downLoadList;


+ (id) shareDownLoadList;


- (NSUInteger)addDownLoadOperation:(DownLoadInfo *) downLoadInfo;


- (void) addDownload:(NSString *) aUrl withTargetPath:(NSString *) aPath;
@end
