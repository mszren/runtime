//
//  RecommendCell.m
//  FamilysHelper
//
//  Created by shenbinbin on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RecomCell.h"

#import "UIImageView+AFNetworking.h"

@implementation RecomCell {
    EGOImageView* _imageUrl;
    UILabel* _projectName;
    UILabel* _projectAddress;
    UILabel* _retateMoney;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 90)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];

        _imageUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_90x70"]];

        _imageUrl.frame = CGRectMake(10, 10, 100, 70);
        [backGroundView addSubview:_imageUrl];

        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 200, 15)];
        _projectName.textColor = COLOR_GRAY_DEFAULT_30;
        _projectName.font = [UIFont systemFontOfSize:15];
        [backGroundView addSubview:_projectName];

        _projectAddress = [[UILabel alloc] initWithFrame:CGRectMake(120, 38, 200, 15)];
        _projectAddress.textColor = COLOR_GRAY_DEFAULT_185;
        _projectAddress.font = [UIFont systemFontOfSize:13];
        [backGroundView addSubview:_projectAddress];

        _retateMoney = [[UILabel alloc] initWithFrame:CGRectMake(120, 62, 200, 15)];
        _retateMoney.font = [UIFont systemFontOfSize:12];
        _retateMoney.textColor = COLOR_RED_DEFAULT_34e;
        [backGroundView addSubview:_retateMoney];
    }
    return self;
}

- (void)bindModel:(RecommendModel*)model
{

    if (![model.imageUrl isEqualToString:@""]) {
        [_imageUrl setImageWithURL:[[NSURL alloc] initWithString:model.imageUrl]];
    }
    _projectName.text = model.projectName;
    _projectAddress.text = model.projectAddress;
    _retateMoney.text = [NSString stringWithFormat:@"推荐佣金%.1f元", model.retateMoney.floatValue];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
