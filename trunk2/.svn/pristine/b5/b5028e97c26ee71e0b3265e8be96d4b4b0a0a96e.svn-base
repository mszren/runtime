//
//  EditView.m
//  FamilysHelper
//
//  Created by 我 on 15/8/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "EditView.h"

@implementation EditView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
        [self addSubview:grayLabel];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(SCREEN_WIDTH - 120, 9, 50, 20);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _cancelButton.layer.borderWidth = 0.8;
        _cancelButton.layer.cornerRadius = 4;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
        _cancelButton.layer.borderColor = borderColorRef;
        [_cancelButton setTitleColor:RedColor1 forState:UIControlStateNormal];
        CGColorSpaceRelease(colorSpace);
        CGColorRelease(borderColorRef);
        [self addSubview:_cancelButton];
        
        _deletButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _deletButton.frame = CGRectMake(SCREEN_WIDTH - 60, 9, 50, 20);
        [_deletButton setTitle:@"删除" forState:UIControlStateNormal];
        _deletButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _deletButton.layer.borderWidth = 0.8;
        _deletButton.layer.cornerRadius = 4;
        CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef2 = CGColorCreate(colorSpace2, (CGFloat[]){ 0.9, 0, 0, 1 });
        _deletButton.layer.borderColor = borderColorRef2;
        [_deletButton setTitleColor:RedColor1 forState:UIControlStateNormal];
        CGColorSpaceRelease(colorSpace2);
        CGColorRelease(borderColorRef2);
        [self addSubview:_deletButton];
        
    }
    return self;
}

@end
