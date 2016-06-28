//
//  CommentCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/18.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "CommentCell.h"
#import "MsgCommentModel.h"

@interface CommentCell () <EGOImageViewDelegate> {
    MsgCommentModel* _commentModel;
}

@end
@implementation CommentCell

- (void)awakeFromNib
{
    // Initialization code
}
// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);

    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2 / 255.0f green:0xE2 / 255.0f blue:0xE2 / 255.0f alpha:0.75].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bindMsgModel:(MsgCommentModel*)model
{
    _commentModel = model;

    [_lbl_NickName setText:_commentModel.nickName];
    [_lbl_Content setText:_commentModel.content];
    [_lbl_createTime setText:[NSDate dateYMDTimeInterval:_commentModel.commentTime.doubleValue]];
    [_iv_Face setImageURL:[AppImageUtil getImageURL:_commentModel.face Size:_iv_Face.frame.size]];
}

- (void)initView
{
    _iv_Face.delegate = self;
    _iv_Face.layer.cornerRadius = _iv_Face.bounds.size.width / 2;
    _iv_Face.clipsToBounds = YES;
    _iv_Face.tag = 0;
}
@end
