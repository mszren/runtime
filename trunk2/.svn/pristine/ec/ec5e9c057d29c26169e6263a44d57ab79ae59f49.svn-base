//
//  MyCollectionModel.m
//  Common
//
//  Created by xj on 15/7/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyCollectionModel.h"

@implementation MyCollectionModel

-(id)copyWithZone:(NSZone *)zone{
    
    MyCollectionModel *collection = [[MyCollectionModel alloc]init];
    collection.collectId = self.collectId;
    collection.objectId = self.objectId;
    collection.createTime = self.createTime;
    collection.objectType = self.objectType;
    collection.triberId = self.triberId;
    collection.price = self.price;

 
    collection.imageUrl = [self.imageUrl copy];
    collection.oriPrice = [self.oriPrice copy];
    collection.context = [self.context copy];
    collection.shopImageUrl = [self.shopImageUrl copy];
    collection.shopname = [self.shopname copy];
    collection.goodsName = [self.goodsName copy];
    return collection;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.collectId forKey:@"collectId"];
    [aCoder encodeInteger:self.objectId forKey:@"objectId"];
    [aCoder encodeInteger:self.createTime forKey:@"createTime"];
    [aCoder encodeInteger:self.objectType forKey:@"objectType"];
    [aCoder encodeInteger:self.triberId forKey:@"triberId"];
    [aCoder encodeInteger:self.price forKey:@"price"];

 
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.oriPrice forKey:@"oriPrice"];
    [aCoder encodeObject:self.context forKey:@"context"];
    [aCoder encodeObject:self.shopImageUrl forKey:@"shopImageUrl"];
    [aCoder encodeObject:self.shopname forKey:@"shopname"];
    [aCoder encodeObject:self.goodsName forKey:@"goodsName"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.collectId = [aDecoder decodeIntegerForKey:@"collectId"];
        self.objectId = [aDecoder decodeIntegerForKey:@"objectId"];
        self.createTime = [aDecoder decodeIntegerForKey:@"createTime"];
        self.objectType = [aDecoder decodeIntegerForKey:@"objectType"];
        self.triberId = [aDecoder decodeIntegerForKey:@"triberId"];
        self.price = [aDecoder decodeIntegerForKey:@"price"];


        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.oriPrice = [aDecoder decodeObjectForKey:@"oriPrice"];
        self.context = [aDecoder decodeObjectForKey:@"context"];
        self.shopImageUrl = [aDecoder decodeObjectForKey:@"shopImageUrl"];
        self.shopname = [aDecoder decodeObjectForKey:@"shopname"];
        self.goodsName = [aDecoder decodeObjectForKey:@"goodsName"];
    }
    return self;
}


+(MyCollectionModel *)JsonParse:(NSDictionary *)dict{
    
    MyCollectionModel *collection=[[MyCollectionModel alloc]init];
    collection.collectId = ([dict objectForKey:@"collectId"] != [NSNull null])&&([dict objectForKey:@"collectId"] !=nil) ? [[dict objectForKey:@"collectId"] integerValue] : 0;
    collection.objectId = ([dict objectForKey:@"objectId"] != [NSNull null])&&([dict objectForKey:@"objectId"] !=nil) ? [[dict objectForKey:@"objectId"] integerValue] : 0;
    collection.createTime = ([dict objectForKey:@"createTime"] != [NSNull null])&&([dict objectForKey:@"createTime"] !=nil) ? [[dict objectForKey:@"createTime"] integerValue] : 0;
    collection.objectType = ([dict objectForKey:@"objectType"] != [NSNull null])&&([dict objectForKey:@"objectType"] !=nil) ? [[dict objectForKey:@"objectType"] integerValue] : 0;
    collection.triberId = ([dict objectForKey:@"triberId"] != [NSNull null])&&([dict objectForKey:@"triberId"] !=nil) ? [[dict objectForKey:@"triberId"] integerValue] : 0;
    collection.price = ([dict objectForKey:@"price"] != [NSNull null])&&([dict objectForKey:@"price"] !=nil) ? [[dict objectForKey:@"price"] integerValue] : 0;


    collection.imageUrl=([dict objectForKey:@"imageUrl"] !=[NSNull null])&&([dict objectForKey:@"imageUrl"] !=nil)?[dict objectForKey:@"imageUrl"]:@"";
    collection.oriPrice=([dict objectForKey:@"oriPrice"] !=[NSNull null])&&([dict objectForKey:@"oriPrice"] !=nil)?[dict objectForKey:@"oriPrice"]:@"";
    collection.context=([dict objectForKey:@"context"] !=[NSNull null])&&([dict objectForKey:@"context"] !=nil)?[dict objectForKey:@"context"]:@"";
    collection.shopImageUrl=([dict objectForKey:@"shopImageUrl"] !=[NSNull null])&&([dict objectForKey:@"shopImageUrl"] !=nil)?[dict objectForKey:@"shopImageUrl"]:@"";
    collection.shopname=([dict objectForKey:@"shopname"] !=[NSNull null])&&([dict objectForKey:@"shopname"] !=nil)?[dict objectForKey:@"shopname"]:@"";
    collection.goodsName=([dict objectForKey:@"goodsName"] !=[NSNull null])&&([dict objectForKey:@"goodsName"] !=nil)?[dict objectForKey:@"goodsName"]:@"";
     return collection;
}

@end
