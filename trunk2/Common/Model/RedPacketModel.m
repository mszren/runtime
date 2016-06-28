//
//  RedPacketModel.m
//  Common
//
//  Created by 曹亮 on 15/4/11.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RedPacketModel.h"

@implementation RedPacketModel

@synthesize sumRPC = _sumRPC;
@synthesize nickname = _nickname;
@synthesize sumAlreadyRPC = _sumAlreadyRPC;
@synthesize groupLogo = _groupLogo;
@synthesize received_count = _received_count;
@synthesize naturalName = _naturalName;
@synthesize total_prize = _total_prize;
@synthesize roomID = _roomID;
@synthesize red_packet_id = _red_packet_id;
@synthesize received_prize = _received_prize;

@synthesize creationDate = _creationDate;
@synthesize rownum = _rownum;
@synthesize username = _username;

@synthesize total_num = _total_num;
@synthesize end_time = _end_time;
@synthesize start_time = _start_time;

@synthesize user_id = _user_id;
@synthesize red_packet_desc = _red_packet_desc;
@synthesize config_time = _config_time;


#pragma mark
#pragma mark -- initialization
-(id)init{
    self=[super init];
    if (self) {
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.sumRPC forKey:@"sumRPC"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.sumAlreadyRPC forKey:@"sumAlreadyRPC"];
    [aCoder encodeObject:self.groupLogo forKey:@"groupLogo"];
    [aCoder encodeObject:self.received_count forKey:@"received_count"];
    [aCoder encodeObject:self.naturalName forKey:@"naturalName"];
    
    [aCoder encodeObject:self.total_prize forKey:@"total_prize"];
    [aCoder encodeObject:self.roomID forKey:@"roomID"];
    [aCoder encodeObject:self.red_packet_id forKey:@"red_packet_id"];
    [aCoder encodeObject:self.received_prize forKey:@"received_prize"];
    
    [aCoder encodeObject:self.creationDate forKey:@"creationDate"];
    [aCoder encodeObject:self.rownum forKey:@"rownum"];
    [aCoder encodeObject:self.username forKey:@"username"];
    
    [aCoder encodeObject:self.total_num forKey:@"total_num"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
    [aCoder encodeObject:self.start_time forKey:@"start_time"];
    
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.red_packet_desc forKey:@"red_packet_desc"];
    [aCoder encodeObject:self.config_time forKey:@"config_time"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.sumRPC = [aDecoder decodeObjectForKey:@"sumRPC"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.sumAlreadyRPC = [aDecoder decodeObjectForKey:@"sumAlreadyRPC"];
        self.groupLogo = [aDecoder decodeObjectForKey:@"groupLogo"];
        self.received_count = [aDecoder decodeObjectForKey:@"received_count"];
        self.naturalName = [aDecoder decodeObjectForKey:@"naturalName"];
        
        self.total_prize = [aDecoder decodeObjectForKey:@"total_prize"];
        self.roomID = [aDecoder decodeObjectForKey:@"roomID"];
        self.red_packet_id = [aDecoder decodeObjectForKey:@"red_packet_id"];
        self.received_prize = [aDecoder decodeObjectForKey:@"received_prize"];
        
        self.creationDate = [aDecoder decodeObjectForKey:@"creationDate"];
        self.rownum = [aDecoder decodeObjectForKey:@"rownum"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        
        self.total_num = [aDecoder decodeObjectForKey:@"total_num"];
        self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
        self.start_time = [aDecoder decodeObjectForKey:@"start_time"];
        
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.red_packet_desc = [aDecoder decodeObjectForKey:@"red_packet_desc"];
        self.config_time = [aDecoder decodeObjectForKey:@"config_time"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"sumRPC= %@ , nickname=%@ , sumAlreadyRPC=%@ , groupLogo=%@ , received_count = %@ , naturalName =%@, total_prize =%@, roomID =%@, red_packet_id =%@, received_prize =%@, creationDate =%@, rownum =%@, username =%@ ,total_num =%@, end_time =%@, start_time =%@,user_id =%@, red_packet_desc =%@, config_time =%@",self.sumRPC,self.nickname,self.sumAlreadyRPC,self.groupLogo,self.received_count,self.naturalName,self.total_prize,self.roomID,self.red_packet_id,self.received_prize,self.creationDate,self.rownum,self.username,self.total_num,self.end_time,self.start_time,self.user_id,self.red_packet_desc,self.config_time];
}
#pragma mark
#pragma mark --  json parse
+ (RedPacketModel *)JsonParse:(NSDictionary *)dic{
    RedPacketModel * model= [[RedPacketModel alloc] init];
    
    model.sumRPC = [dic objectForKey:@"sumRPC"] != [NSNull null] ? [dic objectForKey:@"sumRPC"]  : @"";
    model.nickname = [dic objectForKey:@"nickname"]!= [NSNull null] ? [dic objectForKey:@"nickname"] : @"";
    model.sumAlreadyRPC = [dic objectForKey:@"sumAlreadyRPC"]!= [NSNull null] ? [dic objectForKey:@"sumAlreadyRPC"] : @"";
    model.groupLogo = [dic objectForKey:@"groupLogo"]!= [NSNull null] ? [dic objectForKey:@"groupLogo"] : @"";
    model.received_count = [dic objectForKey:@"received_count"]!= [NSNull null] ? [dic objectForKey:@"received_count"] : @"";
    model.naturalName = [dic objectForKey:@"naturalName"]!= [NSNull null] ? [dic objectForKey:@"naturalName"] : @"";
    model.total_prize = [dic objectForKey:@"total_prize"]!= [NSNull null] ? [dic objectForKey:@"total_prize"] : @"";
    model.roomID = [dic objectForKey:@"roomID"]!= [NSNull null] ? [dic objectForKey:@"roomID"] : @"";
    model.red_packet_id = [dic objectForKey:@"red_packet_id"]!= [NSNull null] ? [dic objectForKey:@"red_packet_id"] : @"";
    model.received_prize = [dic objectForKey:@"received_prize"]!= [NSNull null] ? [dic objectForKey:@"received_prize"] : @"";
    
    model.creationDate = [dic objectForKey:@"creationDate"]!= [NSNull null] ? [dic objectForKey:@"creationDate"] : @"";
    model.rownum = [dic objectForKey:@"rownum"]!= [NSNull null] ? [dic objectForKey:@"rownum"] : @"";
    model.username = [dic objectForKey:@"username"]!= [NSNull null] ? [dic objectForKey:@"username"] : @"";
    model.total_num = [dic objectForKey:@"total_num"]!= [NSNull null] ? [dic objectForKey:@"total_num"] : @"";
    model.end_time = [dic objectForKey:@"end_time"]!= [NSNull null] ? [dic objectForKey:@"end_time"] : @"";
    model.start_time = [dic objectForKey:@"start_time"]!= [NSNull null] ? [dic objectForKey:@"start_time"] : @"";
    model.user_id = [dic objectForKey:@"user_id"]!= [NSNull null] ? [dic objectForKey:@"user_id"] : @"";
    model.red_packet_desc = [dic objectForKey:@"red_packet_desc"]!= [NSNull null] ? [dic objectForKey:@"red_packet_desc"] : @"";
    model.config_time = [dic objectForKey:@"config_time"]!= [NSNull null] ? [dic objectForKey:@"config_time"] : @"";
    
    return model;
}

@end
