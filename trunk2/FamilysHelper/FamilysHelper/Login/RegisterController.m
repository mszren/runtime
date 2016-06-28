//
//  RegisterController.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/5.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//


#import "RegisterController.h"
#import "XMPPManager.h"

@interface RegisterController()<UITextFieldDelegate>

@end

static XMPPManager * xmppManager = nil;
@implementation RegisterController

- (id)init
{
    self = [super init];
    if (self) {
        xmppManager = [XMPPManager shareInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VIEW_BG;
    
    self.title = @"注册";
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, 200, 50)];
    _phoneTF.backgroundColor = [UIColor whiteColor];
    _phoneTF.delegate = self;
    _phoneTF.placeholder = @"手机号";
    [self.view addSubview:_phoneTF];
    
    _verificationCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 140, 200, 50)];
    _verificationCodeTF.backgroundColor = [UIColor whiteColor];
    _verificationCodeTF.delegate = self;
    _verificationCodeTF.placeholder = @"验证码";
    [self.view addSubview:_verificationCodeTF];
    
    _pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, 200, 50)];
    _pwdTF.backgroundColor = [UIColor whiteColor];
    _pwdTF.delegate = self;
    _pwdTF.placeholder = @"密码";
    _pwdTF.secureTextEntry = YES;
    [self.view addSubview:_pwdTF];
    
    
    _getVerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerificationCodeBtn.frame = CGRectMake(30, 260, 150, 50);
    [_getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerificationCodeBtn addTarget:self action:@selector(getVerificationCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_getVerificationCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_getVerificationCodeBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(230, 260, 60, 50);
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_registerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_registerBtn];
    
    _showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _showPwdBtn.frame = CGRectMake(30, 310, 160, 50);
    [_showPwdBtn setTitle:@"showPwd" forState:UIControlStateNormal];
    [_showPwdBtn addTarget:self action:@selector(showPwdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_showPwdBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_showPwdBtn];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction:)];
    [self.view addGestureRecognizer:_tap];
}

- (void) TapAction:(id) sender
{
    [_phoneTF resignFirstResponder];
    [_verificationCodeTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

- (void) getVerificationCodeBtnAction :(id) sender
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getVerificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _getVerificationCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_getVerificationCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                _getVerificationCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    

}

- (void) registerBtnAction: (id) sender
{
    
}

- (void) showPwdBtnAction: (id) sender
{
    _pwdTF.secureTextEntry = !_pwdTF.secureTextEntry;
}

@end