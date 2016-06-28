//
//  XMPPRoomManager.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "xmpp.h"

@interface XMPPRoomManager : NSObject
{
    XMPPRoom * _xmppRoom;
    XMPPRoomCoreDataStorage * _roomStorage;
    
    //room service 列表
    NSMutableDictionary* _chatRooms;
    NSMutableArray* _chatRoomServices;
}
+ (XMPPRoomManager *) shareInstance;
@property(nonatomic, strong) NSMutableDictionary * chatRooms;

//room
-(void)creatXMPPRoom:(NSArray *)userArray owner:(NSString *)owner;
-(void)logoutRoom:(NSString *)roomJid;
-(void)logoutRoom:(NSString *)roomJid admin:(BOOL)flag;
-(void)distoryRoom:(NSString *)roomJid;
-(void)changeRoomName:(NSString *)roomName roomJid:(NSString *)roomJid;
-(void)addXMPPMembers:(NSArray *)userArray roomJid:(NSString *)roomJid;
-(void)removeMember:(NSString *)userJid roomJid:(NSString *)roomJid;


//- (void)joinRoom:(NSString *) roomNameJid;
- (void)fetchRooms;
- (void)fetchRoomMembers;

@end
