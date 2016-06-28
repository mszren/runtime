//
//  XMPPManager.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/4.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPManager.h"

#import "xmpp.h"
#import "XMPPIQAddition.h"

#import "XMPPRoom.h"
#import "XMPPStream.h"
#import "XMPPRoster.h"
#import "XMPPReconnect.h"
#import "XMPPRoomCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"

#import "XMPPMessageArchiving.h"
#import "XMPPMessageArchivingCoreDataStorage.h"

#import "XMPPvCardCoreDataStorage.h"
#import "XMPPvCardTempModule.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPvCardTemp.h"

#import "XMPPPubSub.h"

#import "XMPPChatRoom.h"

#import "XMPPRoomManager.h"
#import "XMPPRosterManager.h"
#import "XMPPMessageManager.h"

#import "MessageManage.h"

#import "DownLoadListManager.h"

static XMPPManager * chatXmppManager = nil;
static CurrentAccount * currentAccount = nil;
static DownLoadListManager * downLoadListManager = nil;

@implementation XMPPManager
@synthesize xmppStream = _xmppStream;
- (NSDictionary *)jsonToArrayOrNSDictionary:(NSString *) aStr
{
    NSData * data = [aStr dataUsingEncoding:NSUTF8StringEncoding];
    //解析json
    NSError *error = nil;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    return dic;
}

#pragma mark
#pragma mark -- initialization
+ (XMPPManager *) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatXmppManager = [[self alloc] init];
    });
    return chatXmppManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setupStream];
    }
    return self;
}

- (void)setupStream
{
    NSAssert(_xmppStream == nil, @"Method setupStream invoked multiple times");
    
    _xmppStream = [[XMPPStream alloc] init];
#if !TARGET_IPHONE_SIMULATOR
    {
        _xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    _xmppReconnect = [[XMPPReconnect alloc] init];
    _xmppReconnect.autoReconnect =YES;
    
    // Activate xmpp modules
    [_xmppReconnect         activate:_xmppStream];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];

    // Optional:
    [_xmppStream setHostName:XMPP_SERVER];
    [_xmppStream setHostPort:XMPP_SERVER_POST];
    
    // You may need to alter these settings depending on the server you're connecting to
//    allowSelfSignedCertificates = NO;
//    allowSSLHostNameMismatch = NO;
}
#pragma mark
#pragma mark -- private method
- (NSString *) currentUserJid
{
    return [_xmppStream myJID].full;
}
- (NSString *) getUserJid:(NSString *)phone
{
    return [NSString stringWithFormat:@"%@@%@/%@",phone,XMPP_SERVER,Reource];
}

- (NSString *) getGroupJid:(NSString *)phone
{
    return [NSString stringWithFormat:@"%@@conference.%@",phone,XMPP_SERVER];
}


#pragma mark
#pragma mark -- connect and teardown xmpp
-(BOOL)connect
{
    currentAccount = [CurrentAccount currentAccount];
    downLoadListManager = [DownLoadListManager shareDownLoadList];

    
    _xmppRoomManager = [XMPPRoomManager shareInstance];
    _xmppRosterManager = [XMPPRosterManager shareInstance];
    _xmppMessageManager = [XMPPMessageManager shareInstance];
    
    _messageManage = [MessageManage shareInstance];
    
    NSString * userId = currentAccount.username;
    if (!userId) {
        userId = @"匿名";
    }

    if (![_xmppStream isDisconnected]) {
        return YES;
    }
    
    //设置用户
    [_xmppStream setMyJID:[XMPPJID jidWithUser:userId domain:Domain resource:Reource]];
    NSError *error = nil;
    
    if (![_xmppStream connectWithTimeout:XMPP_TIMEOUT error:&error]) {
        [ToastManager showToast:[NSString stringWithFormat:@"can't connect %@ -- %@", XMPP_SERVER, error.description]];
        return NO;
    }
    return YES;
}
- (void)disconnect
{
    [self goOffline];
    [_xmppStream disconnect];
}
- (void)teardownStream
{
    [_xmppStream removeDelegate:self];
    [_xmppReconnect  deactivate];
    [_xmppStream disconnect];
}

#pragma mark
#pragma mark -- manage online & offline
- (void)goOnline
{
    NSString * userName = currentAccount.username;
    NSString * pwd = currentAccount.password;
    
    NSError *error = nil;
    [_xmppStream setMyJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@",userName,Domain,Reource]]];
    
    if (![_xmppStream authenticateWithPassword:pwd error:&error]) {
        [ToastManager showToast:[NSString stringWithFormat:@"authenticateWithPassword %@ -- %@", pwd, error.description]];
        _isXmppConnected =NO;
    }
}

- (BOOL)goOnline:(NSString *) userName withPwd:(NSString *) pwd
{
    NSError *error = nil;
    [_xmppStream setMyJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@",userName,XMPP_SERVER,Reource]]];
    

    if (![_xmppStream authenticateWithPassword:pwd error:&error]) {
        [ToastManager showToast:[NSString stringWithFormat:@"authenticateWithPassword %@ -- %@", pwd, error.description]];
        _isXmppConnected =NO;
        return NO;
    }else
    {
        return YES;
    }
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
}

#pragma mark
#pragma mark -- 订阅
- (void) getAllPubSub
{

}
- (void)createPubNode:(NSString *) str
{
    _xmppPubSub = [[XMPPPubSub alloc] initWithServiceJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@.%@",@"pubsub",Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppPubSub   activate:_xmppStream];
    [_xmppPubSub addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    
    [dic setObject:@"pubsub#title" forKey:@"Princely Musings (Atom)"];
    [dic setObject:@"pubsub#deliver_notifications" forKey:@"1"];
    [dic setObject:@"pubsub#deliver_payloads" forKey:@"1"];
    [dic setObject:@"pubsub#persist_items" forKey:@"1"];
    [dic setObject:@"pubsub#max_items" forKey:@"10"];
    [dic setObject:@"pubsub#item_expire" forKey:@"604800"];
    [dic setObject:@"pubsub#access_model" forKey:@"open"];
    [dic setObject:@"pubsub#publish_model" forKey:@"publishers"];
    [dic setObject:@"pubsub#purge_offline" forKey:@"0"];
    [dic setObject:@"pubsub#send_last_published_item" forKey:@"never"];
    [dic setObject:@"pubsub#presence_based_delivery" forKey:@"false"];
    [dic setObject:@"pubsub#notification_type" forKey:@"headline"];
    [dic setObject:@"pubsub#notify_config" forKey:@"0"];
    [dic setObject:@"pubsub#notify_delete" forKey:@"0"];
    [dic setObject:@"pubsub#notify_retract" forKey:@"0"];
    [dic setObject:@"pubsub#notify_sub" forKey:@"0"];
    [dic setObject:@"pubsub#max_payload_size" forKey:@"1028"];
    [dic setObject:@"pubsub#type" forKey:@"http://www.w3.org/2005/Atom"];
    [dic setObject:@"pubsub#body_xslt" forKey:@"http://jabxslt.jabberstudio.org/atom_body.xslt"];
    
    [_xmppPubSub createNode:str withOptions:dic];
}

- (void)subscribePubNode:(NSString *) str withJid:(NSString *) jid
{
    _xmppPubSub = [[XMPPPubSub alloc] initWithServiceJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@.%@",@"pubsub",Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppPubSub   activate:_xmppStream];
    [_xmppPubSub addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [_xmppPubSub subscribeToNode:str withJID:nil];
}

- (void)publishNode
{
    _xmppPubSub = [[XMPPPubSub alloc] initWithServiceJID:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@.%@",@"pubsub",Domain]] dispatchQueue:dispatch_get_main_queue()];
    [_xmppPubSub   activate:_xmppStream];
    [_xmppPubSub addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    NSXMLElement *item = [NSXMLElement elementWithName:@"entry"];
    
    [item addChild:[NSXMLElement elementWithName:@"title" stringValue:@"stringValue"]];
    [item addChild:[NSXMLElement elementWithName:@"summary" stringValue:@"stringValuestringValuestringValue"]];

    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [dic setObject:@"pubsub#title" forKey:@"Princely Musings (Atom)"];
    [dic setObject:@"pubsub#deliver_notifications" forKey:@"1"];
    [dic setObject:@"pubsub#deliver_payloads" forKey:@"1"];
    [dic setObject:@"pubsub#persist_items" forKey:@"1"];
    [dic setObject:@"pubsub#max_items" forKey:@"10"];
    [dic setObject:@"pubsub#item_expire" forKey:@"604800"];
    [dic setObject:@"pubsub#access_model" forKey:@"open"];
    [dic setObject:@"pubsub#publish_model" forKey:@"publishers"];
    [dic setObject:@"pubsub#purge_offline" forKey:@"0"];
    [dic setObject:@"pubsub#send_last_published_item" forKey:@"never"];
    [dic setObject:@"pubsub#presence_based_delivery" forKey:@"false"];
    [dic setObject:@"pubsub#notification_type" forKey:@"headline"];
    [dic setObject:@"pubsub#notify_config" forKey:@"0"];
    [dic setObject:@"pubsub#notify_delete" forKey:@"0"];
    [dic setObject:@"pubsub#notify_retract" forKey:@"0"];
    [dic setObject:@"pubsub#notify_sub" forKey:@"0"];
    [dic setObject:@"pubsub#max_payload_size" forKey:@"1028"];
    [dic setObject:@"pubsub#type" forKey:@"http://www.w3.org/2005/Atom"];
    [dic setObject:@"pubsub#body_xslt" forKey:@"http://jabxslt.jabberstudio.org/atom_body.xslt"];
    
    
    [_xmppPubSub publishToNode:@"pubsub-summer111" entry:item withItemID:nil];
}

#pragma mark
#pragma mark -- XMPPStreamDelegate
- (void)xmppStreamWillConnect:(XMPPStream *)sender
{

}
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    _isXmppConnected = YES;
    
    if ([[AppDelegate shareDelegate] checkIsExistUser]) {
        [self goOnline];
    }
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{

    
}
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error
{

}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
    
    _isXmppConnected = YES;
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    _isXmppConnected = NO;
}
- (NSString *)xmppStream:(XMPPStream *)sender alternativeResourceForConflictingResource:(NSString *)conflictingResource
{
    return Reource;
}
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    return YES;
}
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    if ([message isErrorMessage]) {
        NSString*from = [[message attributeForName:@"from"] stringValue];
        return;
    }
    NSString * subjectJsonStr = [[message elementForName:@"subject"] stringValue];
    if (!subjectJsonStr) {
        return;
    }
    NSMutableDictionary * jsonToDic  = [[NSMutableDictionary alloc] initWithDictionary:[self jsonToArrayOrNSDictionary:subjectJsonStr]];
    NSString * loginStr = [jsonToDic objectForKey:@"login"];
    //收到自己发送的消息
    if ([loginStr isEqualToString:currentAccount.username]) {
        return;
    }
    
    [jsonToDic setObject:[[message elementForName:@"body"] stringValue] forKey:@"body"];
    [jsonToDic setObject:[[message attributeForName:@"type"] stringValue] forKey:@"chatType"];
    [jsonToDic setObject:[[message attributeForName:@"id"] stringValue] forKey:@"time"];
    NSString * fromStr = [[message attributeForName:@"from"] stringValue];
    NSString * fromStr1 = [fromStr substringToIndex:[fromStr rangeOfString:@"@"].location];
    [jsonToDic setObject:fromStr1 forKey:@"groupUserName"];
    [jsonToDic setObject:@"0" forKey:@"isSend"];
    
    //muc 插件 离线数据特殊处理
    NSDictionary * roomDic = [jsonToDic objectForKey:@"room"];
    if (roomDic.count) {
        [jsonToDic setObject:@"groupchat" forKey:@"chatType"];
        [jsonToDic setObject:[roomDic objectForKey:@"name"] forKey:@"groupUserName"];
    }
    MessageInfoModel * messageInfoModel = [MessageInfoModel JsonParse:jsonToDic];
    UserMessageModel * userMessageModel = [UserMessageModel JsonParse:jsonToDic];
    userMessageModel.num = @"1";
    
    if (messageInfoModel.chatType == CHATTYPE_CHAT) {//单聊
        switch (messageInfoModel.chatInfoType) {
            case CHATINFO_NML:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_IMG:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_Voice:{
                [downLoadListManager addDownload:messageInfoModel.content withTargetPath:[FilePathHandler changeLocalFilePath:messageInfoModel.content]];
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_Video:{
                [downLoadListManager addDownload:messageInfoModel.content withTargetPath:[FilePathHandler changeLocalFilePath:messageInfoModel.content]];
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_BFD:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_YFM:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            default:{
                break;
            }
        }
    }else if (messageInfoModel.chatType == CHATTYPE_GROUP){//群聊
        switch (messageInfoModel.chatInfoType) {
            case CHATINFO_NML:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_IMG:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_Voice:{
                [downLoadListManager addDownload:messageInfoModel.content withTargetPath:[FilePathHandler changeLocalFilePath:messageInfoModel.content]];
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_FIL_Video:{
                [downLoadListManager addDownload:messageInfoModel.content withTargetPath:[FilePathHandler changeLocalFilePath:messageInfoModel.content]];
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            case CHATINFO_RED:{
                [_messageManage insertWithMessageCache:messageInfoModel withUserMessage:userMessageModel];
                break;
            }
            default:{
                
                break;
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterNewMessageName object:messageInfoModel];
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationSendChangeUNReadMessageNum object:nil];
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{

}
#pragma mark
#pragma mark -- send message manage
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    if (self.xmppManagerDelegate && [self.xmppManagerDelegate respondsToSelector:@selector(sendSuccessMessage:)]) {
        [self.xmppManagerDelegate sendSuccessMessage:message];
    }
    MessageInfoModel * messageInfoModel = [[MessageInfoModel  alloc] initWithXMPPMessageJsonStr:message.subject];
    messageInfoModel.state = SUCCESS;
    [_messageManage  updateSendMessageState:messageInfoModel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterSendMessageStatusName object:messageInfoModel];
}
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    [ToastManager showToast:[NSString stringWithFormat:@"didFailToSendMessage %@ == %@-- %@", sender,message, error.description]];
    
    if (self.xmppManagerDelegate && [self.xmppManagerDelegate respondsToSelector:@selector(sendFailedMessage:)]) {
        [self.xmppManagerDelegate sendFailedMessage:message];
    }
    
    MessageInfoModel * messageInfoModel = [[MessageInfoModel  alloc] initWithXMPPMessageJsonStr:message.subject];
    messageInfoModel.state = FAIL;
    [_messageManage  updateSendMessageState:messageInfoModel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterSendMessageStatusName object:messageInfoModel];
}

- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence
{
    
}
- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    [ToastManager showToast:[NSString stringWithFormat:@"didFailToSendIQ %@ == %@-- %@", sender,iq, error.description]];
}


- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender
{
    _isXmppConnected = NO;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(errorData)]) {
//        [self.delegate errorData];
//    }
}
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    _isXmppConnected = NO;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(errorData)]) {
//        [self.delegate errorData];
//    }
}
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    _isXmppConnected = NO;
    [ToastManager showToast:[NSString stringWithFormat:@"xmppStreamDidDisconnect %@ -- %@", sender, error.description]];
}

- (void)xmppReconnect:(XMPPReconnect *)sender didDetectAccidentalDisconnect:(SCNetworkReachabilityFlags)connectionFlags
{
    _isXmppConnected = NO;

}
//添加好友
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{

}

#pragma mark
#pragma mark --  XMPPRoomManager delegate
- (void)xmppRoom:(XMPPRoom *)sender occupantDidJoin:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence{
    
        NSLog(@"occupantDidJoin");
}
- (void)xmppRoom:(XMPPRoom *)sender occupantDidLeave:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence{
        NSLog(@"occupantDidLeave");
}
- (void)xmppRoom:(XMPPRoom *)sender occupantDidUpdate:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence{
    NSLog(@"occupantDidUpdate");
}


- (void)xmppRoomDidJoin:(XMPPRoom *)sender
{
    NSLog(@"xmppRoomDidJoin");
}
- (void)xmppRoom:(XMPPRoom *)sender willSendConfiguration:(XMPPIQ *)roomConfigForm
{
    NSLog(@"willSendConfiguration");
}
- (void)xmppRoom:(XMPPRoom *)sender didFetchConfigurationForm:(NSXMLElement *)configForm
{
    NSLog(@"didFetchConfigurationForm");
}
- (void)xmppRoom:(XMPPRoom *)sender didConfigure:(XMPPIQ *)iqResult
{
    NSLog(@"didConfigure");
}
- (void)xmppRoom:(XMPPRoom *)sender didNotConfigure:(XMPPIQ *)iqResult
{
    NSLog(@"didNotConfigure");
}
- (void)xmppRoom:(XMPPRoom *)sender didFetchBanList:(NSArray *)items
{
    NSLog(@"didFetchBanList");
}

- (void)xmppRoom:(XMPPRoom *)sender didNotFetchBanList:(XMPPIQ *)iqError
{
    NSLog(@"didNotFetchBanList");
}

- (void)xmppRoom:(XMPPRoom *)sender didFetchMembersList:(NSArray *)items
{
    NSLog(@"didFetchMembersList = %@",items);
}

- (void)xmppRoom:(XMPPRoom *)sender didNotFetchMembersList:(XMPPIQ *)iqError
{
    NSLog(@"didNotFetchMembersList");
}

- (void)xmppRoom:(XMPPRoom *)sender didFetchModeratorsList:(NSArray *)items
{
    NSLog(@"didFetchModeratorsList");
}

- (void)xmppRoom:(XMPPRoom *)sender didNotFetchModeratorsList:(XMPPIQ *)iqError
{
    NSLog(@"didNotFetchModeratorsList");
}

- (void)handleDidLeaveRoom:(XMPPRoom *)room
{
    NSLog(@"handleDidLeaveRoom");
}



@end