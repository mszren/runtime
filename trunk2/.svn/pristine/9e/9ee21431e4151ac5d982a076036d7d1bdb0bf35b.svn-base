//
//  RedPacketViewCell.m
//  Common
//
//  Created by 曹亮 on 15/4/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RedPacketViewCell.h"

@implementation RedPacketViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = FONT_SIZE_16;
        _titleLab.text = @"家家帮红包";
        [self addSubview:_titleLab];
        
        _leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OK@2x.png"]];
        _leftImg.userInteractionEnabled = YES;
        _leftImg.frame = CGRectMake(0, 30, 50, 50);
        [self addSubview:_leftImg];
        
        _descLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 120, 100)];
        _descLab.backgroundColor = [UIColor clearColor];
        _descLab.textColor = [UIColor blackColor];
        _descLab.numberOfLines = 0;
        _descLab.font = FONT_SIZE_16;
        _descLab.text = @"家家帮红包";
        [self addSubview:_descLab];
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tap];
    }
    return self;
}


- (void) setRedPacketViewCellData:(NSString *) aStr
{
    _descLab.text = [NSString stringWithFormat:@"我在群里发了一个红包,大家快来抢吧！祝:%@",aStr];
}

- (void) tapAction:(id) sender{
    if ([self.delegate respondsToSelector:@selector(tapRedPacket)]) {
        [self.delegate tapRedPacket];
    }
}

@end