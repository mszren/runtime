//
//  MoreInteractionCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MoreInteractionCell.h"
#import "UIImageView+AFNetworking.h"
#import <CoreText/CoreText.h>

@implementation MoreInteractionCell {
    UIImageView* _iconUrl;
    UILabel* _topic;
    UILabel* _createTime;
    UILabel* _hitNum;
    UILabel* _replyNum;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];

        _iconUrl = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        [backView addSubview:_iconUrl];

        _topic = [[UILabel alloc] initWithFrame:CGRectMake(65, 13, 100, 15)];
        _topic.textColor = COLOR_GRAY_DEFAULT_30;
        _topic.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_topic];

        UIImageView* hitimage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 43, 12, 12)];
        hitimage.image = [UIImage imageNamed:@"ic_recommend"];
        [backView addSubview:hitimage];

        _hitNum = [[UILabel alloc] initWithFrame:CGRectMake(87, 43, 15, 15)];
        _hitNum.textColor = COLOR_GRAY_DEFAULT_185;
        _hitNum.font = [UIFont systemFontOfSize:12];
        [backView addSubview:_hitNum];

        UIImageView* timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(110, 46, 12, 12)];
        timeImage.image = [UIImage imageNamed:@"icon_time"];
        [backView addSubview:timeImage];

        _createTime = [[UILabel alloc] initWithFrame:CGRectMake(127, 45, 120, 15)];
        _createTime.textColor = COLOR_GRAY_DEFAULT_185;
        _createTime.font = [UIFont systemFontOfSize:12];
        [backView addSubview:_createTime];

        UIImageView* replyImage = [[UIImageView alloc] initWithFrame:CGRectMake(235, 45, 12, 12)];
        replyImage.image = [UIImage imageNamed:@""];
        [backView addSubview:replyImage];

        _replyNum = [[UILabel alloc] initWithFrame:CGRectMake(252, 44, 20, 15)];
        _replyNum.textColor = COLOR_GRAY_DEFAULT_185;
        _replyNum.font = [UIFont systemFontOfSize:12];
        [backView addSubview:_replyNum];
    }
    return self;
}

- (void)bindModel:(TopicModel*)model
{

    [_iconUrl setImageWithURL:[AppImageUtil getImageURL:model.iconUrl Size:_iconUrl.frame.size]];
    [_topic setText:model.topic];
    [_hitNum setText:[NSString stringWithFormat:@"%ld", (long)model.hitNum]];
    [_replyNum setText:[NSString stringWithFormat:@"%ld", (long)model.replyNum]];
    [_createTime setText:[NSDate dateYMDTimeInterval:model.createTime.integerValue]];
}

@end
