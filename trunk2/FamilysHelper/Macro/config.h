//
//  config.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/4.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#ifndef FamilysHelper_config_h
#define FamilysHelper_config_h

#define PUSH_NOT_USE @"PUSH_NOT_USE"
#define TOKEN @"Token"
#define MESSAGE_NUM_NOTIFICATION @"MESSAGE_NUM_NOTIFICATION"
#define PHOTOFILE @"PHOTOFILE"
#define REMEMBER_USE @"REMEMBER_USE"

#define USERNAME @"USERNAME"
#define PASSWORD @"PASSWORD"

#define IS_CH_SYMBOL(chr) ((int)(chr) > 127)

#define SERVER_PORT @"SERVER_PORT"

#define CHATLISTDB \
    [NSString stringWithFormat:@"ChatListDB%@", [AppDelegate getUserToken]]
#define CHATDB \
    [NSString stringWithFormat:@"ChatDB%@", [AppDelegate getUserToken]]
#define USERDB \
    [NSString stringWithFormat:@"USERDB%@", [AppDelegate getUserToken]]

#define CHAT_UPDATEDATA @"ChatUpdateData"
#define CHAT_INSTERDATA @"ChatInsterData"
#define CHATTIMEOUT @"CHATTIMEOUT"
#define CHAT_DELETE @"CHAT_DELETE"
#define CHAT_TRANSMIT @"CHAT_TRANSMIT"
#define CHAT_NEXTAUDIO @"CHAT_NEXTAUDIO"
#define AudioSession @"AudioSession"
#define PUSH_TRANSMIT @"PUSH_TRANSMIT"
#define CREATROOM @"CREATROOM"
#define SAVELOGIN_USERNAME @"SAVELOGIN_USERNAME"
#define CHAT_SHARE @"CHAT_SHARE"
#define CURRENT_USER_PHOTO @"CURRENT_USER_PHOTO"

#define CONTACTS_LIST_FILENAME \
    [NSString stringWithFormat:@"%@_contactsList", [AppDelegate getUserToken]]
#define CONTACTS_LIST_PATHNAME \
    [NSString stringWithFormat:@"%@/list", [AppDelegate getUserToken]]
#define GROUP_PHOTO_CACHE \
    [NSString stringWithFormat:@"GroupCache_%@", [AppDelegate getUserToken]]
// Video
#define VIDEO_CACHE \
    [NSString stringWithFormat:@"UserVideoCache_%@", [AppDelegate getUserToken]]
// Image
#define IMAGE_CACHE \
    [NSString stringWithFormat:@"UserImgCache_DJT%@", [AppDelegate getUserToken]]
// adudio
#define AUDIO_CACHE \
    [NSString stringWithFormat:@"UserAudioCache_%@", [AppDelegate getUserToken]]

#define ALBUM_INVITE_PICKER_NOTIFICATION @"ALBUM_INVITE_PICKER_NOTIFICATION"

#define CHAT_FONT_SIZE @"CHAT_FONT_SIZE"
// sina key
#define kAppKey @"3124948006"
#define kAppRedirectURI @"http://www.jialiren.net/"
#define WXAppKey @"wx976414ca90b03607"

#define HomeListUrl \
    [NSString stringWithFormat:@"ibs/UserAudioCache_%@", JAVA_API]

// address book
#define AddressBookUrl \
    [NSString stringWithFormat:@"%@/ibsApp/ibs/getFamilyListNew", JAVA_API]

//亲友群列表
#define MyGroupListUrl [NSString stringWithFormat:@"%@/ibsApp/ibs/getMyGroupList", JAVA_API]

//兴趣群列表
#define InterestGroupListUrl \
    [NSString stringWithFormat:@"%@/ibsApp/ibs/getGroupListV6", JAVA_API]
//大家聊点赞
#define praiseTalk [NSString stringWithFormat:@"%@/ibsApp/ibs/praiseTalk", JAVA_API]
//群红包
#define GroupRedPacketListUrl(page, name)                                  \
    [NSString stringWithFormat:                                            \
                  @"%@ibsApp/ibs/getGroupRedPacket?pageindex=%ld&name=%@", \
              JAVA_API, page, name]

//检查是否在群中
#define CheckIsRoomMemberUrl \
    [NSString stringWithFormat:@"%@/ibsApp/ibs/user/CheckIsRoomMember", JAVA_API]

//申请进群
#define AskForRoomUrl(groupid, reason) \
    [NSString stringWithFormat:@"%@user/AskForRoom?name=%@", PHP_URL, groupname]

//获取群详细
#define GetRoomInfo(name) \
    [NSString             \
        stringWithFormat:@"%@ibsApp/ibs/getGroupInfo?name=%@", JAVA_URL, name]

//红包详细
#define RedPackedInfoUrl(redPacketId, userId)                                    \
    [NSString stringWithFormat:                                                  \
                  @"%@ibsApp/ibs/getRedPacketContent?redPacketId=%@&userId=%ld", \
              JAVA_API, redPacketId, userId]
//发红包
#define SendRedPackedUrl(name, userId)                                       \
    [NSString                                                                \
        stringWithFormat:                                                    \
            @"%@/ibsApp/page/hongbao/hb_baohongbao.html?name=%@&userId=%ld", \
        JAVA_API, name, userId]

//查询好友
#define FindFriendUrl \
    [NSString stringWithFormat:@"%@/ibsApp/ibs/family/findfamily", JAVA_API]

//添加好友
#define AddFriendUrl [NSString stringWithFormat:@"%@/ibsApp/ibs/family/verify", JAVA_API]

#endif
