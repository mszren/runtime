//
//  XMPPMessageManager.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "xmpp.h"
#import "MessageInfoModel.h"

@protocol XMPPMessageManagerDelegate <NSObject>
@optional
- (void) sendSuccessMessage:(XMPPMessage *) sendMessage;
- (void) sendFailedMessage:(XMPPMessage *) sendMessage;
- (void) receiveMessage:(XMPPMessage *) receiveMessage;

@end

@interface XMPPMessageManager : NSObject
{
    XMPPMessageArchiving * _xmppMessageArchiving;
    XMPPMessageArchivingCoreDataStorage * _xmppMessageArchivingCoreDataStorage;
}
@property(nonatomic, assign) id<XMPPMessageManagerDelegate> xmppMessageManagerDelegate;


+ (XMPPMessageManager *) shareInstance;

- (void) sendMessage:(MessageInfoModel *) messageInfoModel;
@end
