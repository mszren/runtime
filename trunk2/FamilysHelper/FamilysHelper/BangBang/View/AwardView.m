//
//  AwardView.m
//  FamilysHelper
//
//  Created by 我 on 15/6/30.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AwardView.h"
#import "TribeService.h"
#import "UIView+Toast.h"

#define NUMBERS @"0123456789."
@implementation AwardView {

    UIButton* _cancelButton;
    UIButton* _certainButton;
    UIView* _whiteView;
}
@synthesize messageListner;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self registerForKeyboardNotifications];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 200, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _whiteView.userInteractionEnabled = YES;
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];

        UILabel* bangLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 65, 15)];
        bangLabel.font = [UIFont systemFontOfSize:13];
        bangLabel.textColor = COLOR_RED_DEFAULT_04;
        bangLabel.text = @"帮币余额:";
        [_whiteView addSubview:bangLabel];

        _bangbi = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 15)];
        _bangbi.textColor = COLOR_RED_DEFAULT_78;
        _bangbi.font = [UIFont systemFontOfSize:14];
        [_whiteView addSubview:_bangbi];

        UIImageView* bangBiImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, 25, 28)];
        bangBiImage.image = [UIImage imageNamed:@"tab_icon_bnz_selected"];
        [_whiteView addSubview:bangBiImage];

        _bangBiTest = [[UITextField alloc] initWithFrame:CGRectMake(43, 53, SCREEN_WIDTH - 60, 15)];
        _bangBiTest.delegate = self;
        _bangBiTest.font = [UIFont systemFontOfSize:15];
        _bangBiTest.placeholder = @"请输入打赏帮币";
        _bangBiTest.textColor = COLOR_GRAY_DEFAULT_OPAQUE_1f;
        _bangBiTest.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_whiteView addSubview:_bangBiTest];

        UILabel* garyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, SCREEN_WIDTH - 20, 1)];
        garyLabel.backgroundColor = COLOR_RED_DEFAULT_BackGround;
        [_whiteView addSubview:garyLabel];

        _certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _certainButton.frame = CGRectMake(10, 90, SCREEN_WIDTH - 20, 40);
        _certainButton.backgroundColor = COLOR_GRAY_DEFAULT_107;
        [_certainButton setTitle:@"提交打赏" forState:UIControlStateNormal];
        _certainButton.layer.cornerRadius = 8;
        _certainButton.clipsToBounds = YES;
        _certainButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_certainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_certainButton addTarget:self action:@selector(onBtnCertain:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_certainButton];

        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(10, 145, SCREEN_WIDTH - 20, 40);
        _cancelButton.backgroundColor = COLOR_RED_DEFAULT_8d;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelButton.layer.cornerRadius = 8;
        _cancelButton.clipsToBounds = YES;
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_cancelButton];
    }
    return self;
}

#pragma mark
#pragma mark-- ButtonAction
- (void)onBtnCertain:(UIButton*)sender
{

    NSLog(@"_bangbi:%@", _bangBiTest.text);
    if ([_bangBiTest.text isEqualToString:@"0"] | [_bangBiTest.text isEqualToString:@""]) {

        [self makeToast:@"请输入打赏金额" duration:1 position:nil];
        return;
    }
    else {

        [[TribeService shareInstance] rewardTopicby:_objectId
                                               type:_typeId
                                             userID:[CurrentAccount currentAccount].uid
                                             target:_targetuserId
                                              prise:_bangBiTest.text.integerValue
                                          OnSuccess:^(DataModel* dataModel) {
                                              if (dataModel.code == 202) {

                                                  [ToastManager showToast:@"打赏成功" withTime:Toast_Hide_TIME];
                                                  [_bangBiTest resignFirstResponder];
                                                  
                                                  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
                                                  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
                                                  [self removeFromSuperview];

                                                  [messageListner RouteMessage:NOTIFICATION_REWARD withContext:@{ NOTIFICATION_DATA : _bangBiTest.text }];
                                              }
                                              else {
                                                  
                                                  [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                  
                                                  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
                                                  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
                                                  [self removeFromSuperview];
 
                                              }
 

                                          }];
    }
}

- (void)onBtnCancel:(UIButton*)sender
{

    [_bangBiTest resignFirstResponder];

    self.hidden = YES;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark
#pragma mark-- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{

    [_bangBiTest resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSCharacterSet* cs;
    if (textField == _bangBiTest) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString* filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            return NO;
        }
    }
    //其他的类型不需要检测，直接写入
    return YES;
}

#pragma mark
#pragma mark-- NSNotificationCenter

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notify
{

    [UIView animateWithDuration:0.25
                     animations:^{

                         self.frame = CGRectMake(0, -160, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

- (void)keyboardWillHidden:(NSNotification*)notify
{

    [UIView animateWithDuration:0.25
                     animations:^{
                         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

@end
