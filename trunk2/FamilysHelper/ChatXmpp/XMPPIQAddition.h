//
//  XMPPIQAddition.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "XMPPPresence.h"
#import "XMPPIQ.h"
#import "XMPPMessage.h"

@interface XMPPIQ(addition)
///是否是获取联系人的请求
-(BOOL)isRosterQuery;
///是否是房间列表请求
-(BOOL)isChatRoomItems;
///是否是房间信息查询
-(BOOL)isChatRoomInfo;
@end

@interface XMPPPresence (addition)
///是否来自聊天室的状态
-(BOOL)isChatRoomPresence;
@end


@interface XMPPMessage(DRRR)
///是否是来自房间邀请
-(BOOL)isChatRoomInvite;
@end
