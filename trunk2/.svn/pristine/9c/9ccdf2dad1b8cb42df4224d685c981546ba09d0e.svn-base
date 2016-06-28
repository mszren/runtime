//
//  GrounpInfoModel.m
//  Common
//
//  Created by 我 on 15/8/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GrounpInfoModel.h"

@implementation GrounpInfoModel

#pragma mark
#pragma mark -- initialization
- (id)copyWithZone:(NSZone*)zone
{
    GrounpInfoModel* copy = [[[self class] allocWithZone:zone] init];
    copy.groupId = [self.groupId copy];
    copy.groupImageUrl = [self.groupImageUrl copy];
    copy.groupDescription = [self.groupDescription copy];
    copy.groupName = [self.groupName copy];
    copy.name = [self.name copy];
    copy.phone = [self.phone copy];
    copy.redPacketNumber = [self.redPacketNumber copy];
    copy.roomIds = [self.roomIds copy];
    copy.totalCount = [self.totalCount copy];
    copy.totalPrice = [self.totalPrice copy];
    copy.creationDate = [self.creationDate copy];
    copy.count = self.count;
    copy.naturalName = [self.naturalName copy];
    copy.memberNumber = self.memberNumber;
    copy.group_image_url = [self.group_image_url copy];
    copy.roomID = self.roomID;
    copy.applyNumer = self.applyNumer;
    copy.mucMembers = [self.mucMembers copy];
    copy.face = [self.face copy];
    copy.nickname = [self.nickname copy];
    copy.user_id = self.user_id;
    copy.username = [self.username copy];
    return copy;
}



- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.groupId forKey:@"groupId"];
    [aCoder encodeObject:self.groupDescription forKey:@"groupDescription"];
    [aCoder encodeObject:self.groupImageUrl forKey:@"groupImageUrl"];
    [aCoder encodeObject:self.groupName forKey:@"groupName"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.redPacketNumber forKey:@"redPacketNumber"];
    [aCoder encodeObject:self.roomIds forKey:@"roomIds"];
    [aCoder encodeObject:self.totalCount forKey:@"totalCount"];
    [aCoder encodeObject:self.totalPrice forKey:@"totalPrice"];
    
    [aCoder encodeObject:self.creationDate forKey:@"creationDate"];
    [aCoder encodeInteger:self.count forKey:@"count"];
    [aCoder encodeObject:self.naturalName forKey:@"naturalName"];
    
    [aCoder encodeInteger:self.memberNumber forKey:@"memberNumber"];
    [aCoder encodeObject:self.group_image_url forKey:@"group_image_url"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeInteger:self.applyNumer forKey:@"applyNumer"];
    [aCoder encodeInteger:self.roomID forKey:@"roomID"];
    [aCoder encodeObject:self.mucMembers forKey:@"mucMembers"];
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeInteger:self.user_id forKey:@"user_id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.groupId = [aDecoder decodeObjectForKey:@"groupId"];
        self.groupDescription = [aDecoder decodeObjectForKey:@"groupDescription"];
        self.groupImageUrl = [aDecoder decodeObjectForKey:@"groupImageUrl"];
        self.groupName = [aDecoder decodeObjectForKey:@"groupName"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.redPacketNumber = [aDecoder decodeObjectForKey:@"redPacketNumber"];
        self.roomIds = [aDecoder decodeObjectForKey:@"roomIds"];
        self.totalCount = [aDecoder decodeObjectForKey:@"totalCount"];
        self.totalPrice = [aDecoder decodeObjectForKey:@"totalPrice"];
        
        self.creationDate = [aDecoder decodeObjectForKey:@"creationDate"];
        self.count = [aDecoder decodeIntegerForKey:@"count"];
        self.naturalName = [aDecoder decodeObjectForKey:@"naturalName"];
        
        self.memberNumber = [aDecoder decodeIntegerForKey:@"memberNumber"];
        self.group_image_url = [aDecoder decodeObjectForKey:@"group_image_url"];
        
        self.roomID = [aDecoder decodeIntegerForKey:@"roomID"];
        self.applyNumer = [aDecoder decodeIntegerForKey:@"applyNumer"];
        self.mucMembers = [aDecoder decodeObjectForKey:@"mucMembers"];
        self.face = [aDecoder decodeObjectForKey:@"face"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.user_id = [aDecoder decodeIntegerForKey:@"user_id"];
        
    }
    return self;
}

#pragma mark
#pragma mark --  json parse
+ (GrounpInfoModel *)JsonParse:(NSDictionary *)dic{
    GrounpInfoModel * model= [[GrounpInfoModel alloc] init];
    
    model.groupId = [dic objectForKey:@"groupId"] != [NSNull null] ? [dic objectForKey:@"groupId"]  : @"";
    model.groupDescription = [dic objectForKey:@"description"]!= [NSNull null] ? [dic objectForKey:@"description"] : @"";
    model.groupImageUrl = [dic objectForKey:@"groupImageUrl"]!= [NSNull null] ? [dic objectForKey:@"groupImageUrl"] : @"";
    model.groupName = [dic objectForKey:@"groupName"]!= [NSNull null] ? [dic objectForKey:@"groupName"] : @"";
    model.name = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.phone = [dic objectForKey:@"phone"]!= [NSNull null] ? [dic objectForKey:@"phone"] : @"";
    model.redPacketNumber = [dic objectForKey:@"redPacketNumber"]!= [NSNull null] ? [dic objectForKey:@"redPacketNumber"] : @"";
    model.roomIds = [dic objectForKey:@"roomIds"]!= [NSNull null] ? [dic objectForKey:@"roomIds"] : @"";
    model.totalCount = [dic objectForKey:@"totalCount"]!= [NSNull null] ? [dic objectForKey:@"totalCount"] : @"";
    model.totalPrice = [dic objectForKey:@"totalPrice"]!= [NSNull null] ? [dic objectForKey:@"totalPrice"] : @"";
    
    model.creationDate = [dic objectForKey:@"creationDate"]!= [NSNull null] ? [dic objectForKey:@"creationDate"] : @"";
    model.count = [dic objectForKey:@"count"]!= [NSNull null] ? [[dic objectForKey:@"count"] integerValue ]: 0;
    
    model.memberNumber = [dic objectForKey:@"memberNumber"]!= [NSNull null] ? [[dic objectForKey:@"memberNumber"] integerValue ]: 0;
    
    model.group_image_url = [dic objectForKey:@"group_image_url"]!= [NSNull null] ? [dic objectForKey:@"group_image_url"] : @"";
    model.naturalName = [dic objectForKey:@"naturalName"]!= [NSNull null] ? [dic objectForKey:@"naturalName"] : @"";
    
    model.roomID = [dic objectForKey:@"roomID"]!= [NSNull null] ? [[dic objectForKey:@"roomID"] integerValue ]: 0;
    model.applyNumer = [dic objectForKey:@"applyNumer"]!= [NSNull null] ? [[dic objectForKey:@"applyNumer"] integerValue ]: 0;
    model.user_id = [dic objectForKey:@"user_id"]!= [NSNull null] ? [[dic objectForKey:@"user_id"] integerValue ]: 0;
    model.mucMembers = [dic objectForKey:@"mucMembers"]!= [NSNull null] ? [dic objectForKey:@"mucMembers"] : @"";
    model.face = [dic objectForKey:@"face"]!= [NSNull null] ? [dic objectForKey:@"face"] : @"";
    model.nickname = [dic objectForKey:@"nickname"]!= [NSNull null] ? [dic objectForKey:@"nickname"] : @"";
    model.username = [dic objectForKey:@"username"]!= [NSNull null] ? [dic objectForKey:@"username"] : @"";
    
    NSMutableArray* mucMembers=[dic objectForKey:@"mucMembers"];
    NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (mucMembers) {
        for(id data in mucMembers){
            [dataArray addObject:[GrounpInfoModel JsonParse:data]];
        }
        model.mucMembers=dataArray;
    }
    
    return model;
}

@end
