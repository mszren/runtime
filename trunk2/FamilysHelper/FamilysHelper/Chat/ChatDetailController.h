//
//  ChatDetailController.h
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UUBaseMessageController.h"

@class User;

@interface ChatDetailController : UUBaseMessageController
{
    
}
@property(nonatomic, strong) User * currentUserModel;

@end