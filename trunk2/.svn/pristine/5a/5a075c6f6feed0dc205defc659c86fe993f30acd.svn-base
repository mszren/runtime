//
//  QRCodeScanController.h
//  FamilysHelper
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "ZXingWidgetController.h"
#import "QRCodeScanController.h"
@protocol QRCodeScanControllerDelegate <NSObject>

- (void)onBarcodeOpenLinkClick:(NSString*)urlString;

@end

@interface QRCodeScanController : ZXingWidgetController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,DecoderDelegate>
{
    UIView *header;
    UIImageView *scanLine;
    UIImageView *photoFrameView;
    BOOL isPresentingAlertView;
    SonarLoginManager *sonarLoginManager;
    
    UILabel  *_userTips;
}

@property(nonatomic,assign)id<BarcodeScannerViewControllerDelegate>theDelegate;

@end