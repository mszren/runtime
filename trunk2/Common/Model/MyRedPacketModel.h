//
//  MyRedPacketModel.h
//  Common
//
//  Created by xj on 15/7/24.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRedPacketModel : NSObject
@property(nonatomic,assign) double prize;
@property(nonatomic,assign) double totalPrize;
@property(nonatomic,assign) NSInteger redPacketId;
@property(nonatomic,assign) NSInteger objectType;


@property(nonatomic,strong) NSString* entryTime;
@property(nonatomic,strong) NSString* nickName;

+(MyRedPacketModel *)JsonParse:(NSDictionary *)dict;
@end
