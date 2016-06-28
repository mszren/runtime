//
//  UIColor+Components.h
//  Core
//
//  Created by qluo on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Components)

- (CGColorSpaceModel)colorSpaceModel;
- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;
- (UInt32)argbHex;
@end
