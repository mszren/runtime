//
//  GoodsModel.m
//  Common
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GoodsModel.h"
#import "TagModel.h"

@implementation GoodsModel

#pragma mark
#pragma mark-- initialization

- (id)copyWithZone:(NSZone*)zone
{
    GoodsModel* copy = [[[self class] allocWithZone:zone] init];
    copy.goodsId = self.goodsId;
    copy.originalPrice = self.originalPrice;
    copy.imageUrl = [self.imageUrl copy];
    copy.goodsPrice = self.goodsPrice;
    copy.goodstitle = [self.goodstitle copy];
    copy.goodsName = [self.goodsName copy];

    copy.sellnum = self.sellnum;
    copy.likeCount = self.likeCount;
    copy.islike = self.islike;
    copy.goodsimage = [self.goodsimage copy];
    copy.tribeMemberCount = self.tribeMemberCount;
    copy.goodsIntro = [self.goodsIntro copy];
    copy.shopimage = [self.shopimage copy];
    copy.shopAddress = [self.shopAddress copy];
    copy.tags = [self.tags copy];
    copy.imageName = [self.imageName copy];
    copy.shopName = [self.shopName copy];
    copy.shopId = self.shopId;
    copy.goodsTitle = [self.goodsTitle copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{

    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeInt64:self.originalPrice forKey:@"originalPrice"];
    [aCoder encodeInt64:self.goodsId forKey:@"goodsId"];
    [aCoder encodeInt64:self.goodsPrice forKey:@"goodsPrice"];
    [aCoder encodeInt64:self.sellnum forKey:@"sellnum"];
    [aCoder encodeInt64:self.likeCount forKey:@"likeCount"];
    [aCoder encodeInt64:self.islike forKey:@"islike"];
    [aCoder encodeInt64:self.tribeMemberCount forKey:@"tribeMemberCount"];
    [aCoder encodeObject:self.goodsName forKey:@"goodsName"];
    [aCoder encodeObject:self.goodsimage forKey:@"goodsimage"];
    [aCoder encodeObject:self.goodsIntro forKey:@"goodsIntro"];
    [aCoder encodeObject:self.shopAddress forKey:@"shopAddress"];
    [aCoder encodeObject:self.shopimage forKey:@"shopimage"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeInteger:self.shopId forKey:@"shopId"];
    [aCoder encodeObject:self.goodsTitle forKey:@"goodsTitle"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.goodstitle = [aDecoder decodeObjectForKey:@"goodsTitle"];
        self.goodsName = [aDecoder decodeObjectForKey:@"goodsName"];
        self.goodsimage = [aDecoder decodeObjectForKey:@"goodsimage"];
        self.goodsIntro = [aDecoder decodeObjectForKey:@"goodsIntro"];
        self.goodsId = [aDecoder decodeIntForKey:@"goodsId"];
        self.originalPrice = [aDecoder decodeIntForKey:@"originalPrice"];
        self.goodsPrice = [aDecoder decodeIntForKey:@"goodsPrice"];
        self.sellnum = [aDecoder decodeIntForKey:@"sellnum"];
        self.likeCount = [aDecoder decodeIntForKey:@"likeCount"];
        self.islike = [aDecoder decodeIntForKey:@"islike"];
        self.tribeMemberCount = [aDecoder decodeIntForKey:@"tribeMemberCount"];
        self.shopAddress = [aDecoder decodeObjectForKey:@"shopAddress"];
        self.shopimage = [aDecoder decodeObjectForKey:@"shopimage"];
        self.tags = [aDecoder decodeObjectForKey:@"tags"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];
        self.shopId = [aDecoder decodeIntegerForKey:@"shopId"];
        self.goodsTitle = [aDecoder decodeObjectForKey:@"goodsTitle"];
    }
    return self;
}

+ (GoodsModel*)JsonParse:(NSDictionary*)dict
{
    GoodsModel* model = [[GoodsModel alloc] init];
    model.imageUrl = ([dict objectForKey:@"imageUrl"] != [NSNull null]) && ([dict objectForKey:@"imageUrl"] != nil) ? [dict objectForKey:@"imageUrl"] : @"";
    model.goodstitle = ([dict objectForKey:@"goodstitle"] != [NSNull null]) && ([dict objectForKey:@"goodstitle"] != nil) ? [dict objectForKey:@"goodstitle"] : @"";
    model.shopAddress = ([dict objectForKey:@"shopAddress"] != [NSNull null]) && ([dict objectForKey:@"shopAddress"] != nil) ? [dict objectForKey:@"shopAddress"] : @"";
    model.shopimage = ([dict objectForKey:@"shopimage"] != [NSNull null]) && ([dict objectForKey:@"shopimage"] != nil) ? [dict objectForKey:@"shopimage"] : @"";
    model.goodsName = ([dict objectForKey:@"goodsName"] != [NSNull null]) && ([dict objectForKey:@"goodsName"] != nil) ? [dict objectForKey:@"goodsName"] : @"";
    model.goodsimage = ([dict objectForKey:@"goodsimage"] != [NSNull null]) && ([dict objectForKey:@"goodsimage"] != nil) ? [dict objectForKey:@"goodsimage"] : @"";
    model.goodsIntro = ([dict objectForKey:@"goodsIntro"] != [NSNull null]) && ([dict objectForKey:@"goodsIntro"] != nil) ? [dict objectForKey:@"goodsIntro"] : @"";
    model.goodsId = ([dict objectForKey:@"goodsId"] != [NSNull null]) && ([dict objectForKey:@"goodsId"] != nil) ? [[dict objectForKey:@"goodsId"] integerValue] : 0;
    model.originalPrice = ([dict objectForKey:@"originalPrice"] != [NSNull null]) && ([dict objectForKey:@"originalPrice"] != nil) ? [[dict objectForKey:@"originalPrice"] integerValue] : 0;
    model.goodsPrice = ([dict objectForKey:@"goodsPrice"] != [NSNull null]) && ([dict objectForKey:@"goodsPrice"] != nil) ? [[dict objectForKey:@"goodsPrice"] integerValue] : 0;
    model.sellnum = ([dict objectForKey:@"sellnum"] != [NSNull null]) && ([dict objectForKey:@"sellnum"] != nil) ? [[dict objectForKey:@"sellnum"] integerValue] : 0;
    model.likeCount = ([dict objectForKey:@"likeCount"] != [NSNull null]) && ([dict objectForKey:@"likeCount"] != nil) ? [[dict objectForKey:@"likeCount"] integerValue] : 0;
    model.islike = ([dict objectForKey:@"islike"] != [NSNull null]) && ([dict objectForKey:@"islike"] != nil) ? [[dict objectForKey:@"islike"] integerValue] : 0;
    model.tribeMemberCount = ([dict objectForKey:@"tribeMemberCount"] != [NSNull null]) && ([dict objectForKey:@"tribeMemberCount"] != nil) ? [[dict objectForKey:@"tribeMemberCount"] integerValue] : 0;
    model.imageName = ([dict objectForKey:@"imageName"] != [NSNull null]) && ([dict objectForKey:@"imageName"] != nil) ? [dict objectForKey:@"imageName"] : @"";
    model.shopName = ([dict objectForKey:@"shopName"] != [NSNull null]) && ([dict objectForKey:@"shopName"] != nil) ? [dict objectForKey:@"shopName"] : @"";
    model.goodsTitle = ([dict objectForKey:@"goodsTitle"] != [NSNull null]) && ([dict objectForKey:@"goodsTitle"] != nil) ? [dict objectForKey:@"goodsTitle"] : @"";
    model.shopId = ([dict objectForKey:@"shopId"] != [NSNull null]) && ([dict objectForKey:@"shopId"] != nil) ? [[dict objectForKey:@"shopId"] integerValue] : 0;

    NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    model.tags = ([dict objectForKey:@"tags"] != [NSNull null]) && ([dict objectForKey:@"tags"] != nil) ? [dict objectForKey:@"tags"] : @"";
    if ([model.tags isKindOfClass:[NSArray class]]) {
        for (id data in model.tags) {
            [dataArray addObject:[TagModel JsonParse:data]];
        }
    }
    model.tags = dataArray;

    return model;
}
@end
