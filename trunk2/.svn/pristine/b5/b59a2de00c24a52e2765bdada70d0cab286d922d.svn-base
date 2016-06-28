//
//  GoodsDetailModel.m
//  Common
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GoodsDetailModel.h"
#import "UserGoodsDetailModel.h"

//商品详情
@implementation GoodsDetailModel


-(id)copyWithZone:(NSZone *)zone{
    GoodsDetailModel *goods=[[[self class]allocWithZone:zone] init];
    goods.tags=self.tags;
    goods.sellnum=self.sellnum;
    goods.originalPrice=self.originalPrice;
    goods.goodsPrice=self.goodsPrice;
    goods.goodstitle=self.goodstitle;
    goods.tribeMemberCount=self.tribeMemberCount;
    goods.shopImage=self.shopImage;
    goods.shopName=self.shopName;
    return  goods;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.tags forKey:@"tags"];
 
    [aCoder encodeInteger:self.sellnum forKey:@"sellnum"];
    [aCoder encodeInteger:self.originalPrice forKey:@"originalPrice"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeInteger:self.goodsPrice forKey:@"goodsPrice"];
    [aCoder encodeObject:self.shopImage forKey:@"shopImage"];
    [aCoder encodeObject:self.goodstitle forKey:@"goodstitle"];
    [aCoder encodeInteger:self.tribeMemberCount forKey:@"tribeMemberCount"];
    
 
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tags=[aDecoder decodeObjectForKey:@"tags"];
 
        self.sellnum=[aDecoder decodeIntegerForKey:@"sellnum"];
        self.originalPrice=[aDecoder decodeIntegerForKey:@"originalPrice"];
        self.goodsPrice=[aDecoder decodeIntegerForKey:@"goodsPrice"];
        self.shopImage=[aDecoder decodeObjectForKey:@"shopImage"];
        self.goodstitle=[aDecoder decodeObjectForKey:@"goodTitle"];
        self.shopName=[aDecoder decodeObjectForKey:@"shopName"];
        self.tribeMemberCount=[aDecoder decodeIntegerForKey:@"tribeMemberCount"];
    }
    return self;
}
+(GoodsDetailModel *)JsonParse:(NSDictionary *)dict{
    GoodsDetailModel *good=[[GoodsDetailModel alloc]init];
    
    NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    good.tags = [dict objectForKey:@"tags"];
    if([good.tags isKindOfClass:[NSArray class]]) {
        for(id data in good.tags){
            [dataArray addObject:[GoodsDetailModel JsonParse:data ]];
        }
    }
    good.tags=dataArray;
    
    good.sellnum=([dict objectForKey:@"sellnum"] !=[NSNull null])&&([dict objectForKey:@"sellnum"] !=nil) ?[[dict objectForKey:@"sellnum"] integerValue] :0;
    good.originalPrice=([dict objectForKey:@"originalPrice"] !=[NSNull null]) &&([dict objectForKey:@"originalPrice"] !=nil) ?[[dict objectForKey:@"originalPrice"] integerValue]:0;
    good.goodsPrice=([dict objectForKey:@"goodsPrice"] !=[NSNull null])&&([dict objectForKey:@"goodsPrice"] !=nil) ?[[dict objectForKey:@"goodsPrice"] integerValue]:0;
    good.goodstitle=([dict objectForKey:@"goodstitle"] !=[NSNull null]) &&([dict objectForKey:@"goodstitle"] !=nil) ?[dict objectForKey:@"goostitle"]:@"";
    good.shopImage=([dict objectForKey:@"shopImage"] !=[NSNull null])&&([dict objectForKey:@"shopName"] !=nil)?[dict objectForKey:@"shopName"]:@"";
    good.shopName=([dict objectForKey:@"shopName"] !=[NSNull null])&&([dict objectForKey:@"shopName"] !=nil)?[dict objectForKey:@"shopName"]:@"";
    good.tribeMemberCount=([dict objectForKey:@"tribeMemberCount"] !=[NSNull null])&&([dict objectForKey:@"tribeMemberCount"] !=nil) ?[[dict objectForKey:@"tribeMemberCount"] integerValue]:0;

    return good;
}



@end
