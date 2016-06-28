//
//  KeyboardListener.h
//  Core
//
//  Created by Jim Huang on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct UIKeyboardFrameInfo
{
    CGSize screenSize;
    CGRect keyboardFrame;
    BOOL visible;
} KeyboardFrameInfo;

@interface KeyboardListener : NSObject
{
    BOOL _visible;
}

+(KeyboardListener*)sharedInstance;

-(BOOL)visible;

-(UIView*)keyboardView;

+ (KeyboardFrameInfo)caculateKeyboardFrameInfoFromNotification:(NSNotification *)notif;

@end
