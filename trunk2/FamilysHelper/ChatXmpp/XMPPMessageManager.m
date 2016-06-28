//
//  XMPPMessageManager.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPMessageManager.h"

#import "XMPPMessageArchivingCoreDataStorage.h"


static XMPPMessageManager * xmppMessageManager;
static XMPPManager * xmppManager;
@implementation XMPPMessageManager
@synthesize xmppMessageManagerDelegate = _xmppMessageManagerDelegate;

#pragma mark
#pragma mark -- initialization
+ (XMPPMessageManager *) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xmppMessageManager = [[self alloc] init];
    });
    return xmppMessageManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        xmppManager = [XMPPManager shareInstance];
        
        _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        _xmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage];
        [_xmppMessageArchiving setClientSideMessageArchivingOnly:YES];
        [_xmppMessageArchiving activate:xmppManager.xmppStream];
        [_xmppMessageArchiving addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

#pragma mark
#pragma mark -- message manage
- (void) sendMessage:(MessageInfoModel *) messageInfoModel
{
    NSString * timid =[NSString stringWithFormat:@"%.0f",[NSDate currentTime]*1000];
    XMPPMessage *message;
    if (messageInfoModel.chatType ==  CHATTYPE_CHAT) {
       message = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[xmppManager getUserJid:messageInfoModel.toUser.username]] elementID:timid];
    }else{
        message = [XMPPMessage messageWithType:@"groupchat" to:[XMPPJID jidWithString:[xmppManager getGroupJid:messageInfoModel.groupName]] elementID:timid];
    }
    [message addSubject:[messageInfoModel toSendSubjectJsonStr]];
    [message addBody:messageInfoModel.content];
    
    //发送消
    [xmppManager.xmppStream sendElement:message];
}
@end
