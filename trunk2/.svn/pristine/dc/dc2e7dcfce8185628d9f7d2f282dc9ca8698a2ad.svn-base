//
//  hotGoodCollectionViewCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/13.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "hotGoodCell.h"
#import <CoreText/CoreText.h>
#import "UIImageView+AFNetworking.h"
#import "GoodsDetailViewController.h"
#import "TribeModel.h"

@implementation hotGoodCell {
    EGOImageView* _imageUrl;
    UILabel* _goodName;
    UILabel* _goodsPrice;
    UILabel* _originalPrice;

    EGOImageView* _imageUrl2;
    UILabel* _goodName2;
    UILabel* _goodsPrice2;
    UILabel* _originalPrice2;
    GoodsModel* _goodModel1;
    GoodsModel* _goodModel2;
}
@synthesize messageListner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        UIView* backView =
            [[UIView alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_WIDTH - 30) / 2,
                                              (SCREEN_WIDTH - 30) * 1.5 / 2 + 60)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        _imageUrl = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 30) / 2,
            (SCREEN_WIDTH - 30) * 1.5 / 2);
        [backView addSubview:_imageUrl];
        _imageUrl.userInteractionEnabled = YES;
        _imageUrl.tag = 100;

        UITapGestureRecognizer* tap1 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(onTap:)];
        [_imageUrl addGestureRecognizer:tap1];

        _goodName = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _imageUrl.bounds.size.height + 10, (SCREEN_WIDTH - 30) / 2 - 10,
                              15)];
        _goodName.textColor = COLOR_GRAY_DEFAULT_30;
        _goodName.font = [UIFont systemFontOfSize:15];
        [backView addSubview:_goodName];

        _goodsPrice = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _goodName.frame.origin.y + _goodName.frame.size.height + 7, ((SCREEN_WIDTH - 30) / 2 - 10) / 2,
                              16)];
        _goodsPrice.textColor = COLOR_RED_DEFAULT_78;
        _goodsPrice.font = [UIFont systemFontOfSize:16];
        [backView addSubview:_goodsPrice];

        _originalPrice = [[UILabel alloc]
            initWithFrame:CGRectMake(15 + _goodsPrice.bounds.size.width,
                              _goodName.frame.origin.y + 28, ((SCREEN_WIDTH - 30) / 2 - 10) / 2, 15)];
        _originalPrice.textColor = COLOR_GRAY_DEFAULT_185;
        _originalPrice.font = [UIFont systemFontOfSize:12];
        [backView addSubview:_originalPrice];

        //
        UIView* backView2 = [[UIView alloc]
            initWithFrame:CGRectMake(20 + backView.bounds.size.width, 0,
                              (SCREEN_WIDTH - 30) / 2,
                              (SCREEN_WIDTH - 30) * 1.5 / 2 + 60)];
        backView2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView2];

        _imageUrl2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_60x60"]];
        _imageUrl2.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 30) / 2,
            (SCREEN_WIDTH - 30) * 1.5 / 2);
        [backView2 addSubview:_imageUrl2];
        _imageUrl2.tag = 200;
        _imageUrl2.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap2 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(onTap:)];
        [_imageUrl2 addGestureRecognizer:tap2];

        _goodName2 = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _imageUrl2.bounds.size.height + 10, 140,
                              15)];
        _goodName2.textColor = COLOR_GRAY_DEFAULT_30;
        _goodName2.font = [UIFont systemFontOfSize:15];
        [backView2 addSubview:_goodName2];

        _goodsPrice2 = [[UILabel alloc]
            initWithFrame:CGRectMake(10, _goodName2.frame.origin.y + _goodName2.frame.size.height + 7, ((SCREEN_WIDTH - 30) / 2 - 10) / 2,
                              16)];
        _goodsPrice2.textColor = COLOR_RED_DEFAULT_78;
        _goodsPrice2.font = [UIFont systemFontOfSize:16];
        [backView2 addSubview:_goodsPrice2];

        _originalPrice2 = [[UILabel alloc]
            initWithFrame:CGRectMake(15 + _goodsPrice2.bounds.size.width,
                              _goodName2.frame.origin.y + 28, ((SCREEN_WIDTH - 30) / 2 - 10) / 2, 15)];
        _originalPrice2.textColor = COLOR_GRAY_DEFAULT_185;
        _originalPrice2.font = [UIFont systemFontOfSize:12];
        [backView2 addSubview:_originalPrice2];
    }
    return self;
}

- (void)bindGoodsModel:(DataModel*)model AtIndexPath:(NSIndexPath*)indexPath
{
    _goodModel1 = model.data[(indexPath.row - 6) * 2];
    _goodModel2 = model.data[(indexPath.row - 6) * 2 + 1];

    [_imageUrl setImageURL:[AppImageUtil getImageURL:_goodModel1.imageUrl Size:_imageUrl.frame.size]];

    _goodName.text = _goodModel1.goodsName;
    NSString* price =
        [NSString stringWithFormat:@"%ld", (long)_goodModel1.goodsPrice];
    float goodPrice = price.floatValue;
    _goodsPrice.text = [NSString stringWithFormat:@"¥%.2f", goodPrice];

    NSString* originalPrice =
        [NSString stringWithFormat:@"%ld", (long)_goodModel1.originalPrice];
    float original = originalPrice.floatValue;
    _originalPrice.text = [NSString stringWithFormat:@"¥%.2f", original];

    /**
   *
   */

    [_imageUrl2 setImageURL:[AppImageUtil getImageURL:_goodModel2.imageUrl Size:_imageUrl2.frame.size]];
    _goodName2.text = _goodModel2.goodsName;
    NSString* price2 =
        [NSString stringWithFormat:@"%ld", (long)_goodModel2.goodsPrice];
    float goodPrice2 = price2.floatValue;
    _goodsPrice2.text = [NSString stringWithFormat:@"¥%.2f", goodPrice2];

    NSString* originalPrice2 =
        [NSString stringWithFormat:@"%ld", (long)_goodModel2.originalPrice];
    float original2 = originalPrice2.floatValue;
    _originalPrice2.text = [NSString stringWithFormat:@"¥%.2f", original2];
}

#pragma mark
#pragma mark--UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer*)sender
{
    GoodsModel* temp;
    if (sender.view.tag == 100) {
        temp = _goodModel1;
    }
    else {
        temp = _goodModel2;
    }
    NSDictionary* dic = @{ ACTION_Controller_Name : messageListner, ACTION_Controller_Data : temp };
    [messageListner RouteMessage:ACTION_SHOW_BANGBANG_GOODSDETAIL
                     withContext:dic];
}

@end
