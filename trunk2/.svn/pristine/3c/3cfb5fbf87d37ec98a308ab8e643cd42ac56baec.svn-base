//
//  QDCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "QDCell.h"
#import "QDModel.h"
@implementation QDCell

- (void)awakeFromNib {
    // Initialization code
}
// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:0.75].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) bindUserModel:(QDModel*)model{
    [_lbl_qiandaoTime setText:model.signMessage];
    [_lbl_qiandaoMomeny setText:[NSString stringWithFormat:@"%ld",(long)model.signPrice]];
}


@end
