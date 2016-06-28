//
//  XMPPRosterManager.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/20.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "xmpp.h"

@interface XMPPRosterManager : NSObject
{
    XMPPRoster * _xmppRoster;
    XMPPRosterCoreDataStorage * _xmppRosterStorage;
    
    XMPPvCardCoreDataStorage * _xmppvCardStorage;
    XMPPvCardTempModule * _xmppvCardTempModule;
    XMPPvCardAvatarModule * _xmppvCardAvatarModule;
    XMPPvCardTemp * _xmppvCardTemp;
}
+ (XMPPRosterManager *) shareInstance;

//friend
- (void) fetchFriends;
- (NSArray *) getFriendsByCache;
- (void) addBuddy:(NSString *) userName;
- (void) setBuddyNickName:(NSString *) nickName;
- (void) acceptAddbuddy:(NSString *) userName;
- (void) rejectAddbuddy:(NSString *) userName;
- (void) searchUsers:(NSString *) userName;

- (XMPPvCardTemp *)getvcard:(NSString *)account;

@end
