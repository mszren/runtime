//
//  OSSUnity.h
//  Core
//
//  Created by 曹亮 on 15/4/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "OSSData.h"
#import "OSSBucket.h"
#import "OSSClient.h"

typedef void (^OSSUnityUploadBlock)(BOOL status, NSString* alocalPathStr, NSString* aSubStr, NSString* resourceURLStr);

typedef void (^OSSUnityMutiUploadBlock)(NSArray* status);

@interface OSSUnity : NSObject {
    OSSBucket* _ossBucket;
    OSSData* _ossData;

    OSSClient* _ossClient;
}
+ (instancetype)shareInstance;

//- (void)upload:(NSData *) upData;

- (void)uploadFile:(NSString*)alocalPathStr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSUnityUploadBlock)ossUnityUploadBlock;

- (void)uploadFiles:(NSArray*)imgArr withTargetSubPath:(NSString*)aSubStr withBlock:(OSSUnityMutiUploadBlock)ossUnityUploadBlock;
@end