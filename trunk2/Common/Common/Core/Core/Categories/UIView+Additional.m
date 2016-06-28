//
//  UIView+Additional.m
//  Common
//
//  Created by Jim Huang on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+Additional.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (UIView_Additional)

- (id) traverseResponderChainForUIViewController 
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) 
    {
        return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]]) 
    {
        return [nextResponder traverseResponderChainForUIViewController];
    } 
    else 
    {
        return nil;
    }
}

-(UIViewController*)viewController
{
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

-(UIImage*)screenShot
{
    UIImage *screenImage = nil;
    UIGraphicsBeginImageContext(self.frame.size);
    
    // TODO:(mli) Make more clear, seems no work
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    CGContextSetShouldSmoothFonts(UIGraphicsGetCurrentContext(),YES);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

@end
