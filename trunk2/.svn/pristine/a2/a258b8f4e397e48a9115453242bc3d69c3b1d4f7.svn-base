//
//  StatisticsView.m
//  FamilysHelper
//
//  Created by Owen on 15/5/28.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "StatisticsView.h"
#import <CoreText/CoreText.h>

@interface StatisticsView () {

    UILabel* _lblTitle;
}

@end

@implementation StatisticsView

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 37);
        self.backgroundColor = BGViewGray;
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 80, 37)];
        [_lblTitle setFont:FONT_SIZE(12)];
        [self addSubview:_lblTitle];
        _btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSetting.frame = CGRectMake(SCREEN_WIDTH - 70, 10, 60, 20);
        _btnSetting.backgroundColor = HomeNavBarBgColor;
        [_btnSetting setTintColor:HomeNavBarTitleColor];
        [_btnSetting setTitle:@"设置小区" forState:UIControlStateNormal];
        _btnSetting.titleLabel.font = FONT_SIZE(12);
        _btnSetting.layer.cornerRadius = 10.0;

        [self addSubview:_btnSetting];
    }
    return self;
}

- (void)setName:(NSString*)name count:(NSInteger)count
{
    [_lblTitle setText:[NSString stringWithFormat:@"%@有%ld位邻居", name, (long)count]];
}

@end
