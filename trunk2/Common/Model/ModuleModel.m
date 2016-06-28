//
//  ModuleModel.m
//  Common
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "ModuleModel.h"

@implementation ModuleModel
@synthesize moduleId = _moduleId;
@synthesize moduleTitle = _moduleTitle;
@synthesize title = _title;
@synthesize imgUrl = _imgUrl;
@synthesize moduleUrl = _moduleUrl;
@synthesize objectId = _objectId;

#pragma mark
#pragma mark-- initialization
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.moduleId = [dic objectForKey:@"moduleId"] != [NSNull null] ? [[dic objectForKey:@"moduleId"] integerValue] : INT32_MAX;
        self.moduleTitle = [dic objectForKey:@"moduleTitle"] != [NSNull null] ? [dic objectForKey:@"moduleTitle"] : @"";
        self.title = [dic objectForKey:@"title"] != [NSNull null] ? [dic objectForKey:@"title"] : @"";
        self.imgUrl = [dic objectForKey:@"imgUrl"] != [NSNull null] ? [dic objectForKey:@"imgUrl"] : @"";
        self.moduleUrl = [dic objectForKey:@"moduleUrl"] != [NSNull null] ? [dic objectForKey:@"moduleUrl"] : @"";
        self.objectId = [dic objectForKey:@"objectId"] != [NSNull null] ? [[dic objectForKey:@"objectId"] integerValue] : 0;
        self.type = [dic objectForKey:@"type"] != [NSNull null] ? [[dic objectForKey:@"type"] integerValue] : 0;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeInt64:self.moduleId forKey:@"moduleId"];
    [aCoder encodeObject:self.moduleTitle forKey:@"moduleTitle"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    [aCoder encodeObject:self.moduleUrl forKey:@"moduleUrl"];
    [aCoder encodeInteger:self.objectId forKey:@"objectId"];
    [aCoder encodeInteger:self.type forKey:@"type"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.moduleId = [aDecoder decodeInt64ForKey:@"moduleId"];
        self.moduleTitle = [aDecoder decodeObjectForKey:@"moduleTitle"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imgUrl = [aDecoder decodeObjectForKey:@"imgUrl"];
        self.moduleUrl = [aDecoder decodeObjectForKey:@"moduleUrl"];
        self.objectId = [aDecoder decodeIntegerForKey:@"objectId"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"moduleId= %ld , moduleTitle=%@ , title=%@ , imgUrl=%@ , moduleUrl = %@ , objectId =%ld,type =%ld", (long)self.moduleId, self.moduleTitle, self.title, self.imgUrl, self.moduleUrl, self.objectId, self.type];
}
#pragma mark
#pragma mark--  json parse
+ (ModuleModel*)JsonParse:(NSDictionary*)dic
{
    ModuleModel* model = [[ModuleModel alloc] init];

    model.moduleId = [dic objectForKey:@"moduleId"] != [NSNull null] ? [[dic objectForKey:@"moduleId"] integerValue] : INT32_MAX;
    model.moduleTitle = [dic objectForKey:@"moduleTitle"] != [NSNull null] ? [dic objectForKey:@"moduleTitle"] : @"";
    model.title = [dic objectForKey:@"title"] != [NSNull null] ? [dic objectForKey:@"title"] : @"";
    model.imgUrl = [dic objectForKey:@"imgUrl"] != [NSNull null] ? [dic objectForKey:@"imgUrl"] : @"";
    model.moduleUrl = [dic objectForKey:@"moduleUrl"] != [NSNull null] ? [dic objectForKey:@"moduleUrl"] : @"";
    model.objectId = [dic objectForKey:@"objectId"] != [NSNull null] ? [[dic objectForKey:@"objectId"] integerValue] : 0;

    model.type = [dic objectForKey:@"type"] != [NSNull null] ? [[dic objectForKey:@"type"] integerValue] : 0;

    return model;
}

@end
