//
//  XMPPRosterManager.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPRosterManager.h"

#import "XMPPvCardTemp.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"


static XMPPRosterManager * xmppRosterManager;
static XMPPManager * xmppManager;
@implementation XMPPRosterManager


#pragma mark
#pragma mark -- initialization
+ (XMPPRosterManager *) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xmppRosterManager = [[self alloc] init];
    });
    return xmppRosterManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        _xmppRosterStorage = [XMPPRosterCoreDataStorage sharedInstance];
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterStorage];
        _xmppRoster.autoFetchRoster = YES;
        _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
        
        xmppManager = [XMPPManager shareInstance];
        [_xmppRoster activate:xmppManager.xmppStream];
        
        _xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
        _xmppvCardTempModule = [[XMPPvCardTempModule alloc]initWithvCardStorage:_xmppvCardStorage];
        _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_xmppvCardTempModule];
        [_xmppvCardTempModule   activate:xmppManager.xmppStream];
        [_xmppvCardAvatarModule activate:xmppManager.xmppStream];
        [_xmppvCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}
- (void) setBuddyNickName:(NSString *) nickName
{

}

- (void) addBuddy:(NSString *) userName
{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]];
    [_xmppRoster addUser:jid withNickname:userName];
}
- (void)removeBuddy:(NSString *)name
{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name,Domain]];
    [_xmppRoster removeUser:jid];
}
- (void)setBuddyNickName:(NSString *) nickName withUserName:(NSString *) userName
{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]];
    [_xmppRoster setNickname:nickName forUser:jid];
}

- (void) acceptAddbuddy:(NSString *) userName
{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]];
    [_xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
}

- (void) rejectAddbuddy:(NSString *) userName
{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]];
    [_xmppRoster rejectPresenceSubscriptionRequestFrom:jid];
}

- (void) fetchFriends
{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myJID =  [xmppManager.xmppStream myJID];
    [iq addAttributeWithName:@"from" stringValue:myJID.description];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:[xmppManager.xmppStream generateUUID]];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [xmppManager.xmppStream sendElement:iq];
}

- (void) searchUsers:(NSString *) userName
{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myJID = xmppManager.xmppStream.myJID;
    [iq addAttributeWithName:@"from" stringValue:myJID.description];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:[xmppManager.xmppStream generateUUID]];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [xmppManager.xmppStream sendElement:iq];
}
- (void)XMPPAddFriendSubscribe:(NSString *)name
{
    //XMPPHOST 就是服务器名，  主机名
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name, Domain]];
    //[presence addAttributeWithName:@"subscription" stringValue:@"好友"];
    [_xmppRoster subscribePresenceToUser:jid];
}

- (NSArray *)getFriendsByCache
{
    NSManagedObjectContext * context = _xmppRosterStorage.mainThreadManagedObjectContext;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError * error;
    NSArray * friends = [context executeFetchRequest:request error:&error];
    
    return friends;
}

-(XMPPvCardTemp *)getvcard:(NSString *)userName
{
    [_xmppvCardTempModule fetchvCardTempForJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]]];
    return [_xmppvCardTempModule vCardTempForJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,Domain]] shouldFetch:YES];
}

-(void)updateMyCard:(NSString *)userName
{
    XMPPvCardTemp * myCard = [[XMPPvCardTemp alloc] initWithName:userName];
    [_xmppvCardTempModule updateMyvCardTemp:myCard];
}


@end
