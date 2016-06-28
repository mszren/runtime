//
//  BangInfoView.h
//  FamilysHelper
//
//  Created by Owen on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"

@interface BangInfoView : UIView
- (void)bindTribe:(TribeModel*)model;
@property (nonatomic, strong) UIButton* Attentionbut;
@property (nonatomic, strong) UIButton* btnqiandao;
@end
