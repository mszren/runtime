//
//  ToastHUD.m
//  Common
//
//  Created by Foster Yin on 3/8/13.
//
//

#import "ToastHUD.h"

@implementation ToastHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hideOnClick)
    {
        [self hide:NO];
    }
    
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
