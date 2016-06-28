//
//  BaseModel.m
//  Common
//
//  Created by Owen on 15/5/21.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
- (id)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.code = [[dic objectForKey:@"code"] integerValue];
        self.error = [dic objectForKey:@"error"] != [NSNull null] ? [dic objectForKey:@"error"] : @"";
        self.previousCursor = [dic objectForKey:@"previousCursor"] != [NSNull null] ? [[dic objectForKey:@"previousCursor"] integerValue] : 0;
        self.nextCursor = [dic objectForKey:@"nextCursor"] != [NSNull null] ? [[dic objectForKey:@"nextCursor"] integerValue] : 0;
        self.data = [dic objectForKey:@"data"];
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone
{
    DataModel* copy = [[[self class] allocWithZone:zone] init];
    copy.code = self.code;
    copy.error = [self.error copy];
    copy.previousCursor = self.previousCursor;
    copy.nextCursor = self.nextCursor;
    self.data = self.data;
    return copy;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeInt64:self.code forKey:@"code"];
    [aCoder encodeObject:self.error forKey:@"error"];
    [aCoder encodeInt64:self.previousCursor forKey:@"previousCursor"];
    [aCoder encodeInt64:self.nextCursor forKey:@"nextCursor"];
    [aCoder encodeObject:self.data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.code = [aDecoder decodeIntegerForKey:@"code"];
        self.error = [aDecoder decodeObjectForKey:@"error"];
        self.previousCursor = [aDecoder decodeIntegerForKey:@"previousCursor"];
        self.nextCursor = [aDecoder decodeIntegerForKey:@"nextCursor"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

@end
