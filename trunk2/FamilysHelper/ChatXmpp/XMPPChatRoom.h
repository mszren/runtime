//
//  XMPPChatRoom.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "xmpp.h"

///聊天室的一个成员
@interface XMPPChatRoomMember : NSObject{
    
}
@property (nonatomic,copy) NSString* chatRoomJid;
@property (nonatomic,copy) NSString* chatRoomMembername;
@property (nonatomic,copy) NSString* chatRoomMemberJid;
@property (nonatomic,copy) NSString* affiliation;
@property (nonatomic,copy) NSString* role;
@property (nonatomic,copy) NSString* show;
@property (nonatomic,copy) NSString* status;
///修改名字时的新名字
@property (nonatomic,copy) NSString* nick;
-(id)initWithPresence:(XMPPPresence*)presence;
@end
#pragma mark - DRRRChatRoomInfoField
///聊天室房间信息的各个字段
@interface XMPPChatRoomInfoField:NSObject{
    
}
@property (nonatomic,copy) NSString* var;
@property (nonatomic,copy) NSString* label;
@property (nonatomic,copy) NSString* value;
-(id)initWithVar:(NSString*)var
           label:(NSString*)label
           value:(NSString*)value;
@end
#pragma mark - DRRRChatRoomInfo
///聊天室房间信息
@interface XMPPChatRoomInfo:NSObject{
    NSMutableArray* _features;
    NSMutableDictionary* _fields;
}
@property (nonatomic,readonly) NSArray* features;
@property (nonatomic,readonly) NSDictionary* fields;
@property (nonatomic,copy) NSString* category;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,readonly) BOOL public;
@property (nonatomic,readonly) BOOL needPassword;
@property (nonatomic,readonly) BOOL membersOnly;
@property (nonatomic,readonly) NSString* roomDescription;
@property (nonatomic,readonly) NSString* subject;
@property (nonatomic,readonly) int occupants;
@property (nonatomic,readonly) NSString* creationdate;
-(id)initWithIq:(XMPPIQ*)iq;
@end

///聊天室房间
@interface XMPPChatRoom : NSObject{
    NSMutableDictionary* _memberList;
}
///chatRoomMemberJid and DRRRChatRoomMember
@property (nonatomic,readonly) NSDictionary* memberList;
@property (nonatomic,copy) NSString* chatRoomJid;
@property (nonatomic,copy) NSString* name;
///房间信息
@property (nonatomic,retain) XMPPChatRoomInfo* chatRoomInfo;
-(id)initWithChatRoomJid:(NSString*)chatRoomJid;
///更新房间成员信息
-(void)updateChatRoomMember:(XMPPChatRoomMember*)chatRoomMember;
///获取房间内的一个成员
-(XMPPChatRoomMember*)chatRoomMember:(NSString*)chatRoomMemberJid;
@end
