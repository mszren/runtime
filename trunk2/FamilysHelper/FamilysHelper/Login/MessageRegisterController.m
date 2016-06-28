//
//  MessageRegisterController.m
//  FamilysHelper
//
//  Created by 我 on 15/6/19.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MessageRegisterController.h"
#import "SystemService.h"
#import "RegisController.h"
#import "UIView+Toast.h"

#define NUMBERS @"0123456789"
@interface MessageRegisterController ()<UITextFieldDelegate>

@end

@implementation MessageRegisterController{
    UITextField * _verificationCodeTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VIEW_BG;
    [self customUI];
    
}


#pragma mark
#pragma mark -- init
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
    phoneLabel.text = @"验证码";
    phoneLabel.textColor = COLOR_GRAY_DEFAULT_30;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:phoneLabel];
    
    _verificationCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(75, 0 , SCREEN_WIDTH - 75, 50)];
    _verificationCodeTF.delegate = self;
    _verificationCodeTF.placeholder = @"请输入验证码";
    _verificationCodeTF.font = [UIFont systemFontOfSize:13];
    _verificationCodeTF.textColor = COLOR_GRAY_DEFAULT_30;
    [backView addSubview:_verificationCodeTF];
    
 
    
    [self lodaData];
}


#pragma mark
#pragma mark -- loadData

-(void)lodaData{
    
    [[SystemService shareInstance] getNewIndentifyCode:_userName onSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 202) {
            
        }else if (dataModel.code == 20015){
            [ToastManager showToast:@"用户已存在" withTime:Toast_Hide_TIME];
            return ;
        }
    }];
}

//- (void) getVerificationCodeBtnAction :(id) sender
//{
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [_getVerificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                _getVerificationCodeBtn.userInteractionEnabled = YES;
//            });
//        }else{
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_getVerificationCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                _getVerificationCodeBtn.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//    
//    
//}


- (void) TapAction:(id) sender
{
    [_verificationCodeTF resignFirstResponder];
   
}

-(void)onBtnCustomer:(UIButton *)sender{

    [_verificationCodeTF resignFirstResponder];
     [[SystemService shareInstance] checkNumNew:_userName num:_verificationCodeTF.text onSuccess:^(DataModel *dataModel) {
         if (dataModel.code == 202) {
    
             RegisController *reVc = [[RegisController alloc]init];
             reVc.newuserName = self.userName;
             reVc.num = _verificationCodeTF.text;
             [self.navigationController pushViewController:reVc animated:NO];

         }else {
             
             [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
         }

         
     }];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_verificationCodeTF resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    if(textField == _verificationCodeTF)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            return NO;
        }
    }
    //其他的类型不需要检测，直接写入
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
