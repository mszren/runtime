//
//  UserGoodsDetailModel.m
//  Common
//
//  Created by zhouwengang on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UserGoodsDetailModel.h"

@implementation UserGoodsDetailModel

-(id)copyWithZone:(NSZone *)zone{
    UserGoodsDetailModel *goods=[[[self class]allocWithZone:zone] init];
 
    goods.tagsId=self.tagsId;
    goods.tagsName=self.tagsName;
 
    return  goods;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
  
    [aCoder encodeInt64:self.tagsId forKey:@"tagsId"];
    [aCoder encodeObject:self.tagsName forKey:@"tagsName"];
 
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tagsId = [aDecoder decodeIntegerForKey:@"tagsId"];
        self.tagsName = [aDecoder decodeObjectForKey:@"tagsName"];
 
    }
    return self;
}

+(UserGoodsDetailModel *)JsonParse:(NSDictionary *)dict{
    UserGoodsDetailModel *good=[[UserGoodsDetailModel alloc]init];
    good.tagsName=([dict objectForKey:@"tagName"] != [NSNull null])&&([dict objectForKey:@"tagName"] !=nil) ?[dict objectForKey:@"tagsName"] :@"";
    good.tagsId=([dict objectForKey:@"tagsId"] != [NSNull null])&&([dict objectForKey:@"tagsId"] !=nil) ? [[dict objectForKey:@"tagsId"] integerValue] :0;
    return good;
}

@end
