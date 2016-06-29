//
//  OSSUnity.m
//  Core
//
//  Created by 曹亮 on 15/4/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "OSSUnity.h"
#import "OSSTool.h"
#import "ImgModel.h"

@interface OSSUnity ()

@end

#define OSSBucketName @"jiajiabang"
#define OSSAccessKey @"ukZxh4uCD6VWvwd2"
#define OSSScrectKey @"H6NsydEk5SJUXb3pWYyj48etiWUgeq"

static OSSUnity* ossUnity;
@implementation OSSUnity

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ossUnity = [[self alloc] init];
    });
    return ossUnity;
}

- (id)init
{
    self = [super init];
    if (self) {
        _ossClient = [OSSClient sharedInstanceManage];
        [_ossClient setGenerateToken:^(NSString* method, NSString* md5, NSString* type, NSString* date, NSString* xoss, NSString* resource) {
            NSString* signature = nil;
            NSString* content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
            signature = [OSSTool calBase64Sha1WithData:content withKey:OSSScrectKey];
            signature = [NSString stringWithFormat:@"OSS %@:%@", OSSAccessKey, signature];
            NSLog(@"here signature:%@", signature);
            return signature;
        }];
        [_ossClient setGlobalDefaultBucketHostId:@"oss-cn-hangzhou.aliyuncs.com"];
        [_ossClient setGlobalDefaultBucketAcl:PUBLIC_READ];

        _ossBucket = [[OSSBucket alloc] initWithBucket:OSSBucketName];
        [_ossBucket setAcl:PUBLIC_READ]; // 指明该Bucket的访问权限
    }
    return self;
}

- (void)uploadFile:(NSString*)alocalPathStr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSUnityUploadBlock)ossUnityUploadBlock
{

    NSString* fileType = [alocalPathStr pathExtension];
    NSDate* now = [NSDate date];
    NSString* targetStr = [NSString stringWithFormat:@"%@/%ld/%ld/%@.%@", aSubStr, (long)[now year], (long)[now month], [NSDate currentTimeByJava], fileType];
    NSData* upData = [[NSData alloc] initWithContentsOfFile:alocalPathStr];

    OSSData* ossData = [[OSSData alloc] initWithBucket:_ossBucket withKey:targetStr];
    [ossData setData:upData withType:fileType];

    [ossData uploadWithUploadCallback:^(BOOL isSuccess, NSError* error) {
        if (isSuccess) {
            ossUnityUploadBlock(isSuccess, alocalPathStr, aSubStr, targetStr);
        }
        else {
            ossUnityUploadBlock(isSuccess, alocalPathStr, aSubStr, nil);
            NSLog(@"errorInfo_testDataUploadWithProgress:%@", [error userInfo]);
        }
    } withProgressCallback:^(float progress) {
        NSLog(@"current get %f", progress);
    }];
}

- (void)uploadFiles:(NSArray*)imgArr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSUnityMutiUploadBlock)ossUnityUploadBlock
{
    __block NSInteger imgCount = 0;
    __block NSMutableArray* arrStatus = [[NSMutableArray alloc] initWithCapacity:0];
    for (ImgModel* model in imgArr) {
        [self uploadFile:model.imgpath
            withTargetSubPath:aSubStr
                    withBlock:^(BOOL status, NSString* alocalPathStr, NSString* aSubStr, NSString* resourceURLStr) {
                        imgCount++;
                        [arrStatus addObject:@(status)];
                        model.imagename = resourceURLStr;
                        if (imgCount == [imgArr count]) {
                            ossUnityUploadBlock(arrStatus);
                        }
                    }];
    }
}

@end