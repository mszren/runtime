//
//  BuyView.m
//  FamilysHelper
//
//  Created by 我 on 15/7/5.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BuyView.h"

@implementation BuyView {

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
        [self addSubview:grayLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 15)];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.textColor = [UIColor orangeColor];
        [self addSubview:_priceLabel];

        _banBiLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 140, 15)];
 
        _banBiLabel.font = [UIFont systemFontOfSize:12];
        _banBiLabel.textColor = COLOR_GRAY_DEFAULT_185;
        [self addSubview:_banBiLabel];

        _byButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_byButton setTitle:@"购买" forState:UIControlStateNormal];
        _byButton.frame = CGRectMake(SCREEN_WIDTH - 70, 10, 60, 25);
        _byButton.backgroundColor = [UIColor orangeColor];
        _byButton.layer.cornerRadius = 4;
        _byButton.clipsToBounds = YES;
        _byButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_byButton];
    }
    return self;
}

@end
