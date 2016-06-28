//
//  ApplyView.m
//  FamilysHelper
//
//  Created by 我 on 15/8/21.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ApplyView.h"
#import "HomeService.h"

@implementation ApplyView{

    UIButton *_cancelButton;
    UIButton *_certainButton;
    UIView *_backGroundView;
    UITextView *_textView;
    UILabel *_covertLabel;
    NSMutableString *_leaveWords;
    UIImage *_imageUrl;
    ASIHTTPRequest * _request;
    NSInteger _height;
}

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForKeyboardNotifications];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backGroundView];
        
        //输入框
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 80)];
        _textView.delegate = self;
        _textView.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textAlignment = NSTextAlignmentLeft;
        [_backGroundView addSubview:_textView];
        
        _covertLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH, 20)];
        _covertLabel.font = [UIFont systemFontOfSize:15];
        _covertLabel.text = @"请输入申请理由";
        _covertLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
        [_textView addSubview:_covertLabel];
        
        
        //灰线
        UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 1)];
        grayLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [_backGroundView addSubview:grayLabel];
        
        _certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _certainButton.frame = CGRectMake(10, 90, SCREEN_WIDTH - 20, 40);
        _certainButton.backgroundColor = COLOR_GRAY_DEFAULT_107;
        [_certainButton setTitle:@"确定" forState:UIControlStateNormal];
        _certainButton.layer.cornerRadius = 8;
        _certainButton.clipsToBounds = YES;
        _certainButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_certainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_certainButton addTarget:self action:@selector(onBtnCertain:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:_certainButton];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(10, 140, SCREEN_WIDTH - 20, 40);
        _cancelButton.backgroundColor = COLOR_RED_DEFAULT_8d;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelButton.layer.cornerRadius = 8;
        _cancelButton.clipsToBounds = YES;
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:_cancelButton];
        
    }
    return self;
    
}

#pragma mark
#pragma mark -- UIButtonAction

-(void)onBtnCertain:(UIButton *)sender{
    
    if ([_textView.text isEqualToString:@""]) {
        
        [ToastManager showToast:@"请输入申请理由" withTime:Toast_Hide_TIME];
        return;
    }
    if (_request) {
        
        [_request cancel];
    }
    
    _request = [[HomeService shareInstance] AskForRoom:_roomID reason:_textView.text userId:_userID onSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            
            [ToastManager showToast:@"申请加入成功" withTime:Toast_Hide_TIME];
        }else
            
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self removeFromSuperview];
}

-(void)onBtnCancel:(UIButton *)sender{
    
    [_textView resignFirstResponder];
    
    self.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark
#pragma mark -- UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    _textView.text = textView.text;
    if (_textView.text.length == 0) {
        _covertLabel.text = @"请输入申请理由";
        
    }else{
        _covertLabel.text = @"";
    }
    [_leaveWords stringByAppendingString:_textView.text];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    _textView = textView;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        
        [_textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark
#pragma mark -- NSNotificationCenter

-(void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notify{
    
    //获取键盘的高度
    NSDictionary* userInfo = [notify userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _height = keyboardRect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        
        _backGroundView.frame = CGRectMake(0,  SCREEN_HEIGHT - 200 - _height/2, SCREEN_WIDTH, 200);
    }];
}

-(void)keyboardWillHidden:(NSNotification *)notify{
    
    [UIView animateWithDuration:0.25 animations:^{
        _backGroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200);
    }];
}

@end
