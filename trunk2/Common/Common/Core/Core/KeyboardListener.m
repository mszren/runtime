//
//  KeyboardListener.m
//  Core
//
//  Created by Jim Huang on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyboardListener.h"
#import "DeviceUtils.h"

static KeyboardListener* sharedInstance;

@implementation KeyboardListener

+(KeyboardListener*)sharedInstance
{
    return sharedInstance;
}

/*
 +load is a special method called by the Objective-C runtime. It is called for each class after the app binary loads, but before the main() function is entered. There is no guarantee that an autorelease pool will be live.*/
+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    sharedInstance = [[self alloc] init];
    [pool release];
}

-(id)init
{
    self = [super init];
    if(self)
    {
        //In ios 6 will system will not send the willShow and willHide Notification
        //and only iOS 5 have UIKeyboardWillChangeFrameNotification
        if (IsAtLeastiOSVersion(@"5.0"))
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
        }
    }
    
    return self;
}

-(UIView*)keyboardView
{
    NSArray* windows = [[UIApplication sharedApplication] windows];
    for(UIWindow* window in windows)
    {
        // Keyboard window's name is UITextEffectsWindow.
        if([NSStringFromClass([window class]) hasPrefix:@"UIText"])
        {
            for(UIView* view in [window subviews])
            {
                // Keyboard view's name is UIPeripheralHostView.
                if([NSStringFromClass([view class]) hasPrefix:@"UIPeripheral"])
                {
                    return view;
                }
            }
        }
    }
    
    return nil;
}

-(BOOL)visible
{
    return _visible;
}

+ (KeyboardFrameInfo)caculateKeyboardFrameInfoFromNotification:(NSNotification *)notif
{
    NSValue *keyboardEndFrameValue = [notif.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyboardEndFrame = [keyboardEndFrameValue CGRectValue];
    
    CGFloat screenHeight = 0;
    CGFloat keyboardOriginY = 0;
    CGFloat screenWidth = 0;
    CGFloat keyboardOriginX = 0;
    CGFloat keyboardWidth = 0;
    CGFloat keyboardHeight = 0;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)
    {
        screenHeight = [UIScreen mainScreen].bounds.size.width;
        keyboardOriginY = screenHeight - (keyboardEndFrame.origin.x + keyboardEndFrame.size.width);//keyboard's window orentation is different
        screenWidth = [UIScreen mainScreen].bounds.size.height;
        keyboardOriginX = keyboardEndFrame.origin.y;
        keyboardWidth = keyboardEndFrame.size.height;
        keyboardHeight = keyboardEndFrame.size.width;
        //case 1 user click done on keyboard, the dismiss end frame is (-162, 0, 162, 480)
        //case 2 user click back on a view controller the keyboard auto dismiss, the end frame is (0, 480, 162, 480) like click back on newsletter page
    }
    else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        screenHeight = [UIScreen mainScreen].bounds.size.width;
        keyboardOriginY = keyboardEndFrame.origin.x;//keyboard's window orentation is different
        screenWidth = [UIScreen mainScreen].bounds.size.height;
        keyboardOriginX = screenWidth - (keyboardEndFrame.origin.y + keyboardEndFrame.size.height);
        keyboardWidth = keyboardEndFrame.size.height;
        keyboardHeight = keyboardEndFrame.size.width;
        //case 1 user click done on keyboard, the dismiss end frame is (320, 0, 162, 480)
        //case 2 user click back on a view controller the keyboard auto dismiss, the end frame is (158, -480, 162, 480) like click back on newsletter page
    }
    else
    {
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        keyboardOriginY = keyboardEndFrame.origin.y;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        keyboardOriginX = keyboardEndFrame.origin.x;
        keyboardWidth = keyboardEndFrame.size.width;
        keyboardHeight = keyboardEndFrame.size.height;
        //case 1 user click done on keyboard, the dismiss end frame is (0, 480, 320, 216)
        //case 2 user click back on a view controller the keyboard auto dismiss, the end frame is (320, 264, 320, 216) like click back on newsletter page
    }

    
    KeyboardFrameInfo info;
    info.screenSize = CGSizeMake(screenWidth, screenHeight);
    info.keyboardFrame = CGRectMake(keyboardOriginX, keyboardOriginY, keyboardWidth, keyboardHeight);
    info.visible = screenHeight > keyboardOriginY && (0 <= keyboardOriginY) && keyboardOriginX < screenWidth && keyboardOriginX >= 0;
    
    return info;
}

- (void)onKeyboardWillChangeFrame:(NSNotification *)notif
{
    KeyboardFrameInfo info = [[self class] caculateKeyboardFrameInfoFromNotification:notif];
    _visible = info.visible;
}

@end
