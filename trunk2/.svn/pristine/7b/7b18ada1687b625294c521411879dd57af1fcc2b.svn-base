//
//  hotTribeView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "HotTribeCell.h"
#import "IndexModel.h"
#import "TribeModel.h"
#import "IndexService.h"
#import "TribeService.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+Toast.h"
#import "BangIndexController.h"
#import "AppImageUtil.h"

@implementation HotTribeCell {
    UIView* _hotTribeView;
    UILabel* _shopNameLabel;
    UILabel* _attentionNumLabel;
    UILabel* _contentNumLabel;
    UIButton* _attentionButton;

    UILabel* _shopNameLabel2;
    UILabel* _attentionNumLabel2;
    UILabel* _contentNumLabel2;
    UIButton* _attentionButton2;

    UILabel* _shopNameLabel3;
    UILabel* _attentionNumLabel3;
    UILabel* _contentNumLabel3;
    UIButton* _attentionButton3;

    TribeModel* _tribe;
    TribeModel* _tribe2;
    TribeModel* _tribe3;
    TribeModel* _surroundModel;
    UIButton* _button;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        NSInteger width = (SCREEN_WIDTH - 40) / 3;
        _hotTribeView =
            [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + 280 / 3 * (SCREEN_WIDTH / 320))];
        _hotTribeView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hotTribeView];

        UILabel* backgroundLabel =
            [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 2, 15)];
        backgroundLabel.backgroundColor = COLOR_GRAY_DEFAULT_62;
        [_hotTribeView addSubview:backgroundLabel];

        UILabel* topicLabel =
            [[UILabel alloc] initWithFrame:CGRectMake(22, 15, 100, 15)];
        topicLabel.text = @"热门帮帮";
        topicLabel.textColor = COLOR_GRAY_DEFAULT_30;
        topicLabel.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:topicLabel];

        UIButton* changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        changeButton.frame = CGRectMake(SCREEN_WIDTH - 52, 15, 50, 15);
        [changeButton setTitle:@"换一组" forState:UIControlStateNormal];
        changeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [changeButton setTitleColor:COLOR_GRAY_DEFAULT_62
                           forState:UIControlStateNormal];
        [changeButton addTarget:self
                         action:@selector(onBtnChange:)
               forControlEvents:UIControlEventTouchUpInside];
        [_hotTribeView addSubview:changeButton];

        /**
     1
     */

        _tribeImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _tribeImage.frame = CGRectMake(10, 45, width, width);
        _tribeImage.userInteractionEnabled = YES;
        _tribeImage.tag = 300;
        [_hotTribeView addSubview:_tribeImage];

        _shopNameLabel = [[UILabel alloc]
            initWithFrame:CGRectMake(10, width + 55, width, 15)];
        _shopNameLabel.textColor = COLOR_GRAY_DEFAULT_30;
        _shopNameLabel.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_shopNameLabel];

        _attentionNumLabel = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _shopNameLabel.frame.origin.y + _shopNameLabel.frame.size.height + 5, width, 15)];

        _attentionNumLabel.textColor = COLOR_GRAY_DEFAULT_185;
        _attentionNumLabel.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_attentionNumLabel];

        _contentNumLabel = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _attentionNumLabel.frame.origin.y + _attentionNumLabel.frame.size.height + 5, width, 15)];
        _contentNumLabel.textColor = COLOR_GRAY_DEFAULT_185;
        _contentNumLabel.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_contentNumLabel];

        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton setTitle:@"围观" forState:UIControlStateNormal];
        _attentionButton.layer.cornerRadius = 4;
        _attentionButton.clipsToBounds = YES;
        _attentionButton.tag = 200;
        _attentionButton.frame = CGRectMake(10 + (width - 50) / 2, _contentNumLabel.frame.origin.y + _contentNumLabel.frame.size.height + 10, 50, 24);
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:13];

        [_attentionButton addTarget:self
                             action:@selector(onBtnAttention:)
                   forControlEvents:UIControlEventTouchUpInside];
        [_hotTribeView addSubview:_attentionButton];

        /**
     2
     */
        _tribeImage2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _tribeImage2.frame = CGRectMake(20 + width, 45, width,
            width);
        _tribeImage2.userInteractionEnabled = YES;
        _tribeImage2.tag = 301;
        [_hotTribeView addSubview:_tribeImage2];

        _shopNameLabel2 = [[UILabel alloc]
            initWithFrame:CGRectMake(20 + width, width + 55, width,
                              15)];
        _shopNameLabel2.textColor = COLOR_GRAY_DEFAULT_30;
        _shopNameLabel2.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_shopNameLabel2];

        _attentionNumLabel2 = [[UILabel alloc]
            initWithFrame:CGRectMake(20 + width, _shopNameLabel2.frame.origin.y + _shopNameLabel2.frame.size.height + 5, width,
                              15)];

        _attentionNumLabel2.textColor = COLOR_GRAY_DEFAULT_185;
        _attentionNumLabel2.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_attentionNumLabel2];

        _contentNumLabel2 = [[UILabel alloc]
            initWithFrame:CGRectMake(20 + width, _attentionNumLabel2.frame.origin.y + _attentionNumLabel2.frame.size.height + 5, width,
                              15)];

        _contentNumLabel2.textColor = COLOR_GRAY_DEFAULT_185;
        _contentNumLabel2.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_contentNumLabel2];

        _attentionButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton2 setTitle:@"围观" forState:UIControlStateNormal];
        _attentionButton2.layer.cornerRadius = 4;
        _attentionButton2.clipsToBounds = YES;
        _attentionButton2.tag = 201;
        _attentionButton2.frame = CGRectMake(20 + width + (width - 50) / 2, _contentNumLabel2.frame.origin.y + _contentNumLabel2.frame.size.height + 10, 50, 24);
        _attentionButton2.titleLabel.font = [UIFont systemFontOfSize:13];

        [_attentionButton2 addTarget:self
                              action:@selector(onBtnAttention:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_hotTribeView addSubview:_attentionButton2];

        /**
     3
     */
        _tribeImage3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];

        _tribeImage3.frame = CGRectMake(30 + 2 * width, 45, width,
            width);
        _tribeImage3.userInteractionEnabled = YES;
        _tribeImage3.tag = 302;
        [_hotTribeView addSubview:_tribeImage3];

        _shopNameLabel3 = [[UILabel alloc]
            initWithFrame:CGRectMake(30 + 2 * width, width + 55, width,
                              15)];
        _shopNameLabel3.textColor = COLOR_GRAY_DEFAULT_30;
        _shopNameLabel3.font = [UIFont systemFontOfSize:13];
        [_hotTribeView addSubview:_shopNameLabel3];

        _attentionNumLabel3 = [[UILabel alloc]
            initWithFrame:CGRectMake(30 + 2 * width, _shopNameLabel3.frame.origin.y + _shopNameLabel3.frame.size.height + 5, width,
                              15)];

        _attentionNumLabel3.textColor = COLOR_GRAY_DEFAULT_185;
        _attentionNumLabel3.font = [UIFont systemFontOfSize:13];

        [_hotTribeView addSubview:_attentionNumLabel3];

        _contentNumLabel3 = [[UILabel alloc]
            initWithFrame:CGRectMake(30 + 2 * width, _attentionNumLabel3.frame.origin.y + _attentionNumLabel3.frame.size.height + 5, width,
                              15)];

        _contentNumLabel3.textColor = COLOR_GRAY_DEFAULT_185;
        _contentNumLabel3.font = [UIFont systemFontOfSize:13];

        [_hotTribeView addSubview:_contentNumLabel3];

        _attentionButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton3 setTitle:@"围观" forState:UIControlStateNormal];
        _attentionButton3.layer.cornerRadius = 4;
        _attentionButton3.clipsToBounds = YES;
        _attentionButton3.tag = 202;
        _attentionButton3.frame = CGRectMake(30 + 2 * width + (width - 50) / 2, _contentNumLabel3.frame.origin.y + _contentNumLabel3.frame.size.height + 10, 50, 24);

        _attentionButton3.titleLabel.font = [UIFont systemFontOfSize:13];

        [_attentionButton3 addTarget:self
                              action:@selector(onBtnAttention:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_hotTribeView addSubview:_attentionButton3];
    }
    return self;
}

- (void)bindTribe:(NSArray*)model
{

    NSMutableArray* hotViewArry = [[NSMutableArray alloc] initWithCapacity:0];
    if ([model isKindOfClass:[NSArray class]]) {

        [hotViewArry addObjectsFromArray:model];

        _tribe = hotViewArry[0];
        _tribe2 = hotViewArry[1];
        _tribe3 = hotViewArry[2];

        /**
     *  1
     *
     */

        [_tribeImage setImageURL:[AppImageUtil getImageURL:_tribe.shopImages Size:_tribeImage.frame.size]];

        _shopNameLabel.text = _tribe.shopName;

        _attentionNumLabel.text =
            [NSString stringWithFormat:@"关注 %ld", (long)_tribe.attentionNum];

        _contentNumLabel.text =
            [NSString stringWithFormat:@"话题 %ld", (long)_tribe.contentNum];

        if (_tribe.isattention == 1) {

            _attentionButton.backgroundColor = COLOR_GRAY_DEFAULT_185;
        }
        else {

            _attentionButton.backgroundColor = [UIColor orangeColor];
        }

        /**
     *  2
     *
     */
        [_tribeImage2 setImageURL:[AppImageUtil getImageURL:_tribe2.shopImages Size:_tribeImage2.frame.size]];
        _shopNameLabel2.text = _tribe2.shopName;

        _attentionNumLabel2.text =
            [NSString stringWithFormat:@"关注 %ld", (long)_tribe2.attentionNum];

        _contentNumLabel2.text =
            [NSString stringWithFormat:@"话题 %ld", (long)_tribe2.contentNum];

        if (_tribe2.isattention == 1) {
            _attentionButton2.backgroundColor = COLOR_GRAY_DEFAULT_185;
        }
        else {
            _attentionButton2.backgroundColor = [UIColor orangeColor];
        }

        /**
     *  3
     *
     */
        [_tribeImage3 setImageURL:[AppImageUtil getImageURL:_tribe3.shopImages Size:_tribeImage3.frame.size]];

        _shopNameLabel3.text = _tribe3.shopName;

        _attentionNumLabel3.text =
            [NSString stringWithFormat:@"关注 %ld", (long)_tribe3.attentionNum];

        _contentNumLabel3.text =
            [NSString stringWithFormat:@"话题 %ld", (long)_tribe3.contentNum];

        if (_tribe3.isattention == 1) {
            _attentionButton3.backgroundColor = COLOR_GRAY_DEFAULT_185;
        }
        else {
            _attentionButton3.backgroundColor = [UIColor orangeColor];
        }
    }
}

//热门帮（换一组)
- (void)onBtnChange:(UIButton*)sender
{

    [[IndexService shareInstance]
        changeOtherTribeFrontPageV2:[CurrentAccount currentAccount].uid
                          onSuccess:^(DataModel* dataModel) {

                              [self bindTribe:dataModel.data];

                          }];
}

//围观按钮
- (void)onBtnAttention:(UIButton*)sender
{

    switch (sender.tag) {
    case 200: {

        _surroundModel = _tribe;
        _button = _attentionButton;
    }

    break;

    case 201: {

        _surroundModel = _tribe2;
        _button = _attentionButton2;
    }

    break;
    case 202: {

        _surroundModel = _tribe3;
        _button = _attentionButton3;
    }

    break;

    default:
        break;
    }

#pragma mark
#pragma mark-- addUserAttentionTribe
    [[TribeService shareInstance]
        addUserAttentionTribe:[CurrentAccount currentAccount].uid
                      tribeId:_surroundModel.shopId
                    OnSuccess:^(DataModel* dataModel) {

                        if (dataModel.code == 20102) {
 
                            [ToastManager showToast:@"您已经围观过了" withTime:Toast_Hide_TIME];
                        }
                        else if (dataModel.code == 202) {
 
                            [ToastManager showToast:@"围观成功" withTime:Toast_Hide_TIME];
                            _button.backgroundColor = COLOR_GRAY_DEFAULT_185;
                        }

                    }];
}

@end
