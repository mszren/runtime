//
//  ActivityModel.m
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "ActivityModel.h"
#import "ActivityListModel.h"

@implementation ActivityModel

#pragma mark
#pragma mark-- initialization
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeInt64:self.activityId forKey:@"activityId"];
    [aCoder encodeInt64:self.isHot forKey:@"isHot"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.startTime forKey:@"startTime"];
    [aCoder encodeInt64:self.shopId forKey:@"shopId"];
    [aCoder encodeInt64:self.money forKey:@"money"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.endTimeStr forKey:@"endTimeStr"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeObject:self.shopLogo forKey:@"shopLogo"];
    [aCoder encodeObject:self.beginTimeStr forKey:@"beginTimeStr"];

    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.content forKey:@"content"];

    [aCoder encodeInt64:self.hitNum forKey:@"hitNum"];
    [aCoder encodeInt64:self.replyNum forKey:@"replyNum"];
    [aCoder encodeInt64:self.isTop forKey:@"isTop"];

    [aCoder encodeInt64:self.joinNum forKey:@"joinNum"];
    [aCoder encodeInt64:self.status forKey:@"status"];
    [aCoder encodeInt64:self.activityStatus forKey:@"activityStatus"];
    [aCoder encodeObject:self.shopImages forKey:@"shopImages"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.activityApplyList forKey:@"activityApplyList"];
    [aCoder encodeObject:self.endTime forKey:@"endTime"];

    [aCoder encodeObject:self.commentNickName forKey:@"commentNickName"];
    [aCoder encodeObject:self.commentContent forKey:@"commentContent"];
    [aCoder encodeObject:self.imagePath forKey:@"imagePath"];
    [aCoder encodeInt64:self.objectType forKey:@"objectType"];
    [aCoder encodeInteger:self.row forKey:@"row"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.activityId = [aDecoder decodeIntegerForKey:@"activityId"];
        self.isHot = [aDecoder decodeIntegerForKey:@"isHot"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.startTime = [aDecoder decodeObjectForKey:@"startTime"];
        self.shopId = [aDecoder decodeIntegerForKey:@"shopId"];
        self.money = [aDecoder decodeIntegerForKey:@"money"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.endTimeStr = [aDecoder decodeObjectForKey:@"endTimeStr"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];
        self.shopLogo = [aDecoder decodeObjectForKey:@"shopLogo"];
        self.beginTimeStr = [aDecoder decodeObjectForKey:@"beginTimeStr"];

        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.hitNum = [aDecoder decodeIntegerForKey:@"hitNum"];
        self.replyNum = [aDecoder decodeIntegerForKey:@"replyNum"];
        self.isTop = [aDecoder decodeIntegerForKey:@"isTop"];

        self.joinNum = [aDecoder decodeIntegerForKey:@"joinNum"];
        self.status = [aDecoder decodeIntegerForKey:@"status"];
        self.activityStatus = [aDecoder decodeIntegerForKey:@"activityStatus"];
        self.activityApplyList = [aDecoder decodeObjectForKey:@"activityApplyList"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.shopImages = [aDecoder decodeObjectForKey:@"shopImages"];
        self.endTime = [aDecoder decodeObjectForKey:@"endTime"];

        self.commentContent = [aDecoder decodeObjectForKey:@"commentContent"];
        self.commentNickName = [aDecoder decodeObjectForKey:@"commentNickName"];
        self.objectType = [aDecoder decodeIntegerForKey:@"objectType"];
        self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
        self.row = [aDecoder decodeIntegerForKey:@"row"];
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"activityId= %ld , isHot=%ld , name=%@ , desc=%@ , startTime = %@", (long)self.activityId, (long)self.isHot, self.name, self.desc, self.startTime];
}
#pragma mark
#pragma mark--  json parse
+ (ActivityModel*)JsonParse:(NSDictionary*)dic
{
    ActivityModel* model = [[ActivityModel alloc] init];
    NSInteger actId = [dic objectForKey:@"actId"] != [NSNull null] ? [[dic objectForKey:@"actId"] integerValue] : 0;
    NSInteger activityId = [dic objectForKey:@"activityId"] != [NSNull null] ? [[dic objectForKey:@"activityId"] integerValue] : 0;
    if (actId != 0) {
        model.activityId = actId;
    }
    else if (activityId != 0) {
        model.activityId = activityId;
    }
    model.isHot = [dic objectForKey:@"isHot"] != [NSNull null] ? [[dic objectForKey:@"isHot"] integerValue] : 0;
    model.name = [dic objectForKey:@"name"] != [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.desc = [dic objectForKey:@"desc"] != [NSNull null] ? [dic objectForKey:@"desc"] : @"";
    model.startTime = [dic objectForKey:@"startTime"] != [NSNull null] ? [dic objectForKey:@"startTime"] : @"";
    model.shopId = [dic objectForKey:@"shopId"] != [NSNull null] ? [[dic objectForKey:@"shopId"] integerValue] : 0;

    model.joinNum = [dic objectForKey:@"joinNum"] != [NSNull null] ? [[dic objectForKey:@"joinNum"] integerValue] : 0;
    model.phone = [dic objectForKey:@"phone"] != [NSNull null] ? [dic objectForKey:@"phone"] : @"";
    model.shopImages = [dic objectForKey:@"shopImages"] != [NSNull null] ? [dic objectForKey:@"shopImages"] : @"";
    model.endTime = [dic objectForKey:@"endTime"] != [NSNull null] ? [dic objectForKey:@"endTime"] : @"";

    model.commentNickName = [dic objectForKey:@"commentNickName"] != [NSNull null] ? [dic objectForKey:@"commentNickName"] : @"";
    model.commentContent = [dic objectForKey:@"commentContent"] != [NSNull null] ? [dic objectForKey:@"commentContent"] : @"";

    model.objectType = [dic objectForKey:@"objectType"] != [NSNull null] ? [[dic objectForKey:@"objectType"] boolValue] : 0;

    model.row = [dic objectForKey:@"row"] != [NSNull null] ? [[dic objectForKey:@"row"] boolValue] : 0;

    model.imageName = [dic objectForKey:@"imageName"] != [NSNull null] ? [dic objectForKey:@"imageName"] : @"";
    model.endTimeStr = [dic objectForKey:@"endTimeStr"] != [NSNull null] ? [dic objectForKey:@"endTimeStr"] : @"";
    model.title = [dic objectForKey:@"title"] != [NSNull null] ? [dic objectForKey:@"title"] : @"";
    model.address = [dic objectForKey:@"address"] != [NSNull null] ? [dic objectForKey:@"address"] : @"";
    model.shopName = [dic objectForKey:@"shopName"] != [NSNull null] ? [dic objectForKey:@"shopName"] : @"";
    model.shopLogo = [dic objectForKey:@"shopLogo"] != [NSNull null] ? [dic objectForKey:@"shopLogo"] : @"";
    model.beginTimeStr = [dic objectForKey:@"beginTimeStr"] != [NSNull null] ? [dic objectForKey:@"beginTimeStr"] : @"";

    model.image = [dic objectForKey:@"image"] != [NSNull null] ? [dic objectForKey:@"image"] : @"";
    model.content = [dic objectForKey:@"content"] != [NSNull null] ? [dic objectForKey:@"content"] : @"";
    model.hitNum = [dic objectForKey:@"hitNum"] != [NSNull null] ? [[dic objectForKey:@"hitNum"] integerValue] : 0;
    model.replyNum = [dic objectForKey:@"replyNum"] != [NSNull null] ? [[dic objectForKey:@"replyNum"] integerValue] : 0;
    model.isTop = [dic objectForKey:@"isTop"] != [NSNull null] ? [[dic objectForKey:@"isTop"] integerValue] : 0;
    model.status = [dic objectForKey:@"status"] != [NSNull null] ? [[dic objectForKey:@"status"] integerValue] : 0;
    model.activityStatus = [dic objectForKey:@"activityStatus"] != [NSNull null] ? [[dic objectForKey:@"activityStatus"] integerValue] : 0;

    model.joinNum = [dic objectForKey:@"joinNum"] != [NSNull null] ? [[dic objectForKey:@"joinNum"] integerValue] : 0;
    model.phone = [dic objectForKey:@"phone"] != [NSNull null] ? [dic objectForKey:@"phone"] : @"";
    model.shopImages = [dic objectForKey:@"shopImages"] != [NSNull null] ? [dic objectForKey:@"shopImages"] : @"";
    model.endTime = [dic objectForKey:@"endTime"] != [NSNull null] ? [dic objectForKey:@"endTime"] : @"";

    model.commentNickName = [dic objectForKey:@"commentNickName"] != [NSNull null] ? [dic objectForKey:@"commentNickName"] : @"";
    model.commentContent = [dic objectForKey:@"commentContent"] != [NSNull null] ? [dic objectForKey:@"commentContent"] : @"";

    model.objectType = [dic objectForKey:@"objectType"] != [NSNull null] ? [[dic objectForKey:@"objectType"] boolValue] : 0;

    NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    model.activityApplyList = [dic objectForKey:@"activityApplyList"];
    if ([model.activityApplyList isKindOfClass:[NSArray class]]) {
        for (id data in model.activityApplyList) {
            [dataArray addObject:[ActivityListModel JsonParse:data]];
        }
    }
    model.activityApplyList = dataArray;

    return model;
}

@end
