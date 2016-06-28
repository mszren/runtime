//
//  CityModel.m
//  Common
//
//  Created by zhouwengang on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
- (id)copyWithZone:(NSZone *)zone
{
    CityModel *copy = [[[self class] allocWithZone:zone] init];
    copy.cityName = [self.cityName copy];
    copy.cityId = self.cityId;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeInt64:self.cityId forKey:@"cityId"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        self.cityId = [aDecoder decodeIntegerForKey:@"cityId"];
    }
    return self;
}

+ (CityModel *)JsonParse:(NSDictionary *)dic{
    CityModel * City = [[CityModel alloc] init];
    
    City.cityName = ([dic objectForKey:@"cityName"] != [NSNull null])&&([dic objectForKey:@"cityName"] !=nil) ? [dic objectForKey:@"cityName"]:@"";
    City.cityId = ([dic objectForKey:@"cityId"] != [NSNull null])&&([dic objectForKey:@"cityId"] !=nil) ? [[dic objectForKey:@"cityId"]integerValue]:0;
        return City;
}

@end
