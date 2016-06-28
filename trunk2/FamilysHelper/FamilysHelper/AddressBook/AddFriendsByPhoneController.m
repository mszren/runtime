//
//  AddFriendsByPhoneController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/20.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AddFriendsByPhoneController.h"
#import "AddFriendsSearchPhoneController.h"
#import "HomeService.h"
#import "UserInfoViewController.h"

@interface AddFriendsByPhoneController ()<UITextFieldDelegate>

@end

@implementation AddFriendsByPhoneController{
    
    ASIHTTPRequest *_request;
}

#pragma mark
#pragma mark-- init & delloc
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeWhiteBackgroudView:@"搜号码"];
    
    self.view.backgroundColor = BGViewColor1;

    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.frame = CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 60);
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 20, 60)];
    _searchTF.textColor = [UIColor blackColor];
    _searchTF.keyboardType = UIKeyboardTypeNumberPad;
    _searchTF.placeholder = @"请输入手机号";
    _searchTF.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:_searchTF];
}

#pragma mark
#pragma mark-- nav item action
- (void)rightItemAction:(id)sender
{
    if ([_searchTF.text isEqualToString:[CurrentAccount currentAccount].username]) {
        [ToastManager showToast:@"自己不能邀请自己" withTime:Toast_Hide_TIME];
        return;
    }else if ([_searchTF.text isEqualToString:@""]){
        
        [ToastManager showToast:@"请输入手机号" withTime:Toast_Hide_TIME];
        return;
    }
    
    if (_request) {
        
        [_request cancel];
    }
    _request = [[HomeService shareInstance]findFriendByPhone:[CurrentAccount currentAccount].uid uid:_searchTF.text state:1 onSuccess:^(DataModel *dataModel) {
        if (dataModel.code == 200) {
            
            User *userModel = dataModel.data;
            
            
            UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
            userInfoVc.phone = userModel.username;
            userInfoVc.userId = userModel.uid;
            userInfoVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userInfoVc animated:YES];
        }
        else
            [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchTF resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    _searchTF.text = @"";
     [_searchTF resignFirstResponder];
}

@end
