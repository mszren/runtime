//
//  PersonCenterCell.m
//  FamilysHelper
//
//  Created by Owen on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "PersonCenterCell.h"
@interface  PersonCenterCell()
{

    UIImageView *_ivIcon;
    UILabel *_lblTitle;
}


@end

@implementation PersonCenterCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer setBorderWidth:0.5];
        [self.layer setBorderColor:BGViewGray.CGColor];
    
        _ivIcon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_balance"]];
        _ivIcon.center=CGPointMake(self.contentView.center.x, self.contentView.center.y-15);
        [self.contentView addSubview:_ivIcon];
        _lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [_lblTitle setText:@"我的余额"];
        [_lblTitle setFont:[UIFont systemFontOfSize:12.0]];
        [_lblTitle setTextAlignment:NSTextAlignmentCenter];
        _lblTitle.center=CGPointMake(self.contentView.center.x, self.contentView.center.y+18);
        [self.contentView addSubview:_lblTitle];
    }
    return self;
}

-(void) bindData:(CellModel*) model{
    [_ivIcon setImage:[UIImage imageNamed:model.iconName]];
    [_lblTitle setText:model.titleName];
}
@end
