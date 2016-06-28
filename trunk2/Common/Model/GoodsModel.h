//
//  GoodsModel.h
//  Common
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject<NSCoding>
/**
 *  商品
 *
 *  @param dict
 *
 *  @return <#return value description#>
 */

@property (nonatomic,assign)NSInteger goodsId;
@property (nonatomic,assign)NSInteger originalPrice;
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,assign)NSInteger goodsPrice;
@property (nonatomic,strong)NSString *goodstitle;
@property (nonatomic,strong)NSString *goodsTitle;

@property (nonatomic,strong)NSString *goodsName;

@property (nonatomic,assign)NSInteger sellnum;
@property (nonatomic,assign)NSInteger likeCount;
@property (nonatomic,assign)NSInteger islike;
@property (nonatomic,strong)NSString *goodsimage;
@property (nonatomic,assign)NSInteger tribeMemberCount;
@property (nonatomic,strong)NSString *goodsIntro;

@property (nonatomic,strong)NSString *shopAddress;
@property (nonatomic,strong)NSString *shopimage;
@property (nonatomic,strong)NSString *shopName;

@property (nonatomic,strong)NSArray *tags;
@property (nonatomic,strong)NSString *imageName;
@property (nonatomic,assign)NSInteger shopId;

+(GoodsModel *)JsonParse:(NSDictionary *)dict;

@end
