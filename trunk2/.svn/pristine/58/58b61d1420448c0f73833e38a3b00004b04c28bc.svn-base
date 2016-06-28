//
//  MyFollowCell.m
//  FamilysHelper
//
//  Created by Owen on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyFollowCell.h"
#import <CoreText/CoreText.h>

@interface MyFollowCell () {
    EGOImageView* _ivLogo;
    UILabel* _lblTitle;
    UILabel* _lblContent;
    UILabel* _lblNews;
}

@end

@implementation MyFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _ivLogo = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_default_40x40"]];
        _ivLogo.frame = CGRectMake(10, 10, 40, 40);
        _ivLogo.layer.cornerRadius = 3.0;
        _ivLogo.clipsToBounds = YES;
        [self addSubview:_ivLogo];

        _lblTitle = [[UILabel alloc] init];
        [_lblTitle setFont:TableCellTitleFont];
        [_lblTitle setTextColor:TableCellTitleColor];
        _lblTitle.frame = CGRectMake(10 + _ivLogo.frame.size.width + 8, 10, SCREEN_WIDTH - _ivLogo.frame.size.width - 36 - 70, 20);

        [self addSubview:_lblTitle];

        _lblContent = [[UILabel alloc] init];
        [_lblContent setFont:TableCellDescFont];
        [_lblContent setTextColor:TableCellDescColor];
        _lblContent.frame = CGRectMake(_lblTitle.frame.origin.x, _lblTitle.frame.origin.y + _lblTitle.frame.size.height, SCREEN_WIDTH - _ivLogo.frame.size.width - 20, 20);
        [self addSubview:_lblContent];

        _lblNews = [[UILabel alloc] init];
        [_lblNews setTextAlignment:NSTextAlignmentRight];
        [_lblNews setFont:TableCellTimeFont];
        [_lblNews setTextColor:TableCellNewsColor];
        _lblNews.frame = CGRectMake(SCREEN_WIDTH - 70, 13, 60, 14);
        [self addSubview:_lblNews];
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

- (void)bindTribel:(TribeIndexModel*)model
{
    if (![model.shopImage isEqualToString:@""]) {
        [_ivLogo setImageURL:[AppImageUtil getImageURL:model.shopImage Size:_ivLogo.frame.size]];
    }

    [_lblTitle setText:model.shopName];
    [_lblContent setText:model.content];
    [_lblNews setText:[NSString stringWithFormat:@"今日%ld条", (long)model.totalCount]];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, TableSeparatorColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 20, 1));
}
@end
