//
//  RedPacketView.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/19.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "RedPacketView.h"



@implementation RedPacketView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void) setViewDefault
{
    _groupRedPacketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _groupRedPacketBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 40);
    [_groupRedPacketBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupRedPacketBtn setTitle:@"群红包" forState:UIControlStateNormal];
    [_groupRedPacketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_groupRedPacketBtn];
    
    _groupMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _groupMessageBtn.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40);
    [_groupMessageBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupMessageBtn setTitle:@"群消息" forState:UIControlStateNormal];
    [_groupMessageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_groupMessageBtn];
    
    _groupLeaveWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _groupLeaveWordBtn.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 40);
    [_groupLeaveWordBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_groupLeaveWordBtn setTitle:@"群留言" forState:UIControlStateNormal];
    [_groupLeaveWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_groupLeaveWordBtn];
}

- (void) BtnAction:(id) sender
{
    
}

@end
