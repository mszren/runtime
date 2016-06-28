//
//  RegisterController.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/5.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//


#import "PhoneRegisterController.h"
#import "XMPPManager.h"
#import "MessageRegisterController.h"
 

@interface PhoneRegisterController()<UITextFieldDelegate>

@end

static XMPPManager * xmppManager = nil;
@implementation PhoneRegisterController{
    UITextField * _phoneTF;

}

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
    [self customUI];
    
}

-(void)customUI{
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnCustomer:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"账号注册";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = COLOR_RED_DEFAULT_904;
    self.navigationItem.titleView = titleLabel;
 
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH , 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = COLOR_GRAY_DEFAULT_30;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:phoneLabel];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(75, 0 , SCREEN_WIDTH - 75, 50)];
    _phoneTF.delegate = self;
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNamePhonePad;
    _phoneTF.font = [UIFont systemFontOfSize:13];
    _phoneTF.textColor = COLOR_GRAY_DEFAULT_30;
    [backView addSubview:_phoneTF];
    
 
    
    
}

 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

-(void)onBtnCustomer:(UIButton *)sender{
    [_phoneTF resignFirstResponder];
    if ([_phoneTF.text isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"手机号不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];

        
    }else{
        if (_phoneTF.text.length == 11) {
            MessageRegisterController *messVc = [[MessageRegisterController alloc]init];
            messVc.userName = _phoneTF.text;
            [self.navigationController pushViewController:messVc animated:NO];
        }else{
            [ToastManager showToast:@"手机号输入格式不正确" withTime:Toast_Hide_TIME];
        }

    }

}

- (void) TapAction:(id) sender
{
    [_phoneTF resignFirstResponder];
    
}



- (void) registerBtnAction: (id) sender
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}



@end