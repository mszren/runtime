//
//  XMPPManager.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/4.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

@class XMPPRoom;
@class XMPPStream;
@class XMPPRoster;
@class XMPPReconnect;
@class XMPPRoomCoreDataStorage;
@class XMPPRosterCoreDataStorage;

@class XMPPMessageArchiving;
@class XMPPMessageArchivingCoreDataStorage;

@class XMPPMessage;

@class XMPPvCardCoreDataStorage;
@class XMPPvCardTempModule;
@class XMPPvCardAvatarModule;
@class XMPPvCardTemp;

@class XMPPPubSub;

@class XMPPRoomManager;
@class XMPPRosterManager;
@class XMPPMessageManager;

@class MessageManage;


@protocol XMPPManagerDelegate <NSObject>
@optional
- (void) sendSuccessMessage:(XMPPMessage *) sendMessage;
- (void) sendFailedMessage:(XMPPMessage *) sendMessage;
- (void) receiveMessage:(XMPPMessage *) receiveMessage;

@end


@interface XMPPManager : NSObject
{
    XMPPReconnect * _xmppReconnect;
    XMPPStream * _xmppStream;
    XMPPPubSub * _xmppPubSub;
}
@property(nonatomic, assign) BOOL isXmppConnected;
@property(nonatomic, assign) id <XMPPManagerDelegate> xmppManagerDelegate;
@property(nonatomic, readonly) XMPPStream * xmppStream;
@property(nonatomic, readonly) XMPPRoomManager * xmppRoomManager;
@property(nonatomic, readonly) XMPPRosterManager * xmppRosterManager;
@property(nonatomic, readonly) XMPPMessageManager * xmppMessageManager;
@property(nonatomic, readonly) MessageManage * messageManage;


+ (XMPPManager *) shareInstance;
- (NSString *) currentUserJid;
- (NSString *) getUserJid:(NSString *)phone;
- (NSString *) getGroupJid:(NSString *)phone;

/**
 *  connet xmpp services
 *
 *  @return
 */
- (BOOL)connect;
- (void)disconnect;
- (void)goOffline;


//subscribe
- (void)createPubNode:(NSString *) str;
- (void)subscribePubNode:(NSString *) str withJid:(NSString *) jid;
- (void)publishNode;



@end
