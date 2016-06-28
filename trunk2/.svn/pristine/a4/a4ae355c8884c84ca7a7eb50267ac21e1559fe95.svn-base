//
//  RegisController.m
//  FamilysHelper
//
//  Created by 我 on 15/6/19.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RegisController.h"
#import "SystemService.h"
#import "LoginController.h"
#import "AppCache.h"
#import "AppCacheConfig.h"
#import "PathHelper.h"
#import "OSSUnity.h"
#import "ZYQAssetPickerController.h"
#import "UIView+Toast.h"
#import "UzysAssetsPickerController.h"
#import "ImgModel.h"
#import "OSSUnity.h"

@interface RegisController () <UITextFieldDelegate, UIAlertViewDelegate,UzysAssetsPickerControllerDelegate>

@end

@implementation RegisController {
    UIImageView* _imageUrl;
    NSString* _images;
    NSArray* _imagesArry;
    UIImage* _selectImage;

    UITextField* _userName;
    UITextField* _password;
    UITextField* _confirmPassword;
    NSMutableArray *_arrImg;
    
    NSMutableArray *_editImags;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VIEW_BG;
    [self customUI];
}

#pragma mark
#pragma mark-- init
- (void)customUI
{

    [self registerForKeyboardNotifications];

    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnCustomer:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"账号注册";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = COLOR_RED_DEFAULT_904;
    self.navigationItem.titleView = titleLabel;

    _arrImg = [[NSMutableArray alloc]initWithCapacity:0];
    
    _imageUrl = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 42, 56, 84, 84)];
    _imageUrl.layer.cornerRadius = 42;
    _imageUrl.clipsToBounds = YES;
    _imageUrl.backgroundColor = [UIColor greenColor];
    _imageUrl.userInteractionEnabled = YES;
    [self.view addSubview:_imageUrl];

    //获取图片
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [_imageUrl addGestureRecognizer:tap];

    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];

    UILabel* phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 50)];
    phoneLabel.text = @"昵称";
    phoneLabel.textColor = COLOR_GRAY_DEFAULT_30;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:phoneLabel];

    _userName = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, 200, 50)];
    _userName.delegate = self;
    _userName.placeholder = @"输入昵称";
    _userName.font = [UIFont systemFontOfSize:13];
    _userName.textColor = COLOR_GRAY_DEFAULT_30;
    [backView addSubview:_userName];

    UIView* PasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 271, SCREEN_WIDTH, 50)];
    PasswordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PasswordView];

    UILabel* PasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 50)];
    PasswordLabel.text = @"登陆密码";
    PasswordLabel.textColor = COLOR_GRAY_DEFAULT_30;
    PasswordLabel.font = [UIFont systemFontOfSize:15];
    [PasswordView addSubview:PasswordLabel];

    _password = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, 200, 50)];
    _password.delegate = self;
    _password.placeholder = @"输入密码";
    _password.font = [UIFont systemFontOfSize:13];
    _password.textColor = COLOR_GRAY_DEFAULT_30;
    [PasswordView addSubview:_password];

    UIView* ConfirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 322, SCREEN_WIDTH, 50)];
    ConfirmView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ConfirmView];

    UILabel* ConfirmLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 50)];
    ConfirmLabel.text = @"确认密码";
    ConfirmLabel.textColor = COLOR_GRAY_DEFAULT_30;
    ConfirmLabel.font = [UIFont systemFontOfSize:15];
    [ConfirmView addSubview:ConfirmLabel];

    _confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, 200, 50)];
    _confirmPassword.delegate = self;
    _confirmPassword.placeholder = @"输入密码";
    _confirmPassword.font = [UIFont systemFontOfSize:13];
    _confirmPassword.textColor = COLOR_GRAY_DEFAULT_30;
    [ConfirmView addSubview:_confirmPassword];
}

//进行注册
- (void)onBtnCustomer:(UIButton*)sender
{

    if (![_password.text isEqualToString:_confirmPassword.text]) {
        
        [ToastManager showToast:@"密码输入不同，请再次确认密码" withTime:Toast_Hide_TIME];
        return;
    }
    else if ([_userName.text isEqualToString:@""]) {
        
        [ToastManager showToast:@"请输入昵称" withTime:Toast_Hide_TIME];
        return;
    }
    else if ([_password.text isEqualToString:@""]) {
        
        [ToastManager showToast:@"请输入密码" withTime:Toast_Hide_TIME];
        return;
    }
    else if ([_confirmPassword.text isEqualToString:@""]) {
        
        [ToastManager showToast:@"请确认密码" withTime:Toast_Hide_TIME];
        return;
    }
    
        _editImags = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < _arrImg.count; i++) {
            ALAsset* asset = _arrImg[i];
            UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            NSData* editImageData = UIImageJPEGRepresentation(tempImg, 0.8f);
            
            NSString* name = [NSString stringWithFormat:@"%@.jpg", [NSDate currentTimeByJava]];
            NSString* path = [[PathHelper cacheDirectoryPathWithName:MSG_Img_Dir_Name] stringByAppendingPathComponent:name];
            [editImageData writeToFile:path atomically:YES];
            ImgModel* model = [[ImgModel alloc] init];
            model.sort = i;
            model.imgpath = path;
            [_editImags addObject:model];
            
            CurrentAccount *currentAccount = [CurrentAccount currentAccount];
            currentAccount.imagePath = path;
            [AppCache saveCache:CACHE_SYSTEM_CURRENTUSER Data:currentAccount];
        }
        
        if (_arrImg.count == 0) {
            _images = @"";
            [self regist];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [[OSSUnity shareInstance] uploadFiles:_editImags
                            withTargetSubPath:OSSMessagePath
                                    withBlock:^(NSArray* arrStatus) {
                                        NSMutableString* _arrResourceURL = [[NSMutableString alloc] initWithCapacity:0];
                                        for (int i = 0; i < _editImags.count; i++) {
                                            ImgModel* model = _editImags[i];
                                            if (i == _editImags.count - 1)
                                                [_arrResourceURL appendFormat:@"%@", model.imagename];
                                            else
                                                [_arrResourceURL appendFormat:@"%@,", model.imagename];
                                        }
                                        
                                        
                                        _images = [NSString stringWithFormat:@"%@",_arrResourceURL];
                                        
                                        [self regist];
                                    
                                    }];
    
    
    [self performSelector];
    
}

-(void)regist{
    
    [[SystemService shareInstance] userRegister:self.newuserName
                                            pwd:_password.text
                                       nickname:_userName.text
                                            num:self.num
                                           face:_images
                                      onSuccess:^(DataModel* dataModel) {
                                          
                                          if (dataModel.code == 202) {
                                              
                                              CurrentAccount* currentAccount = [CurrentAccount currentAccount];
                                              currentAccount.password = _password.text;
                                              currentAccount.username = self.newuserName;
                                              currentAccount.num = self.num;
                                              currentAccount.nickname = _userName.text;
                                              currentAccount.face = _images;
                                              [AppCache saveCache:CACHE_SYSTEM_CURRENTUSER Data:currentAccount];
 
                                              [ToastManager showToast:@"注册成功" withTime:Toast_Hide_TIME];
                                              
                                          }
                                          else {
                                              
                                              [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                          }
                                          
                                      }];
}

- (void)onTap:(UITapGestureRecognizer*)sender
{
    
    [_arrImg removeAllObjects];

#if 0
    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
    appearanceConfig.finishSelectionButtonColor = [UIColor blueColor];
    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
    appearanceConfig.cellSpacing = 1.0f;
    appearanceConfig.assetsCountInALine = 5;
    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
#endif
    UzysAssetsPickerController* picker = [[UzysAssetsPickerController alloc] init];
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 1;
    picker.delegate = self;
    
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
                     }];
 
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        [_arrImg addObjectsFromArray:assets];
        
        ALAsset* asset = assets[0];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        _imageUrl.image = tempImg;
        
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil)
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark
#pragma mark-- UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark-- performSelector延时触发
- (void)performSelector
{

    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];

    [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];


    [self.navigationController popToRootViewControllerAnimated:YES];
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

                         self.view.frame = CGRectMake(0, -80 , SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

- (void)keyboardWillHidden:(NSNotification*)notify
{

    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.frame = CGRectMake(0, TabBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
