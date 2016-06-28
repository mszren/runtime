//
//  HotActivityModel.m
//  Common
//
//  Created by hubin on 15/7/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HotActivityModel.h"

@implementation HotActivityModel

-(id)copyWithZone:(NSZone *)zone{
    
    HotActivityModel *activity = [[HotActivityModel alloc]init];
    activity.activityId = [self.activityId copy];
    activity.activityTitle = self.activityTitle;
    activity.activityStatus =self.activityStatus;
    activity.activityImage = self.activityImage;
    return activity;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.activityId forKey:@"activityId"];
    [aCoder encodeObject:self.activityTitle forKey:@"title"];
    [aCoder encodeInteger:self.activityStatus forKey:@"activityStatus"];
    [aCoder encodeObject:self.activityImage forKey:@"image"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.activityId = [aDecoder decodeObjectForKey:@"activityId"];
        self.activityTitle = [aDecoder decodeObjectForKey:@"title"];
        self.activityStatus = [aDecoder decodeIntForKey:@"activityStatus"];
        self.activityImage = [aDecoder decodeObjectForKey:@"image"];
        
    }
    return self;

}
+ (HotActivityModel *)JsonParse:(NSDictionary *)dic{
    HotActivityModel * hotActivityModel = [[HotActivityModel alloc] init];
    
    hotActivityModel.activityId = ([dic objectForKey:@"activityId"] != [NSNull null])&&([dic objectForKey:@"activityId"] !=nil) ? [dic objectForKey:@"activityId"] : @"";
    hotActivityModel.activityTitle = ([dic objectForKey:@"title"] != [NSNull null])&&([dic objectForKey:@"title"] !=nil) ? [dic objectForKey:@"title"] : @"";
    hotActivityModel.activityStatus = ([dic objectForKey:@"activityStatus"] != [NSNull null])&&([dic objectForKey:@"activityStatus"] !=nil) ? [[dic objectForKey:@"activityStatus"] integerValue]: 0;
    hotActivityModel.activityImage = ([dic objectForKey:@"image"] != [NSNull null])&&([dic objectForKey:@"image"] !=nil) ? [dic objectForKey:@"image"] : @"";
    return hotActivityModel;
}

@end
