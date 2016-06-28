//
//  CommunityModel.m
//  Common
//
//  Created by zhouwengang on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

- (id)copyWithZone:(NSZone *)zone
{
    CommunityModel *copy = [[[self class] allocWithZone:zone] init];
    copy.communityName = [self.communityName copy];
    copy.communityId = self.communityId;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.communityName forKey:@"communityName"];
    [aCoder encodeInt64:self.communityId forKey:@"communityId"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.communityName = [aDecoder decodeObjectForKey:@"communityName"];
        self.communityId = [aDecoder decodeIntegerForKey:@"communityId"];
    }
    return self;
}

+ (CommunityModel *)JsonParse:(NSDictionary *)dic{
    CommunityModel *community = [[CommunityModel alloc] init];
    
    community.communityName =([dic objectForKey:@"communityName"] != [NSNull null])&&([dic objectForKey:@"communityName"] !=nil) ? [dic objectForKey:@"communityName"] : @"";
    
    community.communityId = ([dic objectForKey:@"communityId"] != [NSNull null])&&([dic objectForKey:@"communityId"] !=nil) ? [[dic objectForKey:@"communityId"] integerValue] : 0;
    return community;
}
@end
