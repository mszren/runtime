//
//  MyTopicCell.m
//  FamilysHelper
//
//  Created by Owen on 15/6/5.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyTopicCell.h"
#import <CoreText/CoreText.h>

@interface MyTopicCell () {

    UILabel* _lblTitle;
    UILabel* _lblShopName;
    UILabel* _lblTags;
    EGOImageView* _ivIconUrl;
    UIImageView* _icUser;
    UILabel* _lblUserName;
    UIImageView* _icTime;
    UILabel* _lblTime;
    UIImageView* _icReplyNum;
    UILabel* _lblReplyNum;

    UIImageView* _icHitNum;
    UILabel* _lblHitNum;
    TopicModel* _topicModel;
}

@end

@implementation MyTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        sectionView.backgroundColor = AllTableViewColor;
        [self addSubview:sectionView];

        _lblTitle = [[UILabel alloc] init];
        _lblTitle.frame = CGRectMake(10, 20, SCREEN_WIDTH - 70, 30);
        [_lblTitle setFont:TableCellTitleFont];
        [_lblTitle setTextColor:TableCellTitleColor];
        [self addSubview:_lblTitle];

        _ivIconUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivIconUrl.frame = CGRectMake(SCREEN_WIDTH - 60, 25, 50, 50);
        [self addSubview:_ivIconUrl];

        _lblShopName = [[UILabel alloc] init];

        [_lblShopName setFont:TableCellDescFont];
        [_lblShopName setTextColor:TableCellDescColor];
        _lblShopName.frame = CGRectMake(_lblTitle.frame.origin.x, _lblTitle.frame.origin.y + _lblTitle.frame.size.height, 150, 30);
        [self addSubview:_lblShopName];

        _lblTags = [[UILabel alloc] init];

        [_lblTags setFont:TableCellDescFont];
        [_lblTags setTextColor:TableCellDescColor];
        _lblTags.frame = CGRectMake(_lblShopName.frame.origin.x + _lblShopName.frame.size.width + 10, _lblShopName.frame.origin.y, 100, 30);
        [self addSubview:_lblTags];

        UIView* separatorView = [[UIView alloc] initWithFrame:CGRectMake(10, _ivIconUrl.frame.origin.y + _ivIconUrl.frame.size.height + 15, SCREEN_WIDTH - 20, 1)];
        separatorView.backgroundColor = TableSeparatorColor;
        [self addSubview:separatorView];

        _icUser = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_nickname"]];
        _icUser.frame = CGRectMake(10, separatorView.frame.origin.y + 10, _icUser.frame.size.width, _icUser.frame.size.height);
        [self addSubview:_icUser];

        _lblHitNum = [[UILabel alloc] init];
        [_lblHitNum setText:@"6"];
        _lblHitNum.textColor = TableCellDescColor;
        _lblHitNum.font = TableCellTimeFont;
        _lblHitNum.frame = CGRectMake(0, 0, 20, 30);
        _lblHitNum.center = CGPointMake(SCREEN_WIDTH - 20, _icUser.center.y);
        [self addSubview:_lblHitNum];

        _icHitNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_love"]];
        _icHitNum.center = CGPointMake(_lblHitNum.frame.origin.x - _icHitNum.frame.size.width / 2 - 10, _icUser.center.y);
        [self addSubview:_icHitNum];

        _lblReplyNum = [[UILabel alloc] init];
        [_lblReplyNum setText:@"9"];
        _lblReplyNum.textColor = TableCellDescColor;
        _lblReplyNum.font = TableCellTimeFont;
        _lblReplyNum.frame = CGRectMake(0, 0, 20, 30);
        _lblReplyNum.center = CGPointMake(_icHitNum.frame.origin.x - _lblReplyNum.frame.size.width / 2 - 10, _lblHitNum.center.y);
        [self addSubview:_lblReplyNum];

        _icReplyNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_comment"]];
        _icReplyNum.center = CGPointMake(_lblReplyNum.frame.origin.x - _icReplyNum.frame.size.width / 2 - 10, _icUser.center.y);
        [self addSubview:_icReplyNum];

        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = TableCellDescColor;
        _lblTime.font = TableCellTimeFont;
        _lblTime.frame = CGRectMake(0, 0, 50, 30);
        _lblTime.center = CGPointMake(_icReplyNum.frame.origin.x - _lblTime.frame.size.width / 2 - 10, _lblHitNum.center.y);
        [self addSubview:_lblTime];

        _icTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_time"]];
        _icTime.center = CGPointMake(_lblTime.frame.origin.x - _icTime.frame.size.width / 2 - 10, _icUser.center.y);
        [self addSubview:_icTime];

        _lblUserName = [[UILabel alloc] init];
        _lblUserName.textColor = TableCellDescColor;
        _lblUserName.font = TableCellTimeFont;
        _lblUserName.frame = CGRectMake(0, 0, _icTime.frame.origin.x - (_icUser.frame.origin.x + _icUser.frame.size.width + 20), 20);
        _lblUserName.center = CGPointMake(20 + _icUser.frame.size.width + _lblUserName.frame.size.width / 2, _icUser.center.y);
        [self addSubview:_lblUserName];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindTopic:(TopicModel*)model
{

    _topicModel = model;
    [_lblTitle setText:_topicModel.topic];
    [_lblShopName setText:_topicModel.shopName];
    [_lblTags setText:[NSString stringWithFormat:@"#%@#", _topicModel.tagsName]];

    _lblTags.textColor = [self getColor:_topicModel.tagsColor];

    [_lblTime setText:[NSDate daySinceTimeInterval:_topicModel.createTime.doubleValue/ 1000.0f]];
    [_lblUserName setText:_topicModel.nickname];
    [_lblHitNum setText:[NSString stringWithFormat:@"%ld", (long)_topicModel.hitNum]];
    [_lblReplyNum setText:[NSString stringWithFormat:@"%ld", (long)_topicModel.replyNum]];
    if (_topicModel.iconUrl==nil||[_topicModel.iconUrl isEqualToString:@""]) {
        [_ivIconUrl setImage:[UIImage imageNamed:@"ic_face"]];
    }else{
        [_ivIconUrl setImageURL:[AppImageUtil getImageURL:_topicModel.iconUrl Size:_ivIconUrl.frame.size]];
    }
}

HEXColor_Method

    @end
