//
//  TribeCategoryModel.h
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TribeCategoryModel : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger tribeId;
@property (nonatomic,strong) NSString* tribeName;
@property (nonatomic,assign) NSInteger categoryNumber;
@property (nonatomic,strong) NSString* imgUrl;

+(TribeCategoryModel *)JsonParse:(NSDictionary *)dic;
@end
