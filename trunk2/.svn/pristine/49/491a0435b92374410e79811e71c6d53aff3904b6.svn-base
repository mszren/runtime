//
//  InteractionCell.m
//  FamilysHelper
//
//  Created by Owen on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "InteractionCell.h"
#import <CoreText/CoreText.h>
#import "UIView+Toast.h"
#import "TribeService.h"

@interface InteractionCell () {

    UILabel* _lblTitle;
    UILabel* _lblShopName;
    UILabel* _lblTags;
    EGOImageView* _ivIconUrl;
    UIImageView* _icPic;
    UIImageView* _icTop;
    UIImageView* _icEssence;
    UIImageView* _icTime;
    UILabel* _lblTime;
    UIImageView* _icReplyNum;
    UILabel* _lblReplyNum;
    UIView* containerView;
    UIImageView* _icHitNum;
    UILabel* _lblHitNum;
    TopicModel* _topicModel;
}

@end

@implementation InteractionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 80)];
        containerView.backgroundColor = [UIColor whiteColor];
        [containerView.layer setBorderWidth:0.5];
        [containerView.layer setBorderColor:TableSeparatorColor.CGColor];
        [self addSubview:containerView];

        UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(SCREEN_WIDTH - 50, 45, 40, 23);
        [saveButton setTitle:@"收藏" forState:UIControlStateNormal];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
        saveButton.layer.borderWidth = 0.8;
        saveButton.layer.cornerRadius = 4;

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
        CGColorSpaceRelease(colorSpace);
        saveButton.layer.borderColor = borderColorRef;
        CGColorRelease(borderColorRef);
        [saveButton setTitleColor:RedColor1 forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(onBtnSave:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:saveButton];

        _ivIconUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivIconUrl.frame = CGRectMake(10, 15, 50, 50);
        [containerView addSubview:_ivIconUrl];
        _icTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_dingpic"]];
        _icTop.frame = CGRectMake(_ivIconUrl.frame.size.width + 20, 15, 15, 15);

        _icEssence = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_jingpic"]];
        _icEssence.frame = CGRectMake(_ivIconUrl.frame.size.width + 40, 15, 15, 15);

        _lblTitle = [[UILabel alloc] init];
        _lblTitle.frame = CGRectMake(_ivIconUrl.frame.size.width + 60, 10, containerView.frame.size.width - _ivIconUrl.frame.size.width - 20, 25);
        [_lblTitle setFont:TableCellTitleFont];
        [_lblTitle setTextColor:TableCellTitleColor];
        [containerView addSubview:_lblTitle];

        _icPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pic"]];
        _icPic.frame = CGRectMake(_lblTitle.frame.size.width + _lblTitle.frame.origin.x + 10, 15, 15, 15);
        [containerView addSubview:_icPic];

        _icHitNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_recommend"]];
        _icHitNum.frame = CGRectMake(70, 50, 14, 14);
        [containerView addSubview:_icHitNum];

        _lblHitNum = [[UILabel alloc] init];
        _lblHitNum.textColor = TableCellDescColor;
        _lblHitNum.font = TableCellTimeFont;
        [containerView addSubview:_lblHitNum];

        _icReplyNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_comment"]];
        [containerView addSubview:_icReplyNum];

        _lblReplyNum = [[UILabel alloc] init];
        _lblReplyNum.textColor = TableCellDescColor;
        _lblReplyNum.font = TableCellTimeFont;
        [containerView addSubview:_lblReplyNum];

        _icTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_time"]];
        [containerView addSubview:_icTime];

        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = TableCellDescColor;
        _lblTime.font = TableCellTimeFont;
        [containerView addSubview:_lblTime];
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
    NSInteger width = 20;
    if (model.isTop == 1) {
        [containerView addSubview:_icTop];
        width = 40;
    }
    else {

        [_icTop removeFromSuperview];
    }

    if (model.isEssence == 1) {
        [containerView addSubview:_icEssence];
        width = 60;
    }
    else {

        [_icEssence removeFromSuperview];
    }
    NSString* strTagName = [NSString stringWithFormat:@"#%@#", _topicModel.topic];
    CGRect labelRect = [strTagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)attributes:[NSDictionary dictionaryWithObject:FONT_SIZE_12 forKey:NSFontAttributeName] context:nil];
    [_lblTitle setText:_topicModel.topic];
    _lblTitle.frame = CGRectMake(_ivIconUrl.frame.size.width + width, 10, labelRect.size.width, 25);
    [_lblShopName setText:_topicModel.shopName];
    _icPic.frame = CGRectMake(_lblTitle.frame.size.width + _lblTitle.frame.origin.x + 5, 15, 15, 15);

    [_lblTime setText:[NSDate daySinceTimeInterval:_topicModel.createTime.doubleValue / 1000]];
    [_lblHitNum setText:[NSString stringWithFormat:@"%ld", (long)_topicModel.hitNum]];
    [_lblReplyNum setText:[NSString stringWithFormat:@"%ld", (long)_topicModel.replyNum]];
    if (![_topicModel.face isEqualToString:@""]) {
        [_ivIconUrl setImageURL:[AppImageUtil getImageURL:_topicModel.face Size:_ivIconUrl.frame.size]];
    }
    _lblHitNum.frame = CGRectMake(90, 50, 20, 15);
    _icTime.frame = CGRectMake(_lblHitNum.frame.origin.x + 25, 50, 14, 14);
    _lblTime.frame = CGRectMake(_lblHitNum.frame.origin.x + 40, 50, 70, 15);
    _icReplyNum.frame = CGRectMake(_lblHitNum.frame.origin.x + 100, 50, 14, 14);
    _lblReplyNum.frame = CGRectMake(_lblHitNum.frame.origin.x + 115, 50, 20, 15);
}

HEXColor_Method

#pragma mark
#pragma mark--UIButtonAction
    - (void)onBtnSave : (UIButton*)sender
{

    [[TribeService shareInstance] addMyCollect:[CurrentAccount currentAccount].uid
                                          type:1
                                      objectId:_topicModel.publishId
                                     OnSuccess:^(DataModel* dataModel) {

                                         if (dataModel.code == 202) {
                                             [self makeToast:@"收藏成功" duration:1.5 position:nil];
                                         }
                                         else {

                                             [self makeToast:dataModel.error duration:1.5 position:nil];
                                         }
                                     }];
}

@end
