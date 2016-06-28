//
//  ActivityCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ActivityCell {
    EGOImageView* _activityImage;
    UIButton* _bangbiButton;
    UILabel* _addressLabel;
    UILabel* _bangbiLabel;
    UILabel* _titleLabel;
    UIView* _backGroundView;
    UILabel* _beginlabel;
    UILabel* _endLabel;
    UIButton* _typeButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 325)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        _backGroundView.layer.cornerRadius = 4;
        _backGroundView.clipsToBounds = YES;
        [self addSubview:_backGroundView];

        _activityImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_320x215"]];
        _activityImage.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 205);
        _activityImage.layer.cornerRadius = 4;
        _activityImage.clipsToBounds = YES;
        [_backGroundView addSubview:_activityImage];

        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _typeButton.frame = CGRectMake(0, 0, 47, 47);
        [_activityImage addSubview:_typeButton];

        _bangbiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bangbiButton.frame = CGRectMake(SCREEN_WIDTH - 55, 160, 30, 30);
        _bangbiButton.layer.cornerRadius = 15;
        _bangbiButton.clipsToBounds = YES;
        _bangbiButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_bangbiButton setBackgroundColor:[UIColor redColor]];
        [_backGroundView addSubview:_bangbiButton];

        //背景线
        UILabel* backGroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 239, SCREEN_WIDTH - 40, 1)];
        backGroundLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [_backGroundView addSubview:backGroundLabel];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 215, 250, 15)];
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_30;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_backGroundView addSubview:_titleLabel];

        UIImageView* timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250, 12, 12)];
        timeImage.image = [UIImage imageNamed:@"ic_time_hdz"];
        [_backGroundView addSubview:timeImage];

        UIImageView* addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 275, 12, 12)];
        addressImage.image = [UIImage imageNamed:@"ic_add_hdz"];
        [_backGroundView addSubview:addressImage];

        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 275, SCREEN_WIDTH - 50, 15)];
        _addressLabel.textColor = COLOR_RED_DEFAULT_04;
        _addressLabel.font = [UIFont systemFontOfSize:13];
        [_backGroundView addSubview:_addressLabel];

        UIImageView* bangbiImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, 12, 12)];
        bangbiImage.image = [UIImage imageNamed:@"ic_money_hdz"];
        [_backGroundView addSubview:bangbiImage];

        _bangbiLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 300, 220, 15)];
        _bangbiLabel.textColor = COLOR_RED_DEFAULT_04;
        _bangbiLabel.font = [UIFont systemFontOfSize:13];
        [_backGroundView addSubview:_bangbiLabel];

        //开始时间
        _beginlabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 7 * (11 + 9), 15)];
        _beginlabel.textColor = COLOR_RED_DEFAULT_04;
        _beginlabel.font = [UIFont systemFontOfSize:13];
        [_backGroundView addSubview:_beginlabel];

        //结束时间
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + _beginlabel.bounds.size.width, 250, 100, 15)];
        _endLabel.textColor = COLOR_RED_DEFAULT_04;
        _endLabel.font = [UIFont systemFontOfSize:13];
        [_backGroundView addSubview:_endLabel];
    }
    return self;
}

- (void)bindModel:(ActivityModel*)model
{

    if (![model.imageName isEqualToString:@""]) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@@1e_%dw_%dh_1c_0i_1o_90Q_1x.jpg",
                                                    model.imageName, (int)_activityImage.frame.size.width * (int)SCREEN_SCALE, (int)_activityImage.frame.size.height * (int)SCREEN_SCALE]];
        [_activityImage setImageURL:url];
    }

    _titleLabel.text = model.title;
    _addressLabel.text = [NSString stringWithFormat:@"活动地址:%@", model.address];
    _bangbiLabel.text = [NSString stringWithFormat:@"签到可赚:%ld帮币", (long)model.money];

    [_bangbiButton setTitle:[NSString stringWithFormat:@"¥%ld", (long)model.money] forState:UIControlStateNormal];

    _beginlabel.text = [NSString stringWithFormat:@"活动时间:%@ - ", model.beginTimeStr];
    _endLabel.text = model.endTimeStr;

    if (model.objectType == 0) {

        [_typeButton setBackgroundImage:[UIImage imageNamed:@"ic_wks_hdz"]
                               forState:UIControlStateNormal];
    }
    else if (model.objectType == 1) {
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"ic_jxz_hdz"]
                               forState:UIControlStateNormal];
    }
    else {
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"ic_yjs_hdz"]
                               forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
