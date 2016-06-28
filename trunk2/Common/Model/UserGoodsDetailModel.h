//
//  UserGoodsDetailModel.h
//  Common
//
//  Created by zhouwengang on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGoodsDetailModel : NSObject<NSCoding>

@property (nonatomic,copy)NSString * tagsName;
@property (nonatomic,assign)NSInteger tagsId;

+(UserMessageModel *)JsonParse:(NSDictionary *)dict;
@end
