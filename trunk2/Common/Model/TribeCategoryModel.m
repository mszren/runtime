//
//  TribeCategoryModel.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeCategoryModel.h"

@implementation TribeCategoryModel

- (id)copyWithZone:(NSZone *)zone
{
    TribeCategoryModel *copy = [[[self class] allocWithZone:zone] init];
    copy.tribeId = self.tribeId;
    copy.tribeName = [self.tribeName copy];
    copy.categoryNumber = self.categoryNumber;
    copy.imgUrl = [self.imgUrl copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.tribeId forKey:@"tribeId"];
    [aCoder encodeInt64:self.categoryNumber forKey:@"categoryNumber"];
    [aCoder encodeObject:self.tribeName forKey:@"tribeName"];
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tribeId = [aDecoder decodeIntegerForKey:@"tribeId"];
        self.tribeName = [aDecoder decodeObjectForKey:@"tribeName"];
        self.categoryNumber = [aDecoder decodeIntegerForKey:@"categoryNumber"];
        self.imgUrl = [aDecoder decodeObjectForKey:@"imgUrl"];
    }
    return self;
}

+ (TribeCategoryModel *)JsonParse:(NSDictionary *)dic{
    TribeCategoryModel * tribeCategory = [[TribeCategoryModel alloc] init];
    
    tribeCategory.tribeId = ([dic objectForKey:@"tribeId"] != [NSNull null])&&([dic objectForKey:@"tribeId"] !=nil) ? [[dic objectForKey:@"tribeId"] integerValue] : 0;
    tribeCategory.tribeName = ([dic objectForKey:@"tribeName"] != [NSNull null])&&([dic objectForKey:@"tribeName"] !=nil) ? [dic objectForKey:@"tribeName"] : @"";
    tribeCategory.categoryNumber = ([dic objectForKey:@"categoryNumber"] != [NSNull null])&&([dic objectForKey:@"categoryNumber"] !=nil) ? [[dic objectForKey:@"categoryNumber"] integerValue] : 0;
    tribeCategory.imgUrl = ([dic objectForKey:@"imgUrl"] != [NSNull null])&&([dic objectForKey:@"imgUrl"] !=nil) ? [dic objectForKey:@"imgUrl"] : @"";
    return tribeCategory;
}
@end
