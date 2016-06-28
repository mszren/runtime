//
//  GoodsDetailModel.h
//  Common
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>
//商品详情
@interface GoodsDetailModel : NSObject<NSCoding>


@property (nonatomic,copy)NSString * shopName;

@property (nonatomic,assign)NSInteger sellnum;
@property (nonatomic,assign)NSInteger originalPrice;
@property (nonatomic,assign)NSInteger goodsPrice;
@property (nonatomic,copy)NSString *shopImage;
@property (nonatomic,copy)NSString *goodstitle;
@property (nonatomic,assign)NSInteger tribeMemberCount;
@property (nonatomic,strong)NSArray *tags;

+(GoodsDetailModel *)JsonParse:(NSDictionary *)dict;

@end
