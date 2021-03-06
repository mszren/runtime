//
//  ShareCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShareCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ShareCell {
    EGOImageView* _image;
    UILabel* _bangbiLabel;
    UILabel* _timeLabel;
    UILabel* _titleLabel;
    UILabel* _limitNum;
    UILabel* _limitPerNum;
    UIButton* _statusButton;
    UILabel* _profitLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 222)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];

        _statusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _statusButton.frame = CGRectMake(10, 10, 30, 30);
        _statusButton.layer.cornerRadius = 15;
        _statusButton.clipsToBounds = YES;
        [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _statusButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_statusButton setBackgroundColor:[UIColor redColor]];
        [backGroundView addSubview:_statusButton];

        UILabel* shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 118, 15)];
        shareLabel.text = @"分享并被阅读1次可赚";
        shareLabel.font = [UIFont systemFontOfSize:12];
        shareLabel.textColor = COLOR_GRAY_DEFAULT_30;
        [backGroundView addSubview:shareLabel];

        _bangbiLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 + shareLabel.bounds.size.width, 10, 40, 15)];
        _bangbiLabel.font = [UIFont systemFontOfSize:12];
        _bangbiLabel.textColor = COLOR_RED_DEFAULT_34e;
        [backGroundView addSubview:_bangbiLabel];

        _limitNum = [[UILabel alloc] initWithFrame:CGRectMake(50, 31, 80, 15)];
        _limitNum.font = [UIFont systemFontOfSize:12];
        _limitNum.textColor = COLOR_GRAY_DEFAULT_30;
        [backGroundView addSubview:_limitNum];

        _limitPerNum = [[UILabel alloc] initWithFrame:CGRectMake(50 + _limitNum.bounds.size.width, 31, 100, 15)];
        _limitPerNum.textColor = COLOR_RED_DEFAULT_34e;
        _limitPerNum.font = [UIFont systemFontOfSize:12];
        [backGroundView addSubview:_limitPerNum];

        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 52, 140, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_185;
        [backGroundView addSubview:_timeLabel];

        _image = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_90x70"]];

        _image.frame = CGRectMake(10, 82, SCREEN_WIDTH - 40, 130);
        [backGroundView addSubview:_image];

        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH - 40, 30)];
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [_image addSubview:backView];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 280, 15)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [backView addSubview:_titleLabel];

        //灰色label
        UILabel* backLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 10, 1, 57)];
        backLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [backGroundView addSubview:backLabel];

        UILabel* readLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 10, 100, 15)];
        readLabel.text = @"阅读此文有惊喜";
        readLabel.textColor = COLOR_GRAY_DEFAULT_30;
        readLabel.font = [UIFont systemFontOfSize:13];
        [backGroundView addSubview:readLabel];

        UIButton* frame = [UIButton buttonWithType:UIButtonTypeSystem];
        frame.frame = CGRectMake(SCREEN_WIDTH - 111, 34, 80, 28);
        frame.layer.borderWidth = 0.8;
        frame.layer.cornerRadius = 4;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
        CGColorSpaceRelease(colorSpace);
        frame.layer.borderColor = borderColorRef;
        CGColorRelease(borderColorRef);
        [backGroundView addSubview:frame];

        UILabel* proLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 40, 25, 15)];
        proLabel.textColor = COLOR_GRAY_DEFAULT_30;
        proLabel.font = [UIFont systemFontOfSize:12];
        proLabel.text = @"可赚";
        [backGroundView addSubview:proLabel];

        _profitLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 74, 40, 100, 15)];
        _profitLabel.textColor = COLOR_RED_DEFAULT_34e;
        _profitLabel.font = [UIFont systemFontOfSize:12];
        [backGroundView addSubview:_profitLabel];
    }
    return self;
}

- (void)bindModel:(ShareModel*)model
{

    _bangbiLabel.text = [NSString stringWithFormat:@"%ld帮币", (long)model.money];
    _limitNum.text = [NSString stringWithFormat:@"最多%ld次,共发", (long)model.limitNum];
    _limitPerNum.text = [NSString stringWithFormat:@"%ld帮币", (long)model.sumMoney];
    _timeLabel.text = [NSString stringWithFormat:@"截止时间:%@", model.endTimeStr];
    [_statusButton setTitle:[NSString stringWithFormat:@"%ld", (long)model.stauts] forState:UIControlStateNormal];

    if (![model.logoImg isEqualToString:@""]) {
        NSMutableString* stringImage = [[NSMutableString alloc] initWithFormat:@"%@", model.logoImg];
        NSRange range = [stringImage rangeOfString:@"http://image.wevaluing.com/"];
        [stringImage deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
        [_image setImageURL:[AppImageUtil getImageURL:stringImage Height:_image.frame.size.height]];
    }

    _titleLabel.text = model.title;
    _profitLabel.text = [NSString stringWithFormat:@"%ld帮币", (long)model.money];
}

@end
