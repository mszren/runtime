//
//  InviteCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "InviteCell.h"

@implementation InviteCell
 

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH - 100, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        _descripeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 140, 40)];
        _descripeLabel.textColor = COLOR_GRAY_DEFAULT_30;
        _descripeLabel.font = [UIFont systemFontOfSize:13];
        _descripeLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_descripeLabel];
        
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        detailButton.frame = CGRectMake(SCREEN_WIDTH - 120, 20.5, 7, 11);
        [detailButton setImage:[UIImage imageNamed:@"ic_arrow"] forState:UIControlStateNormal];
        _descripeLabel.numberOfLines = 0;
        [backView addSubview:detailButton];
        
    }
    return self;
}

@end
