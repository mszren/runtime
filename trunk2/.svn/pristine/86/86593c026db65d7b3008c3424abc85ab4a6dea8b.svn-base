//
//  WarningView.h
//  qeebuConference
//
//  Created by caoliang on 13-2-7.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import "FaceUtil.h"


static FaceUtil * faceUtil = nil;
@implementation FaceUtil

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype) shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      faceUtil = [[self alloc] init];
                  });
    return faceUtil;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emoji_biaoqing.plist"];
        _faceDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

@end
