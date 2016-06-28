//
//  TribeModel.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeModel.h"
#import "TagModel.h"
#import "GoodsModel.h"

@implementation TribeModel
- (id)copyWithZone:(NSZone*)zone
{
    TribeModel* copy = [[[self class] allocWithZone:zone] init];
    copy.tagsList = [self.tagsList copy];
    copy.shopAddress = [self.shopAddress copy];

    copy.face = [self.face copy];
    copy.tribeName = [self.tribeName copy];
    copy.isattention = self.isattention;
    copy.shopIntro = [self.shopIntro copy];
    copy.shopNotice = [self.shopIntro copy];
    copy.nickname = [self.nickname copy];
    copy.tribeMainId = self.tribeMainId;
    copy.shopName = [self.shopName copy];
    copy.contentNum = self.contentNum;

    copy.shopId = self.shopId;
    copy.attentionNum = self.attentionNum;
    copy.interActionNum = self.interActionNum;

    copy.shopMobile = [self.shopMobile copy];
    copy.shopLogo = [self.shopLogo copy];
    copy.shopImages = [self.shopImages copy];
    copy.star = [self.star copy];
    copy.distance = self.distance;
    copy.goodslist = [self.goodslist copy];
    copy.mapX = [self.mapX copy];
    copy.mapY = [self.mapY copy];
    copy.isAttention = self.isAttention;

    return copy;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:self.tagsList forKey:@"tagsList"];

    [aCoder encodeObject:self.shopAddress forKey:@"shopAddress"];
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeObject:self.shopNotice forKey:@"shopNotice"];
    [aCoder encodeObject:self.tribeName forKey:@"tribeName"];
    [aCoder encodeInt64:self.isattention forKey:@"isattention"];
    [aCoder encodeObject:self.shopIntro forKey:@"shopIntro"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeInt64:self.tribeMainId forKey:@"tribeMainId"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeInt64:self.shopId forKey:@"shopId"];

    [aCoder encodeInteger:self.contentNum forKey:@"contentNum"];
    [aCoder encodeInt64:self.attentionNum forKey:@"attentionNum"];
    [aCoder encodeInt64:self.interActionNum forKey:@"interActionNum"];
    [aCoder encodeInt64:self.isAttention forKey:@"isAttention"];
    [aCoder encodeObject:self.shopMobile forKey:@"shopMobile"];
    [aCoder encodeObject:self.shopLogo forKey:@"shopLogo"];
    [aCoder encodeObject:self.star forKey:@"star"];
    [aCoder encodeObject:self.shopImages forKey:@"shopImages"];
    [aCoder encodeObject:self.goodslist forKey:@"goodslist"];
    [aCoder encodeObject:self.mapX forKey:@"mapX"];
    [aCoder encodeObject:self.mapY forKey:@"mapY"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.tagsList = [aDecoder decodeObjectForKey:@"tagsList"];
        self.shopAddress = [aDecoder decodeObjectForKey:@"shopAddress"];
        self.face = [aDecoder decodeObjectForKey:@"face"];

        self.tribeName = [aDecoder decodeObjectForKey:@"tribeName"];
        self.isattention = [aDecoder decodeIntegerForKey:@"isattention"];
        self.shopIntro = [aDecoder decodeObjectForKey:@"shopIntro"];
        self.shopNotice = [aDecoder decodeObjectForKey:@"shopNotice"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.tribeMainId = [aDecoder decodeIntegerForKey:@"tribeMainId"];
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];

        self.shopId = [aDecoder decodeIntegerForKey:@"shopId"];
        self.attentionNum = [aDecoder decodeIntegerForKey:@"attentionNum"];
        self.interActionNum = [aDecoder decodeIntegerForKey:@"interActionNum"];
        self.shopMobile = [aDecoder decodeObjectForKey:@"shopMobile"];
        self.shopLogo = [aDecoder decodeObjectForKey:@"shopLogo"];

        self.star = [aDecoder decodeObjectForKey:@"star"];
        self.shopImages = [aDecoder decodeObjectForKey:@"shopImages"];
        self.distance = [aDecoder decodeIntegerForKey:@"distance"];
        self.goodslist = [aDecoder decodeObjectForKey:@"goodslist"];
        self.mapX = [aDecoder decodeObjectForKey:@"mapX"];
        self.mapY = [aDecoder decodeObjectForKey:@"mapY"];
        self.contentNum = [aDecoder decodeIntegerForKey:@"contentNum"];
        self.isAttention = [aDecoder decodeIntegerForKey:@"isAttention"];
    }
    return self;
}

+ (TribeModel*)JsonParse:(NSDictionary*)dic
{
    TribeModel* tribe = [[TribeModel alloc] init];

    NSArray* tagsArr = [dic objectForKey:@"tagsList"];

    NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (tagsArr) {
        for (id data in tagsArr) {
            [dataArray addObject:[TagModel JsonParse:data]];
        }
        tribe.tagsList = dataArray;
    }

    NSArray* goodslist = [dic objectForKey:@"goodslist"];
    if (goodslist && ![goodslist isKindOfClass:[NSNull class]]) {
        NSMutableArray* dataArry2 = [[NSMutableArray alloc] initWithCapacity:0];
        for (id data in goodslist) {
            [dataArry2 addObject:[GoodsModel JsonParse:data]];
        }
        tribe.goodslist = dataArry2;
    }

    tribe.shopAddress = ([dic objectForKey:@"shopAddress"] != [NSNull null]) && ([dic objectForKey:@"shopAddress"] != nil) ? [dic objectForKey:@"shopAddress"] : @"";
    tribe.face = ([dic objectForKey:@"face"] != [NSNull null]) && ([dic objectForKey:@"face"] != nil) ? [dic objectForKey:@"face"] : @"";
    tribe.tribeName = ([dic objectForKey:@"tribeName"] != [NSNull null]) && ([dic objectForKey:@"tribeName"] != nil) ? [dic objectForKey:@"tribeName"] : @"";

    tribe.isattention = ([dic objectForKey:@"isattention"] != [NSNull null]) && ([dic objectForKey:@"isattention"] != nil) ? [[dic objectForKey:@"isattention"] integerValue] : 0;
    tribe.shopIntro = ([dic objectForKey:@"shopIntro"] != [NSNull null]) && ([dic objectForKey:@"shopIntro"] != nil) ? [dic objectForKey:@"shopIntro"] : @"";
    tribe.shopNotice = ([dic objectForKey:@"shopNotice"] != [NSNull null]) && ([dic objectForKey:@"shopNotice"] != nil) ? [dic objectForKey:@"shopNotice"] : @"";
    tribe.nickname = ([dic objectForKey:@"nickname"] != [NSNull null]) && ([dic objectForKey:@"nickname"] != nil) ? [dic objectForKey:@"nickname"] : @"";

    tribe.tribeMainId = ([dic objectForKey:@"tribeMainId"] != [NSNull null]) && ([dic objectForKey:@"tribeMainId"] != nil) ? [[dic objectForKey:@"tribeMainId"] integerValue] : 0;
    tribe.shopName = ([dic objectForKey:@"shopName"] != [NSNull null]) && ([dic objectForKey:@"shopName"] != nil) ? [dic objectForKey:@"shopName"] : @"";
    tribe.shopId = ([dic objectForKey:@"shopId"] != [NSNull null]) && ([dic objectForKey:@"shopId"] != nil) ? [[dic objectForKey:@"shopId"] integerValue] : 0;
    
    tribe.isAttention = ([dic objectForKey:@"isAttention"] != [NSNull null]) && ([dic objectForKey:@"isAttention"] != nil) ? [[dic objectForKey:@"isAttention"] integerValue] : 0;

    tribe.attentionNum = ([dic objectForKey:@"attentionNum"] != [NSNull null]) && ([dic objectForKey:@"attentionNum"] != nil) ? [[dic objectForKey:@"attentionNum"] integerValue] : 0;
    tribe.interActionNum = ([dic objectForKey:@"interActionNum"] != [NSNull null]) && ([dic objectForKey:@"interActionNum"] != nil) ? [[dic objectForKey:@"interActionNum"] integerValue] : 0;

    tribe.shopMobile = ([dic objectForKey:@"shopMobile"] != [NSNull null]) && ([dic objectForKey:@"shopMobile"] != nil) ? [dic objectForKey:@"shopMobile"] : @"";
    tribe.shopLogo = ([dic objectForKey:@"shopLogo"] != [NSNull null]) && ([dic objectForKey:@"shopLogo"] != nil) ? [dic objectForKey:@"shopLogo"] : @"";
    tribe.star = ([dic objectForKey:@"star"] != [NSNull null]) && ([dic objectForKey:@"star"] != nil) ? [dic objectForKey:@"star"] : @"";
    tribe.shopImages = ([dic objectForKey:@"shopImages"] != [NSNull null]) && ([dic objectForKey:@"shopImages"] != nil) ? [dic objectForKey:@"shopImages"] : @"";
    tribe.distance = ([dic objectForKey:@"distance"] != [NSNull null]) && ([dic objectForKey:@"shopId"] != nil) ? [[dic objectForKey:@"distance"] integerValue] : 0;
    tribe.mapX = ([dic objectForKey:@"mapX"] != [NSNull null]) && ([dic objectForKey:@"mapX"] != nil) ? [dic objectForKey:@"mapX"] : @"";
    tribe.mapY = ([dic objectForKey:@"mapY"] != [NSNull null]) && ([dic objectForKey:@"mapY"] != nil) ? [dic objectForKey:@"mapY"] : @"";

    tribe.contentNum = ([dic objectForKey:@"contentNum"] != [NSNull null]) && ([dic objectForKey:@"contentNum"] != nil) ? [[dic objectForKey:@"contentNum"] integerValue] : 0;

    return tribe;
}
@end
