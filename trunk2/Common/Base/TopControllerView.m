//
//  TopControllerView.m
//  Book
//
//  Created by caoliang on 13-10-30.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import "TopControllerView.h"

@implementation TopControllerView
@synthesize backBtn = _backBtn;
@synthesize titleLab = _titleLab;
@synthesize backMethod;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];

        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.backgroundColor = [UIColor clearColor];
        [self.backBtn setImage:[UIImage imageNamed:@"backBtnBg.png"] forState:UIControlStateNormal];
        self.backBtn.frame = CGRectMake(0, 5, self.backBtn.imageView.image.size.width, self.backBtn.imageView.image.size.height);
        [self.backBtn addTarget:self action:@selector(backMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 260, TopBarHeight)];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = TopViewTitleColor;
        self.titleLab.font = FONT_SIZE(20);
        [self addSubview:self.titleLab];
    }
    return self;
}
#pragma mark -
#pragma mark Private Method
- (void)backMethod:(id)sender{
    if (self.backMethod) {
        self.backMethod();
    }
}

@end
