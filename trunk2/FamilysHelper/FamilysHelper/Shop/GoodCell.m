//
//  GoodCell.m
//  FamilysHelper
//
//  Created by 我 on 15/7/1.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GoodCell.h"
#import "UIImageView+AFNetworking.h"

@implementation GoodCell {
    EGOImageView* _goodsImage;
    UILabel* _nowPrice;
    UILabel* _olderPrice;
    UILabel* _nowgoodsTitle;
    UILabel* _descripeLabel;

    UIView* _backView;

    UILabel* _grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 89)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];

        _goodsImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_90x70"]];
        _goodsImage.frame = CGRectMake(10, 10, 90, 70);

        [_backView addSubview:_goodsImage];

        _nowgoodsTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, 13, 200, 15)];
        _nowgoodsTitle.font = [UIFont systemFontOfSize:15];
        _nowgoodsTitle.tintColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
        [_backView addSubview:_nowgoodsTitle];

        _descripeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 38, SCREEN_WIDTH - 110, 15)];
        _descripeLabel.tintColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
        _descripeLabel.font = [UIFont systemFontOfSize:15];
        [_backView addSubview:_descripeLabel];

        _nowPrice = [[UILabel alloc] init];
        _olderPrice = [[UILabel alloc] init];

        _grayLabel = [[UILabel alloc] init];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT;
        [_backView addSubview:_grayLabel];
    }
    return self;
}

- (void)bindGoodModel:(GoodsModel*)model
{

    NSString* goodPrice = [NSString stringWithFormat:@"%ld", (long)model.goodsPrice];
    _nowPrice.frame = CGRectMake(110, 63, (goodPrice.length + 3) * 10, 15);
    _nowPrice.text = [NSString stringWithFormat:@"¥%ld.00", (long)model.goodsPrice];
    _nowPrice.textColor = RedColor1;
    _nowPrice.font = [UIFont systemFontOfSize:15];
    [_backView addSubview:_nowPrice];

    NSString* olderPrice = [NSString stringWithFormat:@"%ld", (long)model.originalPrice];
    _olderPrice.frame = CGRectMake(120 + _nowPrice.bounds.size.width, 63, (olderPrice.length + 3) * 10, 15);

    _olderPrice.text = [NSString stringWithFormat:@"¥%ld.00", (long)model.originalPrice];
    _olderPrice.textColor = COLOR_GRAY_DEFAULT_185;
    _olderPrice.font = [UIFont systemFontOfSize:15];
    [_backView addSubview:_olderPrice];

    _nowgoodsTitle.text = model.goodsTitle;
    _descripeLabel.text = model.goodsName;

    [_goodsImage setImageURL:[AppImageUtil getImageURL:model.imageUrl Size:_goodsImage.frame.size]];
    _grayLabel.frame = CGRectMake(119 + _nowPrice.bounds.size.width, 71, (olderPrice.length + 3) * 10, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
