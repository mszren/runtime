//
//  ChatGroupDetailController.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/4/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UUBaseMessageController.h"

@class UserMessageModel;

@interface ChatGroupDetailController : UUBaseMessageController
{
    UIButton * _redPacketBtn;
}

@property(nonatomic, strong) UserMessageModel * currentGroupModel;

@end
