//
//  ShopHeaderView.m
//  FamilysHelper
//
//  Created by Owen on 15/7/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShopHeaderView.h"

@interface ShopHeaderView () {
    EGOImageView* _shopLogo;
    UILabel* _shopName;
    UILabel* _distanceLabel;
    UIView* _startView;
    TribeModel* _tribe;
}

@end

@implementation ShopHeaderView
@synthesize messageListner;

- (instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 65);

        UITapGestureRecognizer* _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tap];

        _shopLogo = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"]];
        _shopLogo.frame = CGRectMake(10, 18, 39, 39);
        _shopLogo.layer.cornerRadius = 39 / 2;
        _shopLogo.clipsToBounds = YES;
        [self addSubview:_shopLogo];

        _shopName = [[UILabel alloc] initWithFrame:CGRectMake(59, 23, SCREEN_WIDTH - 96, 17)];
        _shopName.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
        _shopName.font = [UIFont systemFontOfSize:17];
        [self addSubview:_shopName];

        UIImageView* distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 50, 9, 13)];
        distanceImage.image = [UIImage imageNamed:@"ic_distance@2x"];
        [self addSubview:distanceImage];

        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 50, 70, _shopLogo.frame.size.height / 3)];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_b9;
        [self addSubview:_distanceLabel];

        //跳转图片
        UIImageView* jumpImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20, 35, 7, 11)];
        jumpImage.image = [UIImage imageNamed:@"ic_arrow@2x"];
        [self addSubview:jumpImage];

        _startView = [[UIView alloc] initWithFrame:CGRectMake(150, 50, 14, 14)];
        [self addSubview:_startView];
    }

    return self;
}

- (void)bindTribeModel:(TribeModel*)model
{
    _tribe = model;
    [_shopLogo setImageURL:[AppImageUtil getImageURL:model.shopImages Size:_shopLogo.frame.size]];
    _shopName.text = model.shopName;
    _distanceLabel.text = [NSString stringWithFormat:@"%.2fKm", (float)model.distance / 1000.0];

    //星星图片
    float starCount = [model.star floatValue];
    NSInteger fullStarcount = (NSInteger)starCount;
    NSInteger halfStarcount = 0;

    if (starCount > fullStarcount)
        halfStarcount = 1;

    NSArray* viewsToRemove = [_startView subviews];
    for (UIView* v in viewsToRemove) {
        [v removeFromSuperview];
    }
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView* starImage = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 14, 14)];
        if (i < fullStarcount && fullStarcount != 0) {
            starImage.image = [UIImage imageNamed:@"ic_star_full"];
        }
        else if (i == fullStarcount && halfStarcount != 0) {
            starImage.image = [UIImage imageNamed:@"ic_star_half"];
        }
        else {
            starImage.image = [UIImage imageNamed:@"ic_star_enpty"];
        }
        [_startView addSubview:starImage];
    }
}

- (void)tapAction:(id)sender
{
    NSDictionary* dic = [NSDictionary
        dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name,
                         @{BANGBANG_INDEX_TRIBEID:@(_tribe.shopId),BANGBANG_INDEX_SELECTINDEX:@(SELECTSHOP)},
        ACTION_Controller_Data, nil];
    [messageListner RouteMessage:ACTION_SHOW_BANGBANG_BANGINDEX withContext:dic];
}

@end
