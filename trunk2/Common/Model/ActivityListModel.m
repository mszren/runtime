//
//  ActivityListModel.m
//  Common
//
//  Created by 我 on 15/7/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityListModel.h"

@implementation ActivityListModel

-(id)copyWithZone:(NSZone *)zone{
    
    ActivityListModel *activity = [[ActivityListModel alloc]init];
    activity.face = [self.face copy];
    activity.userId = self.userId;
    activity.nickname = [self.nickname copy];
    activity.rownum = self.rownum;
    return activity;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeInteger:self.rownum forKey:@"rownum"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.face = [aDecoder decodeObjectForKey:@"face"];
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.rownum = [aDecoder decodeIntegerForKey:@"rownum"];
        
    }
    return self;
}


+(ActivityListModel *)JsonParse:(NSDictionary *)dict{
    
    ActivityListModel *activity=[[ActivityListModel alloc]init];
    activity.face=([dict objectForKey:@"face"] !=[NSNull null])&&([dict objectForKey:@"face"] !=nil)?[dict objectForKey:@"face"]:@"";
    activity.userId = ([dict objectForKey:@"userId"] != [NSNull null])&&([dict objectForKey:@"userId"] !=nil) ? [[dict objectForKey:@"userId"] integerValue] : 0;
    
    activity.nickname=([dict objectForKey:@"nickname"] !=[NSNull null])&&([dict objectForKey:@"nickname"] !=nil)?[dict objectForKey:@"nickname"]:@"";
    activity.rownum = ([dict objectForKey:@"rownum"] != [NSNull null])&&([dict objectForKey:@"rownum"] !=nil) ? [[dict objectForKey:@"rownum"] integerValue] : 0;
    
    
    return activity;
}

@end
