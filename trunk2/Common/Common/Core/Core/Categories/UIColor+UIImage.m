//
//  UIColor+UIImage.m
//  Core
//
//  Created by meng li on 12-7-27.
//
//

#import "UIColor+UIImage.h"

@implementation UIColor (UIImage)

-(UIImage *)image
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
