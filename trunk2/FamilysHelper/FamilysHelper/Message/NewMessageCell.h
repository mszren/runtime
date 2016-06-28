//
//  NewMessageCell.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/8.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BaseMessageCell.h"

@class XMPPMessageArchiving_Message_CoreDataObject;
@class XMPPMessage;

@interface NewMessageCell  : BaseMessageCell
{
    XMPPMessage * _currentMessage;

}

- (void)setNewMessage:(XMPPMessage *) aMessage;
+ (CGFloat)GetChatMessageHeight:(XMPPMessage *) aMessage;


@end
