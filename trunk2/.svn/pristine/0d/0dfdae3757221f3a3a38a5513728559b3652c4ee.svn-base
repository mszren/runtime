//
//  hudongCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/5.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "hudongCell.h"
#import "CXPhotoBrowser.h"
#import "TopicModel.h"
@interface hudongCell () <EGOImageViewDelegate> {
    TopicModel* _msgModel;
}

@end
@implementation hudongCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindMsgModel:(TopicModel*)model
{

    _msgModel = model;

    
//    NSString* strTagName = [NSString stringWithFormat:@"#%@#", _msgModel.topic];
//    CGRect labelRect = [strTagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)attributes:[NSDictionary dictionaryWithObject:FONT_SIZE_12 forKey:NSFontAttributeName] context:nil];
//      _lbl_title.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelRect.size.width, self.frame.size.height);
    [_lbl_title setText:_msgModel.topic];
    
    [_lbl_hitNum setText:[NSString stringWithFormat:@"%ld", (long)_msgModel.hitNum]];
    [_lbl_replyNum setText:[NSString stringWithFormat:@"%ld", (long)_msgModel.replyNum]];
    [_lbl_createTime setText:[NSDate daySinceTimeInterval:_msgModel.createTime.doubleValue]];
    [_iv_Face setImageURL:[AppImageUtil getImageURL:_msgModel.face Size:_iv_Face.frame.size]];
}
- (void)initView
{
    _iv_Face.delegate = self;
    _iv_Face.tag = 0;
}

@end
