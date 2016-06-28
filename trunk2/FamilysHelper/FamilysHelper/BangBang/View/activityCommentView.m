//
//  activityCommentView.m
//  FamilysHelper
//
//  Created by 我 on 15/7/4.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "activityCommentView.h"
#import "UIView+Toast.h"
#import "TribeService.h"
#import "ActivityModel.h"


@implementation activityCommentView{
 
UIButton *_cancelButton;
UIButton *_certainButton;
UIView *_backGroundView;
UITextView *_textView;
UILabel *_covertLabel;
NSMutableString *_leaveWords;
UIImage *_imageUrl;
    ASIHTTPRequest * _commentRequest;
    ASIHTTPRequest * _infoRequrst;
 
}
@synthesize messageListner;

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForKeyboardNotifications];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 190, SCREEN_WIDTH, 275)];
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
        _covertLabel.textColor = COLOR_DARKGRAY_DEFAULT;
        _covertLabel.font = [UIFont systemFontOfSize:15];
        _covertLabel.text = @"请输入内容";
        _covertLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
        [_textView addSubview:_covertLabel];
        

        //灰线
        UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 1)];
        grayLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [_backGroundView addSubview:grayLabel];
        
 
        
        _certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _certainButton.frame = CGRectMake(10, 90, SCREEN_WIDTH - 20, 40);
        _certainButton.backgroundColor = COLOR_GRAY_DEFAULT_107;
        [_certainButton setTitle:@"提交" forState:UIControlStateNormal];
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
        
        [self makeToast:@"请输入内容" duration:1.5 position:nil];
        return;
        
    }else{
        
        if (_type == 0) {
            if (_commentRequest) {
                [_commentRequest cancel];
            }
            
            _commentRequest = [[TribeService shareInstance] commentActivityReply:[CurrentAccount currentAccount].uid replyId:_objectId content:_textView.text OnSuccess:^(DataModel *dataModel) {
                if (dataModel.code == 202) {
                    [ToastManager showToast:@"评论成功" withTime:Toast_Hide_TIME];
                    
 
                }else{
                    
                    [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
 
                }
                
            }];
            
        }else if (_type == 1){
            
            if (_infoRequrst) {
                [_infoRequrst cancel];
            }
            _infoRequrst = [[TribeService shareInstance]addInformAgainst:[CurrentAccount currentAccount].uid objectId:_objectId content:_textView.text objectType:_objectType triberId:_triberId OnSuccess:^(DataModel *dataModel) {
                if (dataModel.code == 202) {
                    
                     [ToastManager showToast:@"举报成功" withTime:Toast_Hide_TIME];
 
                  
                }else{
                    
                    [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                  
                }
                
            }];
            
        }
    }
    [self MessageRoutable];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self removeFromSuperview];
}

-(void)MessageRoutable{
    ActivityModel *activityModel = [[ActivityModel alloc]init];
    activityModel.commentNickName = [CurrentAccount currentAccount].nickname;
    activityModel.commentContent = _textView.text;
    activityModel.row = _selectRow;
    [messageListner RouteMessage:NOTIFICATION_BANGBANG_ACTIVITYCOMMENT withContext:@{ NOTIFICATION_DATA : activityModel}];
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
        _covertLabel.text = @"请输入内容";
        
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
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(0,  - 160, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

-(void)keyboardWillHidden:(NSNotification *)notify{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
    
}
@end
