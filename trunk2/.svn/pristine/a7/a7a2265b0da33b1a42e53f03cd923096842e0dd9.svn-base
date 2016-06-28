//
//  BorderView.m
//  WeiboSDK
//
//  Created by Yujie Zhang on 4/4/12.
//  Copyright (c) 2012 Ecpalm. All rights reserved.
//

#import "EGOimageViewWithBorder.h"

@implementation EGOimageViewWithBorder
@synthesize egoImageView;
@synthesize borderColor;


- (id)initWithFrame:(CGRect)frame borderWidth:(CGFloat)width0 gap:(CGFloat)gap0
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = [UIColor colorWithRed:163/255.0 green:173/255.0 blue:178/255.0 alpha:1.0];
        width = width0;
        gap = gap0;
        CGRect rect = CGRectMake(width * 2, 
                                 width * 2, 
                                 self.frame.size.width - (width + gap) * 2,
                                 self.frame.size.height - (width + gap) * 2);
        self.egoImageView = [[[EGOImageView alloc] initWithFrame:rect] autorelease];
        [self addSubview:self.egoImageView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = [UIColor colorWithRed:163/255.0 green:173/255.0 blue:178/255.0 alpha:1.0];
        width = 2.0;
        gap = 2.0;
        CGRect rect = CGRectMake(width * 2, 
                                 width * 2, 
                                 self.frame.size.width - (width + gap) * 2,
                                 self.frame.size.height - (width + gap) * 2);
        self.egoImageView = [[[EGOImageView alloc] initWithFrame:rect] autorelease];
        [self addSubview:self.egoImageView];
    }
    return self;
}

//设置边框宽度和间隙宽度
- (void)setWidth:(CGFloat)width0 gap:(CGFloat)gap0 {
    
    width = width0;
    gap = gap0;
    CGRect rect = CGRectMake(width * 2, 
                             width * 2, 
                             self.frame.size.width - (width + gap) * 2,
                             self.frame.size.height - (width + gap) * 2);
    self.egoImageView.frame = rect;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect eclipse = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextAddRect(context, eclipse);
    CGContextStrokePath(context);

}


@end
