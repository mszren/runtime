//
//  InteractionCell.m
//  FamilysHelper
//
//  Created by Owen on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeGoodsCell.h"
#import <CoreText/CoreText.h>
#import "TribeService.h"
#import "UIView+Toast.h"
@interface TribeGoodsCell () {

    UILabel* _lblTitle;
    UILabel* _lblContent;
    EGOImageView* _ivIconUrl;

    UILabel* _lblOriginalPrice;
    UILabel* _lblGoodsPrice;
    UIView* _contentView;
    GoodsModel* _goodsModel;

    UILabel* _priceGrayLabel;
    UILabel* _oldGrayLabel;
}

@end

@implementation TribeGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundView.backgroundColor = [UIColor whiteColor];
        UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(SCREEN_WIDTH - 65, 30, 50, 25);
        [saveButton setTitle:@"收藏" forState:UIControlStateNormal];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:13];
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

        _ivIconUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _ivIconUrl.frame = CGRectMake(10, 10, 70, 70);
        [self addSubview:_ivIconUrl];

        _lblTitle = [[UILabel alloc] init];
        _lblTitle.frame = CGRectMake(_ivIconUrl.frame.size.width + 20, 10, SCREEN_WIDTH - _ivIconUrl.frame.size.width - 20, 20);
        [_lblTitle setFont:TableCellTitleFont];
        [_lblTitle setTextColor:TableCellTitleColor];
        [self addSubview:_lblTitle];

        _lblContent = [[UILabel alloc] init];
        _lblContent.frame = CGRectMake(_lblTitle.frame.origin.x, _lblTitle.frame.origin.y + _lblTitle.frame.size.height, SCREEN_WIDTH - _ivIconUrl.frame.size.width - 20, 20);
        [_lblContent setFont:TableCellDescFont];
        [_lblContent setTextColor:TableCellDescColor];
        [self addSubview:_lblContent];

        _lblOriginalPrice = [[UILabel alloc] init];
        _lblOriginalPrice.frame = CGRectMake(_lblTitle.frame.origin.x, _lblContent.frame.origin.y + _lblContent.frame.size.height, 50, 20);
        [_lblOriginalPrice setFont:TableCellDescFont];
        [_lblOriginalPrice setTextColor:TableCellDescColor];
        [self addSubview:_lblOriginalPrice];

        _oldGrayLabel = [[UILabel alloc] init];
        _oldGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT;
        [self addSubview:_oldGrayLabel];

        _lblGoodsPrice = [[UILabel alloc] init];
        _lblGoodsPrice.frame = CGRectMake(_lblOriginalPrice.frame.origin.x + _lblOriginalPrice.frame.size.width, _lblOriginalPrice.frame.origin.y, 50, 20);
        [_lblGoodsPrice setFont:TableCellDescFont];
        [_lblGoodsPrice setTextColor:COLOR_RED_DEFAULT_78];
        [self addSubview:_lblGoodsPrice];

        _priceGrayLabel = [[UILabel alloc] init];
        _priceGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT;
        [self addSubview:_priceGrayLabel];

        UILabel* grayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 89, SCREEN_WIDTH - 20, 1)];
        grayLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [self addSubview:grayLabel];
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

- (void)bindGoodsModel:(GoodsModel*)model
{

    _goodsModel = model;
    [_lblTitle setText:_goodsModel.goodsName];

    if (![_goodsModel.imageName isEqualToString:@""]) {
        [_ivIconUrl setImageURL:[AppImageUtil getImageURL:_goodsModel.imageName Size:_ivIconUrl.frame.size]];
    }

    [_lblContent setText:_goodsModel.goodsTitle];
    [_lblGoodsPrice setText:[NSString stringWithFormat:@"¥%ld", (long)_goodsModel.goodsPrice]];
    [_lblOriginalPrice setText:[NSString stringWithFormat:@"¥%ld", (long)_goodsModel.originalPrice]];

    _oldGrayLabel.frame = CGRectMake(_lblOriginalPrice.frame.origin.x, _lblOriginalPrice.frame.origin.y + 10, _lblOriginalPrice.text.length * 8, 1);

    //    _priceGrayLabel.frame = CGRectMake(_lblGoodsPrice.frame.origin.x, _lblGoodsPrice.frame.origin.y + 5, _lblGoodsPrice.text.length * 10, 1);
}

HEXColor_Method

#pragma mark
#pragma mark--UIButtonAction
    - (void)onBtnSave : (UIButton*)sender
{

    [[TribeService shareInstance] addMyCollect:[CurrentAccount currentAccount].uid
                                          type:3
                                      objectId:_goodsModel.goodsId
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
