//
//  ActivityCell.m
//  FamilysHelper
//
//  Created by 我 on 15/7/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BangActivityCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+Toast.h"
#import "TribeService.h"

@implementation BangActivityCell {
    EGOImageView* _imagUrl;
    UILabel* _titleLabel;
    UILabel* _hitNumLabel;
    UILabel* _replyNumLabel;
    UIImageView* _isTopImage;
    UIView* _hitView;
    UIView* _replyGroundView;
    ActivityModel* _activityModel;
    UIButton* statusButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        statusButton.frame = CGRectMake(0, 0, 47, 47);
        _imagUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_320x215"]];
        _imagUrl.frame = CGRectMake(0, 10, SCREEN_WIDTH, 200);
        _imagUrl.userInteractionEnabled = YES;
        [self addSubview:_imagUrl];

        _isTopImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 0, 20, 19)];
        _isTopImage.image = [UIImage imageNamed:@"ic_ding_bhd"];
        [_imagUrl addSubview:_isTopImage];

        UIView* titleGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 163, SCREEN_WIDTH, 37)];
        titleGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [_imagUrl addSubview:titleGroundView];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 33)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [titleGroundView addSubview:_titleLabel];

        _replyGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 49, 18)];
        _replyGroundView.layer.cornerRadius = 8;
        _replyGroundView.clipsToBounds = YES;
        _replyGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _replyGroundView.userInteractionEnabled = YES;
        [_imagUrl addSubview:_replyGroundView];

        UIImageView* replyImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3.5, 11.5, 11.5)];
        replyImage.userInteractionEnabled = YES;
        replyImage.image = [UIImage imageNamed:@"table_ic_pl_bai"];
        [_replyGroundView addSubview:replyImage];

        _replyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 25, 18)];
        _replyNumLabel.textColor = [UIColor whiteColor];
        _replyNumLabel.font = [UIFont systemFontOfSize:13];
        [_replyGroundView addSubview:_replyNumLabel];

        _hitView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 59, 30, 49, 18)];
        _hitView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _hitView.userInteractionEnabled = YES;
        _hitView.layer.cornerRadius = 8;
        _hitView.clipsToBounds = YES;
        [_imagUrl addSubview:_hitView];

        UIImageView* hitImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3.5, 11.5, 11.5)];
        hitImage.image = [UIImage imageNamed:@"table_ic_zan_bai"];
        hitImage.userInteractionEnabled = YES;
        [_hitView addSubview:hitImage];

        _hitNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 25, 18)];
        _hitNumLabel.textColor = [UIColor whiteColor];
        _hitNumLabel.font = [UIFont systemFontOfSize:13];
        [_hitView addSubview:_hitNumLabel];

        UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(SCREEN_WIDTH - 55, 90, 40, 20);
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
        [self addSubview:saveButton];
    }
    return self;
}

- (void)bindModel:(ActivityModel*)model
{
    _activityModel = model;
    if (model.activityStatus == 0) {
        [statusButton setBackgroundImage:[UIImage imageNamed:@"ic_wks_hdz"]
                                forState:UIControlStateNormal];
    }
    else if (model.activityStatus == 1) {

        [statusButton setBackgroundImage:[UIImage imageNamed:@"ic_jxz_hdz"]
                                forState:UIControlStateNormal];
    }
    else if (model.activityStatus == 2) {

        [statusButton setBackgroundImage:[UIImage imageNamed:@"ic_yjs_hdz"]
                                forState:UIControlStateNormal];
    }
    [_imagUrl addSubview:statusButton];
    _replyNumLabel.text = [NSString stringWithFormat:@"%ld", (long)model.replyNum];
    _hitNumLabel.text = [NSString stringWithFormat:@"%ld", (long)model.hitNum];
    _titleLabel.text = model.title;
    if (![model.image isEqualToString:@""]) {
        [_imagUrl setImageURL:[AppImageUtil getImageURL:model.image Size:_imagUrl.frame.size]];
    }
    if (model.isTop == 0) {
        _isTopImage.hidden = YES;
    }
}
 

- (void)lodeData
{

    [[TribeService shareInstance] getBangActivityList:_tribelId
                                           nextCursor:_nextCursor
                                            OnSuccess:^(DataModel* dataModel) {
                                                if (dataModel.code == 200) {
                                                    ActivityModel* activityModel = dataModel.data[self.row];
                                                    _hitNumLabel.text = [NSString stringWithFormat:@"%ld", (long)activityModel.hitNum];
                                                }

                                            }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark
#pragma mark--UIButtonAction
- (void)onBtnSave:(UIButton*)sender
{

    [[TribeService shareInstance] addMyCollect:[CurrentAccount currentAccount].uid
                                          type:2
                                      objectId:_activityModel.activityId
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
