//
//  PublishController.m
//  FamilysHelper
//
//  Created by Owen on 15/6/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "PublishController.h"
#import "PublishAlbumTopView.h"
#import "OSSUnity.h"
#import "PathHelper.h"
#import "HomeService.h"
#import "ImgModel.h"
#import "MsgModel.h"
#import "AllChatController.h"
#import "UzysAssetsPickerController.h"

@interface PublishController () <PublishAlbumTopViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate, UzysAssetsPickerControllerDelegate> {
    PublishAlbumTopView* _publishAlbumTopView;
    UITextView* _tvContent;
    UILabel* _covertLabel;
    NSString* _imageUrl;
    NSMutableArray* _arrImgs;
}

@end

@implementation PublishController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"发布消息"];
    [self initializeNavBackView];
    [self initializeMyView];
}

- (void)initializeMyView
{
    [self.view setBackgroundColor:BGViewGray];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publichAction:)];
    [rightItem setTintColor:HomeNavBarBgColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    _publishAlbumTopView = [[PublishAlbumTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PublishImageTileHeight + 40)];
    _publishAlbumTopView.delegate = self;
    [_publishAlbumTopView setViewDefault];
    [self.view addSubview:_publishAlbumTopView];

    _tvContent = [[UITextView alloc] init];
    _tvContent.backgroundColor = [UIColor whiteColor];
    _tvContent.frame = CGRectMake(_publishAlbumTopView.frame.origin.x, PublishImageTileHeight + 50, SCREEN_WIDTH, 80);
    _tvContent.font = FONT_SIZE_14;
    _tvContent.delegate = self;
    [self.view addSubview:_tvContent];

    _covertLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH, 20)];
    _covertLabel.textColor = COLOR_DARKGRAY_DEFAULT;
    _covertLabel.font = [UIFont systemFontOfSize:15];
    _covertLabel.text = @"请输入内容";
    _covertLabel.textColor = COLOR_GRAY_DEFAULT_OPAQUE_7a;
    [_tvContent addSubview:_covertLabel];
}

- (void)publichAction:(id)sender
{

    if (_publishAlbumTopView.dataList.count == 0) {
        [ToastManager showToast:@"请选择要上传的图片！" withTime:Toast_Hide_TIME];
        return;
    }
    if (_tvContent.text.length == 0) {
        [ToastManager showToast:@"请选择输入内容！" withTime:Toast_Hide_TIME];
        return;
    }

    _arrImgs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [_publishAlbumTopView.dataList count]; i++) {
        ALAsset* asset = _publishAlbumTopView.dataList[i];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        NSData* editImageData = UIImageJPEGRepresentation(tempImg, 0.8f);

        NSString* name = [NSString stringWithFormat:@"%@.jpg", [NSDate currentTimeByJava]];
        NSString* path = [[PathHelper cacheDirectoryPathWithName:MSG_Img_Dir_Name] stringByAppendingPathComponent:name];
        [editImageData writeToFile:path atomically:YES];
        ImgModel* model = [[ImgModel alloc] init];
        model.sort = i;
        model.imgpath = path;
        [_arrImgs addObject:model];
    }

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[OSSUnity shareInstance] uploadFiles:_arrImgs
                        withTargetSubPath:OSSMessagePath
                                withBlock:^(NSArray* arrStatus) {
                                    NSMutableString* _arrResourceURL = [[NSMutableString alloc] initWithCapacity:0];
                                    for (int i = 0; i < _arrImgs.count; i++) {
                                        ImgModel* model = _arrImgs[i];
                                        if (i == _arrImgs.count - 1)
                                            [_arrResourceURL appendFormat:@"%@", model.imagename];
                                        else
                                            [_arrResourceURL appendFormat:@"%@,", model.imagename];
                                    }
                                    if (_msg_Type == 4) {
                                        [[HomeService shareInstance] insertTalk:[CurrentAccount currentAccount].uid
                                                                        content:_tvContent.text
                                                                       imageUrl:_arrResourceURL
                                                                      onSuccess:^(DataModel* dataModel) {

                                                                          NSInteger result = dataModel.code;
                                                                          if (202 == result) {
                                                                              [ToastManager showToast:@"发布成功" withTime:Toast_Hide_TIME];
                                                                          }
                                                                          else if (500 == result) {
                                                                              [ToastManager showToast:@"数据解析错误" withTime:Toast_Hide_TIME];
                                                                          }
                                                                          else if (10004 == result) {
                                                                              [ToastManager showToast:@"登录超时，请重新登录" withTime:Toast_Hide_TIME];
                                                                          }
                                                                          else {
                                                                              [ToastManager showToast:@"网络超时" withTime:Toast_Hide_TIME];
                                                                          }

                                                                      }];
                                    }
                                    else {
                                        [[HomeService shareInstance] addLifeCircleInfo:[CurrentAccount currentAccount].uid
                                                                               content:_tvContent.text
                                                                             life_type:_msg_Type
                                                                              imageUrl:_arrResourceURL
                                                                             onSuccess:^(DataModel* dataModel) {
                                                                                 NSInteger result = dataModel.code;
                                                                                 if (202 == result) {
                                                                                     [ToastManager showToast:@"发布成功" withTime:Toast_Hide_TIME];
                                                                                 }
                                                                                 else if (500 == result) {
                                                                                     [ToastManager showToast:@"数据解析错误" withTime:Toast_Hide_TIME];
                                                                                 }
                                                                                 else {
                                                                                     [ToastManager showToast:@"网络超时" withTime:Toast_Hide_TIME];
                                                                                 }

                                                                             }];
                                    }
                                }];
    [self RouteMessage];
    [self.navigationController popViewControllerAnimated:YES];
}

//路由调用刷新
- (void)RouteMessage
{

    MsgModel* msgModel = [[MsgModel alloc] init];
    msgModel.nickname = [CurrentAccount currentAccount].nickname;
    msgModel.content = _tvContent.text;
    msgModel.face = [CurrentAccount currentAccount].face;
    msgModel.createTime = [NSDate currentTimeByJava];
    msgModel.cellHeight = 194;
    msgModel.hotNum = 0;
    msgModel.replyCommentNumber = 0;
    msgModel.lifeType = _msg_Type;
    msgModel.imgList = _arrImgs;

    [self RouteMessage:NOTIFICATION_HOME_PUBLISH withContext:@{ NOTIFICATION_DATA : msgModel }];
}

#pragma mark -
#pragma mark PublishAlbumTopViewDelegate

- (void)showPickImgs:(NSMutableArray*)dataList
{

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
    picker.maximumNumberOfSelectionPhoto = 3 - dataList.count;
    picker.delegate = self;

    [self presentViewController:picker
                       animated:YES
                     completion:^{

                     }];
}

#pragma mark
#pragma mark-- UITextViewDelegate

- (void)textViewDidChange:(UITextView*)textView
{
    _tvContent.text = textView.text;
    if (_tvContent.text.length == 0) {
        _covertLabel.text = @"请输入内容";
    }
    else {
        _covertLabel.text = @"";
    }
}

- (void)textViewDidBeginEditing:(UITextView*)textView
{
    _tvContent = textView;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {

        [_tvContent resignFirstResponder];
        return NO;
    }

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{

    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [_publishAlbumTopView addImgUrls:assets];
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
@end
