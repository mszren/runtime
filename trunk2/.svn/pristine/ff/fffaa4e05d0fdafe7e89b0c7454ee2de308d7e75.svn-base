//
//  ToastManager.m
//  Dolphin
//
//  Created by Jiaji Yin on 11/12/11.
//  Copyright (c) 2011 Bainainfo. All rights reserved.
//

#import "ToastManager.h"
#import "MBProgressHUD.h"
#import "DeviceUtils.h"
#import "Globals.h"
#import "ToastHUD.h"
#import "UIView+Toast.h"

#define HUD_DEFAULT_HIDE_DELAY_INTENRVAL      5

@implementation ToastManager
+ (MBProgressHUD*)showToast:(NSString *)toastText imageName:(NSString *)imageName containerView:(UIView *)containerView withTime:(NSTimeInterval)time isProgressIndicator:(BOOL)isProgressIndicator
{
    if ([CommonFunctions isNullOrEmpty:toastText])
	{
        DebugLog(0, @"The toast message should not be null or empty.");
		return nil;
	}
    
    ToastHUD *HUD = [[ToastHUD alloc] initWithView:containerView] ;
	[containerView addSubview:HUD];
	
    //Even image name is nil, we still set a view to disable progress
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    // Set custom view mode
    HUD.mode = isProgressIndicator? MBProgressHUDModeIndeterminate: MBProgressHUDModeCustomView;

    HUD.opacity = 0.7;
    if ([DeviceUtils isPad])
    {
        HUD.minSize = CGSizeMake(174, 174);
    }
    
    HUD.removeFromSuperViewOnHide = YES;
    //change labelText to detailsLabelText to show toast contents, because we want mulilines for toast show 
    HUD.labelText = @""; //if we want to show detailsLabelText ,mast give a value for labelText
    HUD.detailsLabelText = toastText;
    HUD.detailsLabelFont = FONT_SIZE_BOLD_16;
    
    if (!isProgressIndicator)
    {
        //disable user interaction, so user can click behind this hud
        [HUD setUserInteractionEnabled:NO];
        [HUD setHideOnClick:YES];
    }
    
    [HUD show:YES];
    
    if(!isProgressIndicator)
    {
        [HUD hide:YES afterDelay:time];
    }
    
    return HUD;
}

+ (void)showToast:(NSString *)toastText imageName:(NSString *)imageName containerView:(UIView *)containerView withTime:(NSTimeInterval)time
{
    [ToastManager showToast:toastText imageName:imageName containerView:containerView withTime:time isProgressIndicator:NO];
}

+ (MBProgressHUD*)showProgressIndicator:(NSString*)toastText containerView:(UIView*)containerView
{
    return [ToastManager showToast:toastText imageName:nil containerView:containerView withTime:HUD_DEFAULT_HIDE_DELAY_INTENRVAL isProgressIndicator:YES];
}

+ (void)showToast:(NSString *)toastText imageName:(NSString *)imageName containerView:(UIView *)containerView
{	
    [ToastManager showToast:toastText imageName:imageName containerView:containerView withTime:HUD_DEFAULT_HIDE_DELAY_INTENRVAL];
}

+ (void)showToast:(NSString *)toastText containerView:(UIView *)containerView withTime:(NSTimeInterval)time
{	
    if(containerView != nil)
    {
        [ToastManager showToast:toastText imageName:nil containerView:containerView withTime:time];
    }
}

+ (void)showToast:(NSString *)toastText containerView:(UIView *)containerView
{	
    if(containerView != nil)
    {
        [ToastManager showToast:toastText imageName:nil containerView:containerView];
    }
}
//以下三种方法在静态view中不建议使用
+ (void)showToast:(NSString *)toastText imageName:(NSString *)imageName
{
	[ToastManager showToast:toastText imageName:imageName containerView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showToast:(NSString *)toastText withTime:(NSTimeInterval)time
{
    NSArray * temp = [UIApplication sharedApplication].windows;
    UIWindow * keyView = [temp objectAtIndex:0];
    UIView * tempView = keyView.rootViewController.view;
    
    [tempView makeToast:toastText duration:time position:@"center"];
}

+ (void)showToast:(NSString *)toastText
{
    NSArray * temp = [UIApplication sharedApplication].windows;
    UIWindow * keyView = [temp objectAtIndex:0];
    UIView * tempView = keyView.rootViewController.view;
    
    [tempView makeToast:toastText duration:HUD_DEFAULT_HIDE_DELAY_INTENRVAL position:@"center"];
//	[ToastManager showToast:toastText containerView:[UIApplication sharedApplication].keyWindow];
}


+ (void)showToastWithKeyWindow:(NSString *)toastText withTime:(NSTimeInterval)time
{
    NSArray * temp = [UIApplication sharedApplication].windows;
    UIWindow * keyView = [temp objectAtIndex:0];
    UIView * tempView = keyView.rootViewController.view;
    
    [tempView makeToast:toastText duration:time position:@"center"];
}

@end
