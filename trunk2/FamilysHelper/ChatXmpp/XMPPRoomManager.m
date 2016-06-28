//
//  XMPPRoomManager.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPRoomManager.h"

#import "XMPPRoom.h"
#import "XMPPChatRoom.h"
#import "XMPPRoomCoreDataStorage.h"

#import "XMPPIQAddition.h"

@interface XMPPRoomManager(private)


@end

static XMPPRoomManager * xmppRoomManager;
static XMPPManager * xmppManager;
@implementation XMPPRoomManager
@synthesize chatRooms = _chatRooms;

#pragma mark
#pragma mark -- initialization
+ (XMPPRoomManager *) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xmppRoomManager = [[self alloc] init];
    });
    return xmppRoomManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        _chatRooms = [[NSMutableDictionary alloc] initWithCapacity:0];
        _chatRoomServices = [[NSMutableArray alloc] initWithCapacity:0];
        _roomStorage = [XMPPRoomCoreDataStorage sharedInstance];
        xmppManager = [XMPPManager shareInstance];
    }
    return self;
}


#pragma mark - mcu
-(void)queryInfoJid:(NSString *)jid
{
    XMPPIQ* iq=[XMPPIQ iqWithType:@"get"];
    [iq addAttributeWithName:@"from" stringValue:[xmppManager currentUserJid]];
    [iq addAttributeWithName:@"id" stringValue:[xmppManager.xmppStream generateUUID]];
    [iq addAttributeWithName:@"to" stringValue:jid];
    NSXMLElement* element_query=[NSXMLElement elementWithName:@"query" xmlns:@"http://jabber.org/protocol/disco#info"];
    [iq addChild:element_query];
    [xmppManager.xmppStream sendElement:iq];
}
-(void)queryItemsJid:(NSString *)jid
{
    XMPPIQ* iq=[XMPPIQ iqWithType:@"get"];
    [iq addAttributeWithName:@"from" stringValue:[xmppManager currentUserJid]];
    [iq addAttributeWithName:@"id" stringValue:[xmppManager.xmppStream generateUUID]];
    [iq addAttributeWithName:@"to" stringValue:jid];
    NSXMLElement* element_query=[NSXMLElement elementWithName:@"query" xmlns:@"http://jabber.org/protocol/disco#items"];
    [iq addChild:element_query];
    [xmppManager.xmppStream sendElement:iq];
}
-(void)queryChatRoomsInService:(NSString *)service
{
    [self queryItemsJid:service];
}
-(void)queryChatRoomInfo:(NSString *)roomJid
{
    [self queryInfoJid:roomJid];
}
-(void)queryChatRoomItems:(NSString *)roomJid
{
    [self queryItemsJid:roomJid];
}
-(XMPPChatRoom*)chatRoom:(NSString *)roomJid{
    XMPPChatRoom* chatRoom=_chatRooms[roomJid];
    if (!chatRoom){
        chatRoom=[[XMPPChatRoom alloc]initWithChatRoomJid:roomJid];
        _chatRooms[roomJid]=chatRoom;
    }
    return chatRoom;
}

#pragma mark
#pragma mark -- XMPPROOM 创建群组房间
-(void)creatXMPPRoom:(NSArray *)userArray owner:(NSString *)owner
{
    int timeStep =(int)[[NSDate date] timeIntervalSince1970];
    
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"XMPPUserName"];
    NSString * roomNameString=[NSString stringWithFormat:@"%@,",userId];
    NSString * roomNameJid =  [NSString stringWithFormat:@"%d_%lu",timeStep,(unsigned long)[roomNameString hash]];
    
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomNameJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];
    [_xmppRoom joinRoomUsingNickname:owner history:nil];
    
    [_xmppRoom fetchConfigurationForm];
    [_xmppRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

- (void)sendDefaultRoomConfig
{
    NSXMLElement *x = [NSXMLElement elementWithName:@"x" xmlns:@"jabber:x:data"];
    
    NSXMLElement *field = [NSXMLElement elementWithName:@"field"];
    [field addAttributeWithName:@"var" stringValue:@"muc#roomconfig_persistentroom"];  // 永久属性
    [field addAttributeWithName:@"type" stringValue:@"boolean"];
    NSXMLElement *value = [NSXMLElement elementWithName:@"value"];
    [value setStringValue:@"1"];
    [field addChild:value];
    [x addChild:field];
    
    NSXMLElement *fieldowners = [NSXMLElement elementWithName:@"field"];
    [fieldowners addAttributeWithName:@"var" stringValue:@"muc#roomconfig_roomowners"];  // 谁创建的房间
    [fieldowners addAttributeWithName:@"type" stringValue:@"jid-multi"];
    NSXMLElement *valueowners = [NSXMLElement elementWithName:@"value"];
    [valueowners setStringValue:[xmppManager currentUserJid]]; //创建者的Jid
    [fieldowners addChild:valueowners];
    [x addChild:fieldowners];
    

    NSXMLElement *field2 = [NSXMLElement elementWithName:@"field"];
    [field2 addAttributeWithName:@"var" stringValue:@"muc#roomconfig_roomname"];
    NSXMLElement *value2 = [NSXMLElement elementWithName:@"value"];
    [value2 setStringValue:@"A Dark Cave csdn"];
    [field2 addChild:value2];
    [x addChild:field2];
    
    [_xmppRoom configureRoomUsingOptions:x];
}


- (void)xmppRoomDidCreate:(XMPPRoom *)sender
{
    [self sendDefaultRoomConfig];
}
//修改房间名称
-(void)changeRoomName:(NSString *)roomName roomJid:(NSString *)roomJid
{
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];
    
    NSXMLElement *x = [NSXMLElement elementWithName:@"x" xmlns:@"jabber:x:data"];
    NSXMLElement * fielName = [NSXMLElement elementWithName:@"field"];
    [fielName addAttributeWithName:@"var" stringValue:@"muc#roomconfig_roomname"];
    [fielName addAttributeWithName:@"type" stringValue:@"text-single"];
    NSXMLElement * valueName = [NSXMLElement elementWithName:@"value" stringValue:roomName];
    [fielName addChild:valueName];
    [x addChild:fielName];
    [_xmppRoom configureRoomUsingOptions:x];
    [_xmppRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)logoutRoom:(NSString *)roomJid admin:(BOOL)flag
{
    if (flag) {
        
    }else
    {
        _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
        [_xmppRoom activate:xmppManager.xmppStream];
        NSXMLElement * userElement =[XMPPRoom itemWithAffiliation:@"none" jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",[xmppManager currentUserJid],XMPP_SERVER]]];
        NSMutableArray *teArr = [NSMutableArray arrayWithObjects:userElement, nil];
        [_xmppRoom editRoomPrivileges:teArr];
        [_xmppRoom leaveRoom];
    }
}
-(void)distoryRoom:(NSString *)roomJid
{
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];
    //    NSXMLElement * userElement =[XMPPRoom itemWithAffiliation:@"none" jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",[UserAccount currentAccount].userName,SERVER]]];
    //    NSMutableArray *teArr = [NSMutableArray arrayWithObjects:userElement, nil];
    //    [xmppRoom editRoomPrivileges:teArr];
    [_xmppRoom destroyRoom];
}
//退出房间
-(void)logoutRoom:(NSString *)roomJid
{
    [self logoutRoom:roomJid admin:NO];
}
//删除房间成员
-(void)removeMember:(NSString *)userJid roomJid:(NSString *)roomJid
{
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];
    NSXMLElement * userElement =[XMPPRoom itemWithAffiliation:@"none" jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userJid,XMPP_SERVER]]];
    NSMutableArray *teArr = [NSMutableArray arrayWithObjects:userElement, nil];
    [_xmppRoom editRoomPrivileges:teArr];
}
-(void)addXMPPMembers:(NSArray *)userArray roomJid:(NSString *)roomJid
{
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@conference.%@",roomJid,Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];
    NSMutableArray *teArr = [NSMutableArray arrayWithCapacity:1];
    for (User *user in userArray) {
        [_xmppRoom inviteUser:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",user.username,XMPP_SERVER]] withMessage:@""];
        NSXMLElement * userElement =[XMPPRoom itemWithAffiliation:@"owner" jid:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",user.username,XMPP_SERVER]]];
        [teArr addObject:userElement];
    }
    [_xmppRoom editRoomPrivileges:teArr];
}

- (void)fetchRoomMembers
{
    [_xmppRoom fetchMembersList];
}
- (void)fetchRooms
{
    XMPPIQ* iq=[XMPPIQ iqWithType:@"get"];
    [iq addAttributeWithName:@"from" stringValue:[xmppManager currentUserJid]];
    [iq addAttributeWithName:@"id" stringValue:[xmppManager.xmppStream generateUUID]];
    [iq addAttributeWithName:@"to" stringValue:@"conference.127.0.0.1"];
    NSXMLElement* element_query=[NSXMLElement elementWithName:@"query" xmlns:@"http://jabber.org/protocol/disco#items"];
    [iq addChild:element_query];
    [xmppManager.xmppStream sendElement:iq];
}


- (void)joinRoom:(NSString *) roomNameJid
{
    _xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:[XMPPJID jidWithString:roomNameJid] dispatchQueue:dispatch_get_main_queue()];
    [_xmppRoom activate:xmppManager.xmppStream];    
    [_xmppRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];
  
    if (_xmppRoom.isJoined) {
        
    }else{
        [_xmppRoom joinRoomUsingNickname:[CurrentAccount currentAccount].nickname history:nil];
    }
}

#pragma mark
#pragma mark -- XMPPStream Delegate
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    return YES;
}




@end