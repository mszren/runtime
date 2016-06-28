//
//  GroupModel.m
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

@synthesize groupId = _groupId;
@synthesize groupDescription = _groupDescription;
@synthesize groupImageUrl = _groupImageUrl;
@synthesize groupName = _groupName;
@synthesize name = _name;
@synthesize phone = _phone;
@synthesize redPacketNumber = _redPacketNumber;
@synthesize roomIds = _roomIds;
@synthesize totalCount = _totalCount;
@synthesize totalPrice = _totalPrice;

@synthesize creationDate = _creationDate;
@synthesize count = _count;
@synthesize naturalName = _naturalName;

@synthesize description = _description;
@synthesize roomID = _roomID;
@synthesize group_image_url = _group_image_url;
@synthesize memberNumber = _memberNumber;
@synthesize groupLogo = _groupLogo;
#pragma mark
#pragma mark -- initialization
-(id)init{
    self=[super init];
    if (self) {
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        self.groupId = [dic objectForKey:@"groupId"] != [NSNull null] ? [dic objectForKey:@"groupId"]  : @"";
        self.groupDescription = [dic objectForKey:@"groupDescription"]!= [NSNull null] ? [dic objectForKey:@"groupDescription"] : @"";
        self.groupLogo = [dic objectForKey:@"groupLogo"]!= [NSNull null] ? [dic objectForKey:@"groupLogo"] : @"";
        self.groupImageUrl = [dic objectForKey:@"groupImageUrl"]!= [NSNull null] ? [dic objectForKey:@"groupImageUrl"] : @"";
        self.groupName = [dic objectForKey:@"groupName"]!= [NSNull null] ? [dic objectForKey:@"groupName"] : @"";
        self.name = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
        self.phone = [dic objectForKey:@"phone"]!= [NSNull null] ? [dic objectForKey:@"phone"] : @"";
        self.redPacketNumber = [dic objectForKey:@"redPacketNumber"] != [NSNull null] ? [dic objectForKey:@"redPacketNumber"] : @"";
        self.roomIds = [dic objectForKey:@"roomIds"]!= [NSNull null] ? [dic objectForKey:@"roomIds"] : @"";
        self.totalCount = [dic objectForKey:@"totalCount"]!= [NSNull null] ? [dic objectForKey:@"totalCount"] : @"";
        self.totalPrice = [dic objectForKey:@"totalPrice"]!= [NSNull null] ? [dic objectForKey:@"totalPrice"] : @"";
        
        self.creationDate = [dic objectForKey:@"creationDate"]!= [NSNull null] ? [dic objectForKey:@"creationDate"] : @"";
        self.count = [dic objectForKey:@"count"]!= [NSNull null] ? [dic objectForKey:@"count"] : @"";
        self.naturalName = [dic objectForKey:@"naturalName"]!= [NSNull null] ? [dic objectForKey:@"naturalName"] : @"";
        self.group_image_url = [dic objectForKey:@"group_image_url"]!= [NSNull null] ? [dic objectForKey:@"group_image_url"] : @"";
        self.memberNumber = [dic objectForKey:@"memberNumber"]!= [NSNull null] ? [dic objectForKey:@"memberNumber"] : @"";
        
        self.roomID = [dic objectForKey:@"roomID"]!= [NSNull null] ? [[dic objectForKey:@"roomID"] integerValue ]: 0;
        self.applyNumer = [dic objectForKey:@"applyNumer"]!= [NSNull null] ? [[dic objectForKey:@"applyNumer"] integerValue ]: 0;
    }
    return self;
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
    [aCoder encodeObject:self.count forKey:@"count"];
    [aCoder encodeObject:self.naturalName forKey:@"naturalName"];
    
    [aCoder encodeObject:self.memberNumber forKey:@"memberNumber"];
    [aCoder encodeObject:self.group_image_url forKey:@"group_image_url"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeInteger:self.applyNumer forKey:@"applyNumer"];
    [aCoder encodeInteger:self.roomID forKey:@"roomID"];
    [aCoder encodeObject:self.groupLogo forKey:@"groupLogo"];
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
        self.count = [aDecoder decodeObjectForKey:@"count"];
        self.naturalName = [aDecoder decodeObjectForKey:@"naturalName"];
        
        self.memberNumber = [aDecoder decodeObjectForKey:@"memberNumber"];
        self.group_image_url = [aDecoder decodeObjectForKey:@"group_image_url"];
        
        self.roomID = [aDecoder decodeIntegerForKey:@"roomID"];
        self.applyNumer = [aDecoder decodeIntegerForKey:@"applyNumer"];
        self.groupLogo = [aDecoder decodeObjectForKey:@"groupLogo"];
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"groupId= %@ , description=%@ , groupImageUrl=%@ , groupName=%@ , name = %@ , phone =%@, redPacketNumber =%@, roomIds =%@, totalCount =%@, totalPrice =%@, creationDate =%@, count =%@, naturalName =%@,group_image_url = %@,roomID = %d,applyNumer = %d,  _groupLogo = %@",_groupId,_groupImageUrl,_groupName,_name,_phone,_redPacketNumber,_roomIds,_totalCount,_totalPrice,_creationDate,_count,_naturalName,_description,_group_image_url,_roomID,_applyNumer,_groupLogo];
}

#pragma mark
#pragma mark --  json parse
+ (GroupModel *)JsonParse:(NSDictionary *)dic{
    GroupModel * model= [[GroupModel alloc] init];
    
    model.groupId = [dic objectForKey:@"groupId"] != [NSNull null] ? [dic objectForKey:@"groupId"]  : @"";
    model.groupDescription = [dic objectForKey:@"description"]!= [NSNull null] ? [dic objectForKey:@"description"] : @"";
    model.groupLogo = [dic objectForKey:@"groupLogo"]!= [NSNull null] ? [dic objectForKey:@"groupLogo"] : @"";
    model.groupImageUrl = [dic objectForKey:@"groupImageUrl"]!= [NSNull null] ? [dic objectForKey:@"groupImageUrl"] : @"";
    model.groupName = [dic objectForKey:@"groupName"]!= [NSNull null] ? [dic objectForKey:@"groupName"] : @"";
    model.name = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.phone = [dic objectForKey:@"phone"]!= [NSNull null] ? [dic objectForKey:@"phone"] : @"";
    model.redPacketNumber = [dic objectForKey:@"redPacketNumber"]!= [NSNull null] ? [dic objectForKey:@"redPacketNumber"] : @"";
    model.roomIds = [dic objectForKey:@"roomIds"]!= [NSNull null] ? [dic objectForKey:@"roomIds"] : @"";
    model.totalCount = [dic objectForKey:@"totalCount"]!= [NSNull null] ? [dic objectForKey:@"totalCount"] : @"";
    model.totalPrice = [dic objectForKey:@"totalPrice"]!= [NSNull null] ? [dic objectForKey:@"totalPrice"] : @"";
    
    model.creationDate = [dic objectForKey:@"creationDate"]!= [NSNull null] ? [dic objectForKey:@"creationDate"] : @"";
    model.count = [dic objectForKey:@"count"]!= [NSNull null] ? [dic objectForKey:@"count"] : @"";
    
    model.memberNumber = [dic objectForKey:@"memberNumber"]!= [NSNull null] ? [dic objectForKey:@"memberNumber"] : @"";
    
    model.group_image_url = [dic objectForKey:@"group_image_url"]!= [NSNull null] ? [dic objectForKey:@"group_image_url"] : @"";
    
    model.groupLogo = [dic objectForKey:@"groupLogo"]!= [NSNull null] ? [dic objectForKey:@"groupLogo"] : @"";
    
    
    model.roomID = [dic objectForKey:@"roomID"]!= [NSNull null] ? [[dic objectForKey:@"roomID"] integerValue ]: 0;
    model.applyNumer = [dic objectForKey:@"applyNumer"]!= [NSNull null] ? [[dic objectForKey:@"applyNumer"] integerValue ]: 0;
    
    if ([dic objectForKey:@"groupLogo"]) {
        model.groupImageUrl = [dic objectForKey:@"groupLogo"];
    }
    
    if ([dic objectForKey:@"roomID"]) {
        model.groupId = [dic objectForKey:@"roomID"];
    }
    
    if ([dic objectForKey:@"naturalName"]) {
        model.groupName = [dic objectForKey:@"naturalName"];
    }
    
    if ([dic objectForKey:@"naturalName"]) {
        model.groupName = [dic objectForKey:@"naturalName"];
    }
    return model;
}

+ (GroupModel *)JsonInfoParse:(NSDictionary *)dic{
    GroupModel * model= [[GroupModel alloc] init];
    
    model.groupId = [dic objectForKey:@"roomID"] != [NSNull null] ? [dic objectForKey:@"roomID"]  : @"";
    model.groupDescription = [dic objectForKey:@"description"]!= [NSNull null] ? [dic objectForKey:@"description"] : @"";
    model.groupImageUrl = [dic objectForKey:@"group_image_url"]!= [NSNull null] ? [dic objectForKey:@"groupLogo"] : @"";
        model.groupLogo = [dic objectForKey:@"groupLogo"]!= [NSNull null] ? [dic objectForKey:@"group_image_url"] : @"";
    model.creationDate = [dic objectForKey:@"creationDate"]!= [NSNull null] ? [dic objectForKey:@"creationDate"] : @"";
    model.groupName = [dic objectForKey:@"naturalName"]!= [NSNull null] ? [dic objectForKey:@"naturalName"] : @"";
    model.name = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.count = [dic objectForKey:@"count"]!= [NSNull null] ? [dic objectForKey:@"count"] : @"";
    model.memberNumber = [dic objectForKey:@"memberNumber"]!= [NSNull null] ? [dic objectForKey:@"memberNumber"] : @"";

    model.group_image_url = [dic objectForKey:@"group_image_url"]!= [NSNull null] ? [dic objectForKey:@"group_image_url"] : @"";
 
    
    model.roomID = [dic objectForKey:@"roomID"]!= [NSNull null] ? [[dic objectForKey:@"roomID"] integerValue ]: 0;
    model.applyNumer = [dic objectForKey:@"applyNumer"]!= [NSNull null] ? [[dic objectForKey:@"applyNumer"] integerValue ]: 0;
    
    NSMutableArray * mucOwnersList = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray * mucOwnersListDic = [dic objectForKey:@"mucOwners"];
    for (NSDictionary * dic in mucOwnersListDic) {
        User * aUser = [User JsonParse:dic];
        [mucOwnersList addObject:aUser];
    }
    model.mucOwners = [NSArray arrayWithArray:mucOwnersList];
    
    return model;
}

@end
