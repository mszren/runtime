//
//  AwardView.h
//  FamilysHelper
//
//  Created by 我 on 15/6/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"
@interface AwardView : UIView <UITextFieldDelegate, MessageRoutable>
@property (nonatomic, assign) NSInteger objectId;
@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, assign) NSInteger targetuserId;
@property (nonatomic, strong) UITextField* bangBiTest;
@property (nonatomic, strong) UILabel* bangbi;

@end
