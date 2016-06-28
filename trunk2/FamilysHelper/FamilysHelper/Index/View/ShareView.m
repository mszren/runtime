//
//  ShareView.m
//  FamilysHelper
//
//  Created by 我 on 15/7/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView{
   
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UIView *backGrandView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 140)];
        backGrandView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGrandView];
        
        _wechatTimeline = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_pyj"]];
        _wechatTimeline.frame = CGRectMake(20, 10, 40, 40);
        _wechatTimeline.userInteractionEnabled = YES;
        [backGrandView addSubview:_wechatTimeline];
        
        _wechatSession = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_weixin"]];
        _wechatSession.frame = CGRectMake(100, 10, 40, 40);
        _wechatSession.userInteractionEnabled = YES;
        [backGrandView addSubview:_wechatSession];
        
        
        NSArray *name = @[@"微信朋友圈",@"微信好友"];
        for (NSInteger i = 0; i < name.count; i++) {
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*80, 60, 80, 15)];
            nameLabel.text = name[i];
            nameLabel.font = [UIFont systemFontOfSize:11];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [backGrandView addSubview:nameLabel];
        }
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(10, 95, SCREEN_WIDTH - 20, 35);
        _cancelButton.layer.cornerRadius = 4;
        _cancelButton.clipsToBounds = YES;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor orangeColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [backGrandView addSubview:_cancelButton];
    }
    return self;
}

 

@end
