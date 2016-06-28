//
//  SelectTopicView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/7/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SelectTopicView.h"

@implementation SelectTopicView{
    UIView *_backGroundView;
    UILabel *lb_line;
    UILabel *lb_title;
    
    UILabel *_old_Label;
}
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backGroundView];
        
        UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
        typeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        typeView.userInteractionEnabled = YES;
        [self addSubview:typeView];
        
        UITapGestureRecognizer *tapTypeView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapTypeView:)];
        [typeView addGestureRecognizer:tapTypeView];
        
        lb_line = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 5, 15)];
        lb_line.backgroundColor=[ UIColor grayColor];
        [_backGroundView addSubview:lb_line];
        
        lb_title = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 50, 20)];
        lb_title.font=[UIFont systemFontOfSize:15];
        lb_title.text=@"筛选";
        [_backGroundView addSubview:lb_title];
        
        _lb_all = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 50, 40)];
        _lb_all.font=[UIFont systemFontOfSize:14];
        _lb_all.tag = 100;
         _lb_all.userInteractionEnabled=YES;
        _lb_all.text=@"全部";
         _lb_all.textColor=[UIColor grayColor];
        UITapGestureRecognizer*lb_allGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac_settype0:)];
        [_lb_all addGestureRecognizer:lb_allGesture];
        [_backGroundView addSubview:_lb_all];
        
        _lb_new = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 50, 40)];
        _lb_new.font=[UIFont systemFontOfSize:14];
        _lb_new.tag = 101;
        _lb_new.userInteractionEnabled=YES;
        _lb_new.text=@"最新";
        _lb_new.textColor=[UIColor grayColor];
        UITapGestureRecognizer* lb_newGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac_settype1:)];
        [_lb_new addGestureRecognizer:lb_newGesture];
        [_backGroundView addSubview:_lb_new];
        
        _lb_lz = [[UILabel alloc]initWithFrame:CGRectMake(170, 50, 100, 40)];
        _lb_lz.font=[UIFont systemFontOfSize:14];
        _lb_lz.tag = 102;
        _lb_lz.userInteractionEnabled=YES;
        _lb_lz.text=@"只看楼主";
        _lb_lz.textColor=[UIColor grayColor];
        UITapGestureRecognizer* lb_lzGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ac_settype2:)];
        [_lb_lz addGestureRecognizer:lb_lzGesture];
        [_backGroundView addSubview:_lb_lz];
        
        
        _old_Label = (UILabel *)[self viewWithTag:100];
        _old_Label.textColor = HomeNavBarBgColor;
 
    }
    return self;
    
}

-(void)onTapTypeView:(UITapGestureRecognizer *)sender{
    [self removeFromSuperview];
}

-(void)ac_settype0:(id)sender{
    _type=0;
    if (_blockComment) {
        _blockComment(_type);
    };
     _lb_all.textColor=HomeNavBarBgColor;
    if (_lb_all != _old_Label) {
        
        _old_Label.textColor = [UIColor grayColor];
    }else
        _old_Label.textColor = HomeNavBarBgColor;
    
    _old_Label = _lb_all;
    [self removeFromSuperview];
    self.tag=0;
}

-(void)ac_settype1:(id)sender{
     _type=1;
    if (_blockComment) {
        _blockComment(_type);
    };
    _lb_new.textColor = HomeNavBarBgColor;
    if (_lb_new != _old_Label) {
        
        _old_Label.textColor = [UIColor grayColor];
    }else
        _old_Label.textColor = HomeNavBarBgColor;
    
    _old_Label = _lb_new;
    [self removeFromSuperview];
    self.tag=0;
}

-(void)ac_settype2:(id)sender{
     _type=2;
    if (_blockComment) {
        _blockComment(_type);
    };
     _lb_lz.textColor=HomeNavBarBgColor;
    if (_lb_lz != _old_Label) {
        
        _old_Label.textColor = [UIColor grayColor];
    }else
        _old_Label.textColor = HomeNavBarBgColor;
    
    _old_Label = _lb_lz;
    [self removeFromSuperview];
    self.tag=0;
}
@end
