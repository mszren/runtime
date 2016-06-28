//
//  QRCodeScanController.m
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "QRCodeScanController.h"
#import "RegisterController.h"
#import "XMPPManager.h"

#import "QRCodeReader.h"


#import "ForgetPwdController.h"

static XMPPManager * xmppManager = nil;

@interface QRCodeScanController()<UITextFieldDelegate>

@end

@implementation QRCodeScanController

- (id)init
{
    self = [super init];
    if (self) {
        xmppManager = [XMPPManager ShareInstance];
    }
    return self;
}


- (id)initWithDelegate:(id<ZXingDelegate>)scanDelegate showCancel:(BOOL)shouldShowCancel OneDMode:(BOOL)shouldUseoOneDMode
{
    self = [super initWithDelegate:scanDelegate showCancel:shouldShowCancel OneDMode:shouldUseoOneDMode];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performScanAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *theReaders = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
        [qrcodeReader release];
        self.readers = theReaders;
        NSBundle *mainBundle = [NSBundle mainBundle];
        self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    }
    return self;
}

- (void)cancelClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraClicked
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
        }
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
        [ipc release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    CGRect tmpRt = self.view.frame;
    CGFloat tmpWidth = tmpRt.size.width;
    if (tmpRt.size.width > tmpRt.size.height){
        tmpWidth = tmpRt.size.height;
    }
    
    photoFrameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_frame.png"]];
    photoFrameView.frame = CGRectMake((tmpWidth - FRAME_WIDTH)/2, FRAME_TOP_MARGIN, FRAME_WIDTH, FRAME_WIDTH);
    [self.overlayView addSubview:photoFrameView];
    
    scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line.png"]];
    [self.overlayView addSubview:scanLine];
    
    //    _userTips  = [[[UILabel alloc] initWithFrame:CGRectMake(0, photoFrameView.frame.origin.y + photoFrameView.frame.size.height + TIPS_TOP_MARGIN, self.view.frame.size.width, TIPS_HEIGHT)] autorelease];
    _userTips  = [[[UILabel alloc] initWithFrame:CGRectMake(0, photoFrameView.frame.origin.y + photoFrameView.frame.size.height + TIPS_TOP_MARGIN, tmpWidth, TIPS_HEIGHT)] autorelease];
    _userTips.textColor = [UIColor whiteColor];
    _userTips.font = FONT_SIZE_16;
    _userTips.backgroundColor = [UIColor clearColor];
    _userTips.textAlignment = NSTextAlignmentCenter;
    _userTips.text = NSLocalizedString(@"barcode tips", nil);
    [self.overlayView addSubview:_userTips];
    
    [self initHeader];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.notSupportDevice) {
        _userTips.text = NSLocalizedString(@"barcode tips not", nil);
    }
    
    [self performSelector:@selector(performScanAnimation) withObject:nil afterDelay:.5];
}

- (void)initHeader
{
    CGRect tmpRt = self.view.frame;
    CGFloat tmpWidth = tmpRt.size.width;
    if (tmpRt.size.width > tmpRt.size.height){
        tmpWidth = tmpRt.size.height;
    }
    
    if (IsAtLeastiOSVersion(@"7.0"))
    {
        UIView *statusBarBackgroundView = [[[UIView alloc] init] autorelease];
        statusBarBackgroundView.backgroundColor = COLOR_GREEN_DEFAULT;
        statusBarBackgroundView.frame = CGRectMake(0, 0, tmpWidth, 20);
        statusBarBackgroundView.opaque = NO;
        [self.overlayView addSubview:statusBarBackgroundView];
    }
    
    header = [[UIView alloc] init];
    header.backgroundColor = COLOR_GREEN_DEFAULT;
    header.frame = CGRectMake(0, HEADER_VIEW_TOP_MARGIN, tmpWidth, TOP_HEADER_BAR_HEIGHT);
    header.opaque = NO;
    [self.overlayView addSubview:header];
    
    NavigationButtonView* cancelBtn = [UINavigationUtils createNavigationButton:NSLocalizedString(@"button cancel", nil)
                                                                         target:self
                                                                         action:@selector(cancelClicked)];
    [cancelBtn.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [header addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(NAVIGATION_BUTTON_MARGIN,(TOP_HEADER_BAR_HEIGHT - cancelBtn.frame.size.height) / 2, cancelBtn.frame.size.width, cancelBtn.frame.size.height);
    
    NavigationButtonView* photoBtn = [UINavigationUtils createNavigationButton:NSLocalizedString(@"button camera", nil)
                                                                        target:self
                                                                        action:@selector(cameraClicked)];
    [photoBtn.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [header addSubview:photoBtn];
    photoBtn.frame = CGRectMake(tmpWidth - photoBtn.frame.size.width - NAVIGATION_BUTTON_MARGIN, (TOP_HEADER_BAR_HEIGHT - photoBtn.frame.size.height) / 2, photoBtn.frame.size.width, photoBtn.frame.size.height);
    
    UISwitch* lightSwitch = [[[UISwitch alloc] init] autorelease];
    [lightSwitch addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    lightSwitch.center = CGPointMake(header.center.x + FLASH_RIGHT_MARGIN, header.center.y - HEADER_VIEW_TOP_MARGIN);
    [header addSubview:lightSwitch];
    
    UIImageView* flashLight = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flashlight.png"]] autorelease];
    flashLight.frame = CGRectMake(lightSwitch.frame.origin.x - FLASH_LIGHT_WIDTH - FLASH_RIGHT_MARGIN, header.center.y - HEADER_VIEW_TOP_MARGIN - FLASH_LIGHT_HEIGHT / 2, FLASH_LIGHT_WIDTH, FLASH_LIGHT_HEIGHT);
    [header addSubview:flashLight];
}

- (void)performScanAnimation
{
    scanLine.frame = CGRectMake(0, SCANLINE_TOP_MARGIN, SCANLINE_WIDTH, SCANLINE_HEIGHT);
    scanLine.alpha = 1;
    
    /* Fix BUG #30565::【iPhone】【v7.2.1】【二维码】ios4系统上，打开二维码扫描画面后，界面内按钮操作都没有反应
     * It's strange that use block animation will cause this problem in iOS4.x of iPad(Not test in iPhone with iOS4.x for lack device)
     * We use old way to implement this animation for iOS4.x
     * It's a workaround
     **/
    typedef void(^Block)(void);
    Block endState = ^{
        scanLine.frame = CGRectMake(0, SCANLINE_BOTTOM_MARGIN, SCANLINE_WIDTH, SCANLINE_HEIGHT);
        scanLine.alpha = 0;
    };
    if (IsAtLeastiOSVersion(@"5.0")) {
        [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionRepeat animations:endState
                         completion:^(BOOL finished){
                             
                         }];
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:.5];
        [UIView setAnimationDuration:2.];
        [UIView setAnimationRepeatCount:MAXFLOAT]; // Set an infinite number for simplicity
        endState();
        [UIView commitAnimations];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)onSwitchValueChanged:(UISwitch*)sender
{
    BOOL torchMode = sender.on ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
    [self setTorch:torchMode];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (image != nil) {
        Decoder *d = [[Decoder alloc] init];
        d.readers = readers;
        d.delegate = self;
        d.tag = IMAGE_PICKER_DECODER_TAG;
        [d decodeImage:image];
        [d release];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseScanResult:(NSString*)theResult
{
    
    if (theResult)
    {
#if TARGET_IPHONE_SIMULATOR
#else
        [self.captureSession stopRunning];
#endif
        if ([theResult rangeOfString:QR_LOGIN_ADDRESS].location != NSNotFound)
        {
            //二维码登陆
            NSRange range = [theResult rangeOfString:QR_LOGIN_ADDRESS];
            NSString* qrCode = [theResult substringFromIndex:range.location + range.length];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[BarcodeScannerViewController qrCodeAPI]]];
                request.requestMethod = @"POST";
                NSString* postBody = [NSString stringWithFormat:@"qrcode=%@",qrCode];
                [request appendPostData:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
                [request startSynchronous];
                if ([request error])
                {
                    DebugLog(@"[QRcode]%@",[request error]);
                }
                else
                {
                    DebugLog(@"%@",[request responseString]);
                    NSDictionary* str = [[request responseString] JSONValue];
                    /*
                     {
                     "status": 0,
                     "data": {
                     "client_id": "07B6928B-BC18-49CF-9A90-DA27FAE0760E"
                     }
                     }
                     */
                    if ([[str objectForKey:@"status"] integerValue] == 0)
                    {
                        NSString* clientId = [[str objectForKey:@"data"] objectForKey:@"client_id"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [sonarLoginManager handleSonarLoginCommandWithParam:clientId];
                        });
                    }
                }
            });
        }
        else
        {
            UIAlertView* alert = nil;
            if ([NSURL isValidUrlString:theResult])
            {
                alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"barcode result", nil)
                                                    message:theResult
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"button cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"button open link", nil), nil] autorelease];
                alert.tag = ALERT_TAG_OPEN_LINK;
            }
            else
            {
                //(TODO:luoqi)区分二维码登陆信息和普通文本处理
                alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"barcode result", nil)
                                                    message:theResult
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"button cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"button copy", nil), nil] autorelease];
                alert.tag = ALERT_TAG_COPY_TEXT;
            }
            [alert show];
        }
    }
    else
    {
        [ToastManager showToast:NSLocalizedString(@"barcode scan fail", nil)];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        if (alertView.tag == ALERT_TAG_OPEN_LINK)
        {
            if (theDelegate && [theDelegate respondsToSelector:@selector(onBarcodeOpenLinkClick:)])
            {
                [theDelegate onBarcodeOpenLinkClick:alertView.message];
            }
        }
        else if(alertView.tag == ALERT_TAG_COPY_TEXT)
        {
            UIPasteboard* pasteBoard = [UIPasteboard generalPasteboard];
            if (![CommonFunctions isNullOrEmpty:alertView.message])
            {
                [pasteBoard setString:alertView.message];
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
#if TARGET_IPHONE_SIMULATOR
#else
        [self.captureSession startRunning];
#endif
        decoding = YES;
    }
}

- (void)onScanResult:(NSString *)theResult
{
    [self parseScanResult:theResult];
}

- (void)onCancelScan
{
    DebugLog(@"onCancelScan");
}

- (BOOL)isPickFromAlbum:(NSInteger)tag
{
    return tag == IMAGE_PICKER_DECODER_TAG;
}

- (void)decoder:(Decoder *)decoder failedToDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset reason:(NSString *)reason;
{
    [super decoder:decoder failedToDecodeImage:image usingSubset:subset reason:reason];
    if ([self isPickFromAlbum:decoder.tag]) {
        [ToastManager showToast:NSLocalizedString(@"barcode scan fail", nil)];
    }
}

@end
