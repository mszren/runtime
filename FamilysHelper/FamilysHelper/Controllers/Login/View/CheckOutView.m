//
//  CehckPhoneView.m
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CheckOutView.h"
#import "Masonry.h"

@implementation CheckOutView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (void)showCheckOutView:(NSString *)title andRemind:(NSString *)remind andDelegate:(id<CheckOutViewDelegate>)delegate{
    self.delegate = delegate;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 100;
    
    _backGroundView = [UIView new];
    [_viewController.view addSubview:_backGroundView];
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_viewController.view);
        make.width.mas_equalTo(@(Screen_Width - 40));
        make.height.mas_equalTo(@200);
        make.top.mas_equalTo(_viewController.view.mas_top).offset(84);
    }];
    _backGroundView.layer.cornerRadius = 8;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.layer.shouldRasterize = YES;
    _backGroundView.backgroundColor = BGViewColor;
    _backGroundView.tag = 101;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_backGroundView addGestureRecognizer:backTap];
    
    _titleLabel = [UILabel new];
    [_backGroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backGroundView);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(20);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@20);
    }];
    _titleLabel.text = title;
    _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
    _titleLabel.font = [UIFont boldSystemFontOfSize:19];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _contentLabel = [UILabel new];
    [_backGroundView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backGroundView);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(@(Screen_Width - 80));
        make.height.mas_equalTo(@50);
    }];
    _contentLabel.text = remind;
    _contentLabel.textColor = COLOR_GRAY_DEFAULT_133;
    _contentLabel.font = FONT_SIZE_17;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 2;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView);
        make.width.mas_equalTo(_backGroundView).multipliedBy(0.5);
        make.height.mas_equalTo(@50);
        make.bottom.mas_equalTo(_backGroundView.mas_bottom);
    }];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [_cancelBtn setTitleColor:COLOR_GRAY_DEFAULT_153 forState:UIControlStateNormal];
    _cancelBtn.tag = 200;
    _cancelBtn.backgroundColor = BGViewColor;
    [_cancelBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_cancelBtn.mas_right);
        make.width.height.bottom.mas_equalTo(_cancelBtn) ;
    }];
    [_certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    _certainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [_certainBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _certainBtn.tag = 201;
    _certainBtn.backgroundColor = BGViewColor;
    [_certainBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _verticalLabel = [UILabel new];
    [_cancelBtn addSubview:_verticalLabel];
    [_verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.bottom.mas_equalTo(_cancelBtn);
        make.width.mas_equalTo(@1);
    }];
    _verticalLabel.backgroundColor = COLOR_GRAY_DEFAULT_180;
    
    _grayLabel = [UILabel new];
    [_backGroundView addSubview:_grayLabel];
    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.bottom.mas_equalTo(_cancelBtn.mas_top);
        make.width.mas_equalTo(_backGroundView);
        make.height.mas_equalTo(@0.5);
    }];
    _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_180;
    
    
    // The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.window makeKeyAndVisible];
        
        _backGroundView.alpha = 0;
        _backGroundView.layer.shouldRasterize = YES;
        _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.alpha = 1;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            _backGroundView.layer.shouldRasterize = NO;
        }];
        
    });
}


#pragma mark -- UIButton
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
            
             [self clean];
            break;
            
        default:{
            
            [UIView animateWithDuration:0.2 animations:^{
                [self clean];
            } completion:^(BOOL finished) {
                
                [self.delegate certainJump];

            }];
            
        }
            break;
    }
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
            
        case 100:
            [self clean];
            break;
            
        default:{
            
           
        }
            break;
    }
}

-(void)clean{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            self.window.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            [self.window removeFromSuperview];
            [self.backGroundView removeFromSuperview];
            self.viewController = nil;
            self.window = nil;
            
        }];
        
    });
}
@end
