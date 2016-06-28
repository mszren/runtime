//
//  UIScrollView+GestureRecognizer.m
//  Core
//
//  Created by Jim Huang on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIScrollView+GestureRecognizer.h"

@implementation UIScrollView (GestureRecognizer)

-(UIPanGestureRecognizer*)thePanGestureRecognizer
{
    for(UIGestureRecognizer* recognizer in [self gestureRecognizers])
    {
        if([recognizer isKindOfClass:[UIPanGestureRecognizer class]])
        {
            return (UIPanGestureRecognizer*)recognizer;
        }
    }
    
    return nil;
}

@end
