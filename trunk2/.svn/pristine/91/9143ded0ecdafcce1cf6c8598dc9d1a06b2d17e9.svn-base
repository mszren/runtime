//
//  MoreInteractionCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/17.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MoreInteractCell.h"
#import "UIImageView+AFNetworking.h"
#import <CoreText/CoreText.h>
#import "TribeService.h"
#import "UIView+Toast.h"

@implementation MoreInteractCell {
    EGOImageView* _iconUrl;
    UILabel* _topic;
    UILabel* _createTime;
    UILabel* _hitNum;
    UILabel* _replyNum;
    TopicModel* _topicModel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];

        UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(SCREEN_WIDTH - 50, 45, 40, 15);
        [saveButton setTitle:@"收藏" forState:UIControlStateNormal];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:8];
        saveButton.layer.borderWidth = 0.8;
        saveButton.layer.cornerRadius = 4;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.9, 0, 0, 1 });
        saveButton.layer.borderColor = borderColorRef;
        [saveButton setTitleColor:RedColor1 forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(onBtnSave:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:saveButton];

        _iconUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"]];
        _iconUrl.frame = CGRectMake(10, 10, 45, 45);
        [backView addSubview:_iconUrl];

        _topic = [[UILabel alloc] initWithFrame:CGRectMake(65, 13, 100, 15)];
        _topic.textColor = COLOR_GRAY_DEFAULT_30;
        _topic.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_topic];

        UIImageView* hitimage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 45, 12, 12)];
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

        UIImageView* replyImage = [[UIImageView alloc] initWithFrame:CGRectMake(235, 47, 12, 12)];
        replyImage.image = [UIImage imageNamed:@"ic_discussl"];
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
    _topicModel = model;
    if (![model.iconUrl isEqualToString:@""]) {
        [_iconUrl setImageWithURL:[AppImageUtil getImageURL:model.iconUrl Size:_iconUrl.frame.size]];
    }

    [_topic setText:model.topic];
    [_hitNum setText:[NSString stringWithFormat:@"%ld", (long)model.hitNum]];
    [_replyNum setText:[NSString stringWithFormat:@"%ld", (long)model.replyNum]];
    [_createTime setText:[NSDate dateYMDTimeInterval:model.createTime.doubleValue]];
}

#pragma mark
#pragma mark--UIButtonAction
- (void)onBtnSave:(UIButton*)sender
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
