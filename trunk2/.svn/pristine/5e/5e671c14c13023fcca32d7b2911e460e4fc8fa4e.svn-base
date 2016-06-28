//
//  ResetpwdController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ResetpwdController.h"
#import "SystemService.h"
@interface ResetpwdController ()

@end

@implementation ResetpwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"密码修改"];
    [self initializeNavBackView];
    self.view.backgroundColor = COLOR_VIEW_BG;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




 - (void)rightItemAction:(id) sender
 {
     if ([_tf_oldpass.text isEqualToString:@""]) {
         [ToastManager showToast:@"请填写当前密码" withTime:Toast_Hide_TIME];
     }else if ([_tf_newpass.text isEqualToString:@""]) {
         [ToastManager showToast:@"请填写新密码" withTime:Toast_Hide_TIME];
     }else if ([_tf_newpass.text length]<6){
         [ToastManager showToast:@"密码应不小于六位数" withTime:Toast_Hide_TIME];
     }else{
         
         if ([_tf_pass.text isEqualToString:@""] ){
             
           [ToastManager showToast:@"请确认新密码" withTime:Toast_Hide_TIME];
          }else if([_tf_pass.text isEqualToString:_tf_newpass.text]){
             _newpass=_tf_newpass.text;
             _oldpass=_tf_oldpass.text;
             [[SystemService shareInstance] editpass:[CurrentAccount currentAccount].uid oldpass:(NSString*) _oldpass newpass:(NSString*) _newpass onSuccess:^(DataModel *dataModel){
                 if (dataModel.code==200) {
                     
                     CurrentAccount* currentAccount = [CurrentAccount currentAccount];
                     currentAccount.password = _tf_newpass.text;
                     [AppCache saveCache:CACHE_SYSTEM_CURRENTUSER Data:currentAccount];
                     [ToastManager showToast:@"修改成功" withTime:Toast_Hide_TIME];
                 }
                 else{
                     [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                     
                 }
                 
             }];

         
         }else{
                  [ToastManager showToast:@"两次输入新密码不一致" withTime:Toast_Hide_TIME];
         }

     }
     

 }
@end
