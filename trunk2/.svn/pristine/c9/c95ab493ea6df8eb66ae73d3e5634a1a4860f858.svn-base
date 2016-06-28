//
//  ImgModel.m
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ImgModel.h"

@implementation ImgModel
- (id)copyWithZone:(NSZone*)zone
{
    ImgModel* copy = [[[self class] allocWithZone:zone] init];
    copy.imageid = self.imageid;
    copy.imagename = [self.imagename copy];
    copy.objectid = self.objectid;
    copy.type = self.type;
    return copy;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeInt64:self.imageid forKey:@"imageid"];
    [aCoder encodeObject:self.imagename forKey:@"imagename"];
    [aCoder encodeInt64:self.objectid forKey:@"objectid"];
    [aCoder encodeInt64:self.type forKey:@"type"];
    [aCoder encodeObject:self.imgpath forKey:@"imgpath"];
    [aCoder encodeInt64:self.sort forKey:@"sort"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.imageid = [aDecoder decodeIntegerForKey:@"imageid"];
        self.imagename = [aDecoder decodeObjectForKey:@"imagename"];
        self.objectid = [aDecoder decodeIntegerForKey:@"objectid"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.imgpath = [aDecoder decodeObjectForKey:@"imgpath"];
        self.sort = [aDecoder decodeIntegerForKey:@"sort"];
    }
    return self;
}

+ (ImgModel*)JsonParse:(NSDictionary*)dic
{
    ImgModel* img = [[ImgModel alloc] init];

    img.imageid = ([dic objectForKey:@"imageid"] != [NSNull null]) && ([dic objectForKey:@"imageid"] != nil) ? [[dic objectForKey:@"imageid"] integerValue] : 0;
    NSString* imagename = ([dic objectForKey:@"imagename"] != [NSNull null]) && ([dic objectForKey:@"imagename"] != nil) ? [dic objectForKey:@"imagename"] : @"";
    NSString* imageName = ([dic objectForKey:@"imageName"] != [NSNull null]) && ([dic objectForKey:@"imageName"] != nil) ? [dic objectForKey:@"imageName"] : @"";
    if (![imagename isEqual:@""]) {
        img.imagename = imagename;
    }
    else if (![imageName isEqual:@""]) {
        img.imagename = imageName;
    }
    else {
        img.imagename = @"";
    }
    img.objectid = ([dic objectForKey:@"objectid"] != [NSNull null]) && ([dic objectForKey:@"objectid"] != nil) ? [[dic objectForKey:@"objectid"] integerValue] : 0;
    img.type = ([dic objectForKey:@"type"] != [NSNull null]) && ([dic objectForKey:@"type"] != nil) ? [[dic objectForKey:@"type"] integerValue] : 0;
    return img;
}
@end
