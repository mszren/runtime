//
//  Cell2.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "GoodsCell.h"
#import "UIImageView+AFNetworking.h"

@implementation GoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) bindGoodModel:(GoodsModel*)model{
//    [_lbl_NickName setText:model.nickname];
//    [_lbl_Content setText:model.content];
    // [_lbl_createTime setText:model.createTime];
    
    _newprice.text=[NSString stringWithFormat:@"¥%ld.00",(long)model.goodsPrice];
    _oldPrice.text=[NSString stringWithFormat:@"¥%ld.00",(long)model.originalPrice];
    [_goodImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"presonHeadDefault"]];
    _goodtitle.text=model.goodsTitle;
    _goodtitle.textColor=COLOR_GRAY_DEFAULT_OPAQUE_1f;
    _gooddesprise.text=model.goodsName;
    _gooddesprise.textColor=COLOR_GRAY_DEFAULT_OPAQUE_7a;
}


@end
