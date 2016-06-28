//
//  UserMessageModel.m
//  Common
//
//  Created by 曹亮 on 15/3/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "User.h"
#import "GroupModel.h"
#import "UserMessageModel.h"

@implementation UserMessageModel

@synthesize userMessageId = _userMessageId;

@synthesize name = _name;
@synthesize nick = _nick;
@synthesize room_nick = _room_nick;
@synthesize face = _face;
@synthesize content = _content;
@synthesize time = _time;
@synthesize num = _num;
@synthesize type = _type;
@synthesize msg_type = _msg_type;
@synthesize msg_bg = _msg_bg;
@synthesize is_failure = _is_failure;
@synthesize is_exit = _is_exit;
@synthesize is_remind = _is_remind;
@synthesize is_friends = _is_friends;
@synthesize creator = _creator;
@synthesize position = _position;


#pragma mark
#pragma mark -- initialization
-(id)init{
    self=[super init];
    if (self) {
    }
    return self;
}

Parse_Chat_State_Method
Parse_Chat_Type_Method
Parse_Chat_Info_Type_Method

- (id) initWithDictionary:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        self.userMessageId = [dic objectForKey:@"id"] != [NSNull null] ? [[dic objectForKey:@"id"] integerValue] : INT32_MAX;
        self.name = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
        self.nick = [dic objectForKey:@"nick"]!= [NSNull null] ? [dic objectForKey:@"nick"] : @"";
        self.room_nick = [dic objectForKey:@"room_nick"]!= [NSNull null] ? [dic objectForKey:@"room_nick"] : @"";
        self.face = [dic objectForKey:@"face"]!= [NSNull null] ? [dic objectForKey:@"face"] : @"";
        self.content = [dic objectForKey:@"content"] != [NSNull null] ? [dic objectForKey:@"content"] : @"";
        self.time = [dic objectForKey:@"time"]!= [NSNull null] ? [dic objectForKey:@"time"] : @"";
        self.num = [dic objectForKey:@"num"]!= [NSNull null] ? [dic objectForKey:@"num"] : @"";
        self.type = [self parseChatType:[dic objectForKey:@"type"]!= [NSNull null] ? [[dic objectForKey:@"type"] integerValue] : 0];
        self.msg_type = [self parseChatInfoType:[dic objectForKey:@"msg_type"]!= [NSNull null] ? [[dic objectForKey:@"msg_type"] integerValue] : 0];
        self.msg_bg = [dic objectForKey:@"msg_bg"]!= [NSNull null] ? [dic objectForKey:@"msg_bg"] : @"";
        self.is_failure = [dic objectForKey:@"is_failure"] != [NSNull null] ? [dic objectForKey:@"is_failure"]  : @"";
        self.is_exit = [dic objectForKey:@"is_exit"]!= [NSNull null] ? [dic objectForKey:@"is_exit"] : @"";
        self.is_remind = [dic objectForKey:@"is_remind"]!= [NSNull null] ? [dic objectForKey:@"is_remind"] : @"";
        self.is_friends = [dic objectForKey:@"is_friends"]!= [NSNull null] ? [dic objectForKey:@"is_friends"] : @"";
        self.creator = [dic objectForKey:@"creator"]!= [NSNull null] ? [dic objectForKey:@"creator"] : @"";
        self.position = [dic objectForKey:@"position"]!= [NSNull null] ? [dic objectForKey:@"position"] : @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.userMessageId forKey:@"userMessageId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nick forKey:@"nick"];
    [aCoder encodeObject:self.room_nick forKey:@"room_nick"];
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.num forKey:@"num"];
    
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeInteger:self.msg_type forKey:@"msg_type"];
    [aCoder encodeObject:self.msg_bg forKey:@"msg_bg"];
    [aCoder encodeObject:self.is_failure forKey:@"is_failure"];
    [aCoder encodeObject:self.is_exit forKey:@"is_exit"];
    [aCoder encodeObject:self.is_remind forKey:@"is_remind"];
    [aCoder encodeObject:self.is_friends forKey:@"is_friends"];
    [aCoder encodeObject:self.creator forKey:@"creator"];
    [aCoder encodeObject:self.position forKey:@"position"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.userMessageId = [aDecoder decodeInt64ForKey:@"userMessageId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nick = [aDecoder decodeObjectForKey:@"nick"];
        self.room_nick = [aDecoder decodeObjectForKey:@"room_nick"];
        self.face = [aDecoder decodeObjectForKey:@"face"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.num = [aDecoder decodeObjectForKey:@"num"];
        
        self.type = [self parseChatType:[aDecoder decodeIntegerForKey:@"type"]];
        self.msg_type = [self parseChatInfoType:[aDecoder decodeIntegerForKey:@"msg_type"]];
        self.msg_bg = [aDecoder decodeObjectForKey:@"msg_bg"];
        self.is_failure = [aDecoder decodeObjectForKey:@"is_failure"];
        self.is_exit = [aDecoder decodeObjectForKey:@"is_exit"];
        self.is_remind = [aDecoder decodeObjectForKey:@"is_remind"];
        self.is_friends = [aDecoder decodeObjectForKey:@"is_friends"];
        self.creator = [aDecoder decodeObjectForKey:@"creator"];
        self.position = [aDecoder decodeObjectForKey:@"position"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"userMessageId= %ld  , name=%@ , nick=%@ , room_nick = %@ , face =%@,content= %@  , time=%@ , num=%@ ",(long)self.userMessageId,self.name,self.nick,self.room_nick,self.face,self.content,self.time,self.num];
}
#pragma mark
#pragma mark --  json parse
+ (UserMessageModel *)JsonParse:(NSDictionary *)dic{
    UserMessageModel * model= [[UserMessageModel alloc] init];
    
    model.nick = [dic objectForKey:@"name"]!= [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.content = [dic objectForKey:@"body"]!= [NSNull null] ? [dic objectForKey:@"body"] : @"";
    model.time = [dic objectForKey:@"time"]!= [NSNull null] ? [dic objectForKey:@"time"] : @"";
    
    NSString * chatType = [dic objectForKey:@"chatType"]!= [NSNull null] ? [dic objectForKey:@"chatType"] : @"chat";
    if ([chatType isEqualToString:@"chat"]) {
        model.type = CHATTYPE_CHAT;
    }else{
        model.type = CHATTYPE_GROUP;
    }
    
    NSDictionary * chatInfoTypeDic = [dic objectForKey:@"fil"]!= [NSNull null] ? [dic objectForKey:@"fil"] : nil;
    
    if (chatInfoTypeDic) {
        NSString * chatInfoType = [chatInfoTypeDic objectForKey:@"file_ext"]!= [NSNull null] ? [chatInfoTypeDic objectForKey:@"file_ext"] : @"nml";
        model.msg_type = [MessageInfoModel parseToChatInfoType:chatInfoType];
    }else{
        NSString * chatInfoTypeStr = [dic objectForKey:@"type"]!= [NSNull null] ? [dic objectForKey:@"type"] : @"nml";
        model.msg_type = [MessageInfoModel parseToChatInfoType:chatInfoTypeStr];
    }
    
    if (model.type == CHATTYPE_CHAT) {
        model.name = [dic objectForKey:@"login"]!= [NSNull null] ? [dic objectForKey:@"login"] : @"";
        model.face = [dic objectForKey:@"face"]!= [NSNull null] ? [dic objectForKey:@"face"] : @"";
        
        //bfd
        if (model.msg_type == CHATINFO_BFD) {
            model.name = [dic objectForKey:@"groupUserName"];
            model.is_friends = @"0";
        }else if (model.msg_type == CHATINFO_YFM){//同意好友
            model.name = [dic objectForKey:@"groupUserName"];
            model.is_friends = @"1";
        }
    }else{
        model.name = [dic objectForKey:@"groupUserName"]!= [NSNull null] ? [dic objectForKey:@"groupUserName"] : @"";
        model.room_nick = [dic objectForKey:@"naturalname"]!= [NSNull null] ? [dic objectForKey:@"naturalname"] : @"";
        model.face = [dic objectForKey:@"groupFace"]!= [NSNull null] ? [dic objectForKey:@"groupFace"] : @"";
    }
    model.num = @"0";
    return model;
}
#pragma mark
#pragma mark -- UserMessageModel parse
+ (UserMessageModel *)parseWithMessageInfoModel:(MessageInfoModel *)messageInfoModel{
    UserMessageModel * model= [[UserMessageModel alloc] init];
    
    model.content = messageInfoModel.content;
    model.time = messageInfoModel.time;
    model.type = messageInfoModel.chatType;
    model.msg_type = messageInfoModel.chatInfoType;
    model.name = messageInfoModel.groupName;
    model.nick = messageInfoModel.toUser.nickname;
    if (model.type == CHATTYPE_CHAT) {
        model.face = messageInfoModel.toUser.face;
    }else{
        model.face = messageInfoModel.groupFace;
        model.room_nick = messageInfoModel.groupNickName;
    }

    return model;
}

+ (UserMessageModel *)parseWithGroupModel:(GroupModel *) groupModel
{
    UserMessageModel * model= [[UserMessageModel alloc] init];

    model.type = CHATTYPE_GROUP;
    model.name = groupModel.name;
    model.nick = groupModel.groupName;
    model.face = groupModel.groupImageUrl;;
    model.room_nick = groupModel.groupName;;
    return model;

}

#pragma mark
#pragma mark -- change to user or group model
- (User *) changeToUser
{
    User * user = [[User alloc] init];
    user.username = self.name;
    user.nickname = self.nick;
    user.face = self.face;
    
    return user;
}




@end
