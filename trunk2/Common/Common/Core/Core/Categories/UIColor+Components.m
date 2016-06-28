//
//  UIColor+Components.m
//  Core
//
//  Created by qluo on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Components.h"

@implementation UIColor (Components)

- (CGColorSpaceModel)colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents 
{
	switch (self.colorSpaceModel) 
    {
		case kCGColorSpaceModelRGB:
		case kCGColorSpaceModelMonochrome:
			return YES;
            break;
		default:
			return NO;
	}
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha 
{
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	CGFloat r,g,b,a;
	
	switch (self.colorSpaceModel) 
    {
		case kCGColorSpaceModelMonochrome:
			r = g = b = components[0];
			a = components[1];
			break;
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			a = components[3];
			break;
		default:	// We don't know how to handle this model
			return NO;
	}
	
	if (red) *red = r;
	if (green) *green = g;
	if (blue) *blue = b; 
	if (alpha) *alpha = a;
	
	return YES;
}

- (CGFloat)red
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat* c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat* c = CGColorGetComponents(self.CGColor);
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) 
    {
        return c[0];
    }
    return c[1];
}

- (CGFloat)blue
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat* c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome)
    {
        return c[0];
    }
    return c[2];
}

- (CGFloat)alpha
{
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)argbHex 
{
	NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
	
	CGFloat r,g,b,a;
	if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
	
	r = MIN(MAX(self.red, 0.0f), 1.0f);
	g = MIN(MAX(self.green, 0.0f), 1.0f);
	b = MIN(MAX(self.blue, 0.0f), 1.0f);
	
	return ((int)a << 24) + ((int)r << 16) + ((int)g << 8) + (int)b;
}

@end
