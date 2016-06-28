//
//  TagModel.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

- (id)copyWithZone:(NSZone *)zone
{
    TagModel *copy = [[[self class] allocWithZone:zone] init];
    copy.tagsId = self.tagsId;
    copy.tagsColor = [self.tagsColor copy];
    copy.tagsName = [self.tagsName copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.tagsId forKey:@"tagsId"];
    [aCoder encodeObject:self.tagsName forKey:@"tagsName"];
    [aCoder encodeObject:self.tagsColor forKey:@"tagsColor"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tagsId = [aDecoder decodeIntegerForKey:@"tagsId"];
        self.tagsColor = [aDecoder decodeObjectForKey:@"tagsColor"];
        self.tagsName = [aDecoder decodeObjectForKey:@"tagsName"];
    }
    return self;
}

+ (TagModel *)JsonParse:(NSDictionary *)dic{
    TagModel * tag = [[TagModel alloc] init];
    
    tag.tagsId = ([dic objectForKey:@"tagsId"] != [NSNull null])&&([dic objectForKey:@"tagsId"] !=nil) ? [[dic objectForKey:@"tagsId"] integerValue] : 0;
    tag.tagsColor = ([dic objectForKey:@"tagsColor"] != [NSNull null])&&([dic objectForKey:@"tagsColor"] !=nil) ? [dic objectForKey:@"tagsColor"] : @"";
    tag.tagsName = ([dic objectForKey:@"tagsName"] != [NSNull null])&&([dic objectForKey:@"tagsName"] !=nil) ? [dic objectForKey:@"tagsName"] : @"";
    return tag;
}

@end
