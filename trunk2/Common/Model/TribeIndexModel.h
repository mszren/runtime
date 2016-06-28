//
//  TribeIndexModel.h
//  Common
//
//  Created by Owen on 15/6/4.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TribeIndexModel : NSObject<NSCoding>
@property (nonatomic,strong) NSString* content;
@property (nonatomic,assign) NSInteger tribeId;
@property (nonatomic,assign) NSInteger publishId;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSString* shopName;
@property (nonatomic,strong) NSString* shopImage;
@property (nonatomic,assign) NSInteger typeId;

@property (nonatomic,assign) NSInteger interactioncount;
@property (nonatomic,assign) NSInteger activitycount;
@property (nonatomic,assign) NSInteger attentionNum;

+(TribeIndexModel *)JsonParse:(NSDictionary *)dic;

@end
