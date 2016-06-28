//
//  MessageInfo.m
//  Common
//
//  Created by 曹亮 on 15/3/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "User.h"
#import "MessageInfoModel.h"

@implementation MessageInfoModel

#pragma mark
#pragma mark-- initialization
- (id)init
{
    if ((self = [super init])) {
        self.msgId = 0;
        self.toUser = [[User alloc] init];

        self.time = @"";
        self.content = @"";
        self.imgUrl = @"";
        self.comment = @"";
        self.speaker = 0;
        self.chatType = 0;
        self.receiverName = @"";
        self.state = FAIL;
        self.dontRendCount = 0;
        self.toReceiver = @"";
        self.photo_w = 0.0f; //宽
        self.photo_h = 0.0f; //高
        self.audio_l = 0; //语音长度
        self.temp_id = @"";
        self.isFriend = Stranger;
        self.groupBg = @"";

        self.groupName = @"";
        self.topStep = 0;
        self.newsJson = @"";

        self.videoUrl = @"";

        self.audio_DontRead = 0; //音频是否未读
        self.isToken = 1; //是否接受通知
    }
    return self;
}

- (id)initWithMessageContent:(NSString*)contentStr withType:(CHAT_INFO_TYPE)chatInfoType withToUser:(User*)toUser
{
    self = [self init];
    if (self) {
        self.msgId = 100;
        self.chatInfoType = chatInfoType;
        self.content = contentStr;
        self.time = [NSDate currentTimeByJava];
        self.state = FAIL;

        self.toUser = toUser;
    }
    return self;
}

- (id)initWithXMPPMessageJsonStr:(NSString*)jsonStr
{
    self = [self init];
    if (self) {
        NSData* data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error = nil;

        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

        [self parseSendSubjectDic:dic];
    }
    return self;
}

Parse_Chat_State_Method
        Parse_Chat_Type_Method
            Parse_Chat_Info_Type_Method

    - (id)initWithDictionary : (NSDictionary*)dic
{
    self = [self init];
    if (self) {
        self.msgId = [dic objectForKey:@"id"] != [NSNull null] ? [[dic objectForKey:@"id"] intValue] : 0;

        self.toUser.uid = [dic objectForKey:@"uid"] != [NSNull null] ? [[dic objectForKey:@"uid"] integerValue] : 0;

        self.toUser.nickname = [dic objectForKey:@"nick"] != [NSNull null] ? [dic objectForKey:@"nick"] : @"";
        self.toUser.username = [dic objectForKey:@"name"] != [NSNull null] ? [dic objectForKey:@"name"] : @"";
        self.toUser.face = [dic objectForKey:@"face"] != [NSNull null] ? [dic objectForKey:@"face"] : @"";

        self.chatType = [self parseChatType:[dic objectForKey:@"type"] != [NSNull null] ? [[dic objectForKey:@"type"] integerValue] : 0];
        self.chatInfoType = [self parseChatInfoType:[dic objectForKey:@"chatType"] != [NSNull null] ? [[dic objectForKey:@"chatType"] integerValue] : 0];

        self.time = [dic objectForKey:@"time"] != [NSNull null] ? [dic objectForKey:@"time"] : [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
        self.content = [dic objectForKey:@"content"] != [NSNull null] ? [dic objectForKey:@"content"] : @"";
        self.isSend = [dic objectForKey:@"is_sender"] != [NSNull null] ? [[dic objectForKey:@"is_sender"] integerValue] : 0;

        self.state = [self parseChatState:[dic objectForKey:@"is_failure"] != [NSNull null] ? [[dic objectForKey:@"is_failure"] integerValue] : 0];

        self.subjectStr = [dic objectForKey:@"subject"] != [NSNull null] ? [dic objectForKey:@"subject"] : @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"msgId= %d , toUser.id=%lu, toUser.nickname=%@ , toUser.userName=%@ , toUser.face = %@ , chatType =%d, chatInfoType =%d, time =%@, content =%@, isSend =%lu, state =%d,subjectStr =%@", self.msgId, (unsigned long)self.toUser.uid, self.toUser.nickname, self.toUser.username, self.toUser.face, self.chatType, self.chatInfoType, self.time, self.content, (unsigned long)self.isSend, self.state, self.subjectStr];
}

#pragma mark
#pragma mark--  json parse
+ (MessageInfoModel*)JsonParse:(NSDictionary*)dic
{
    MessageInfoModel* model = [[MessageInfoModel alloc] init];

    model.msgId = [dic objectForKey:@"msgId"] != [NSNull null] ? [[dic objectForKey:@"msgId"] intValue] : 0;

    model.toUser.uid = [dic objectForKey:@"uid"] != [NSNull null] ? [[dic objectForKey:@"uid"] integerValue] : 0;
    model.toUser.nickname = [dic objectForKey:@"name"] != [NSNull null] ? [dic objectForKey:@"name"] : @"";
    model.toUser.username = [dic objectForKey:@"login"] != [NSNull null] ? [dic objectForKey:@"login"] : @"";
    model.toUser.face = [dic objectForKey:@"face"] != [NSNull null] ? [dic objectForKey:@"face"] : @"";

    NSDictionary* chatInfoTypeDic = [dic objectForKey:@"fil"] != [NSNull null] ? [dic objectForKey:@"fil"] : nil;

    if (chatInfoTypeDic) {
        NSString* chatInfoType = [chatInfoTypeDic objectForKey:@"file_ext"] != [NSNull null] ? [chatInfoTypeDic objectForKey:@"file_ext"] : @"nml";
        model.chatInfoType = [MessageInfoModel parseToChatInfoType:chatInfoType];
    }
    else {
        NSString* chatInfoTypeStr = [dic objectForKey:@"type"] != [NSNull null] ? [dic objectForKey:@"type"] : @"nml";
        model.chatInfoType = [MessageInfoModel parseToChatInfoType:chatInfoTypeStr];
    }

    model.content = [dic objectForKey:@"body"] != [NSNull null] ? [dic objectForKey:@"body"] : @"";
    model.time = [dic objectForKey:@"time"] != [NSNull null] ? [dic objectForKey:@"time"] : [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    model.isSend = [dic objectForKey:@"isSend"] != [NSNull null] ? [[dic objectForKey:@"isSend"] integerValue] : 0;

    NSString* chatType = [dic objectForKey:@"chatType"] != [NSNull null] ? [dic objectForKey:@"chatType"] : @"chat";
    if ([chatType isEqualToString:@"chat"]) {
        model.chatType = CHATTYPE_CHAT;
    }
    else {
        model.chatType = CHATTYPE_GROUP;
    }

    if (model.chatType == CHATTYPE_CHAT) {
        model.groupName = model.toUser.username;

        //bfd
        if (model.chatInfoType == CHATINFO_BFD) {
            model.toUser.username = [dic objectForKey:@"groupUserName"];
            model.toUser.isF = 0;
            model.groupName = [dic objectForKey:@"groupUserName"];
        }
        else if (model.chatInfoType == CHATINFO_YFM) { //同意好友
            model.toUser.username = [dic objectForKey:@"groupUserName"];
            model.toUser.isF = 1;
            model.groupName = [dic objectForKey:@"groupUserName"];
        }
    }
    else {
        model.groupFace = [dic objectForKey:@"groupFace"] != [NSNull null] ? [dic objectForKey:@"groupFace"] : @"";
        model.groupNickName = [dic objectForKey:@"naturalname"] != [NSNull null] ? [dic objectForKey:@"naturalname"] : @"";
        model.groupName = [dic objectForKey:@"groupUserName"] != [NSNull null] ? [dic objectForKey:@"groupUserName"] : @"";

        if (model.chatInfoType == CHATINFO_RED) {
            model.subjectStr = [dic objectForKey:@"urlLink"] != [NSNull null] ? [dic objectForKey:@"urlLink"] : @"";
        }
    }
    return model;
}

+ (CHAT_INFO_TYPE)parseToChatInfoType:(NSString*)aStr
{
    if ([aStr isEqualToString:@"pic"]) {
        return CHATINFO_FIL_IMG;
    }
    else if ([aStr isEqualToString:@"aud"]) {
        return CHATINFO_FIL_Voice;
    }
    else if ([aStr isEqualToString:@"mp4"]) {
        return CHATINFO_FIL_Video;
    }
    else if ([aStr isEqualToString:@"bfd"]) {
        return CHATINFO_BFD;
    }
    else if ([aStr isEqualToString:@"yfm"]) {
        return CHATINFO_YFM;
    }
    else if ([aStr isEqualToString:@"red"]) {
        return CHATINFO_RED;
    }
    else {
        return CHATINFO_NML;
    }
}

+ (NSString*)parseToChatInfoTypeStr:(CHAT_INFO_TYPE)chatInfoType
{
    if (chatInfoType == CHATINFO_NML) {
        return @"nml";
    }
    else if (chatInfoType == CHATINFO_FIL_IMG) {
        return @"fil";
    }
    else if (chatInfoType == CHATINFO_FIL_Voice) {
        return @"fil";
    }
    else if (chatInfoType == CHATINFO_FIL_Video) {
        return @"fil";
    }
    else if (chatInfoType == CHATINFO_BFD) {
        return @"bfd";
    }
    else if (chatInfoType == CHATINFO_YFM) {
        return @"yfm";
    }
    else if (chatInfoType == CHATINFO_RED) {
        return @"red";
    }
    return @"nml";
}

- (NSString*)toSendSubjectJsonStr
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:[NSNumber numberWithInteger:[CurrentAccount currentAccount].uid] forKey:@"uid"];
    [dic setObject:[CurrentAccount currentAccount].face forKey:@"face"];
    [dic setObject:[CurrentAccount currentAccount].username forKey:@"login"];
    [dic setObject:[CurrentAccount currentAccount].nickname forKey:@"name"];
    [dic setObject:[NSNumber numberWithInt:self.msgId] forKey:@"msgId"];
    [dic setObject:[MessageInfoModel parseToChatInfoTypeStr:self.chatInfoType] forKey:@"type"];

    if (self.chatType == CHATTYPE_GROUP) {
        [dic setObject:self.groupFace forKey:@"groupFace"];
        [dic setObject:self.groupNickName forKey:@"naturalname"];
    }

    NSMutableDictionary* fileDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (self.chatInfoType == CHATINFO_FIL_IMG) {
        [fileDic setObject:self.file_url forKey:@"file_url"];
        [fileDic setObject:self.file_ext forKey:@"file_ext"];
    }
    else if (self.chatInfoType == CHATINFO_FIL_Voice) {
        [fileDic setObject:self.file_url forKey:@"file_url"];
        [fileDic setObject:self.file_ext forKey:@"file_ext"];
    }
    else if (self.chatInfoType == CHATINFO_FIL_Video) {
        [fileDic setObject:self.file_url forKey:@"file_url"];
        [fileDic setObject:self.file_ext forKey:@"file_ext"];
    }
    if (fileDic.count) {
        [dic setObject:fileDic forKey:@"fil"];
    }

    if (self.chatInfoType == CHATINFO_BFD) {
        [fileDic removeAllObjects];
        [fileDic setObject:[CurrentAccount currentAccount].username forKey:@"temp_id"];
        [dic setObject:fileDic forKey:@"bfd"];
        [dic removeObjectForKey:@"login"];
    }

    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0
                                                         error:&error];

    NSString* resultStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return resultStr;
}

- (void)parseSendSubjectDic:(NSDictionary*)dic
{

    self.toUser.username = [dic objectForKey:@"login"];
    self.toUser.face = [dic objectForKey:@"face"];
    self.toUser.nickname = [dic objectForKey:@"name"];

    self.msgId = [[dic objectForKey:@"msgId"] intValue];
}

@end
