//
//  BadgeView.m
//  sina
//
//  Created by caoliang on 12-12-2.
//  Copyright (c) 2012年 caoliang. All rights reserved.
//

#import "BadgeView.h"

#define DEF_FONT_NAME @"Helvetica"
#define FONT_DEF_SIZE(s) [UIFont fontWithName:DEF_FONT_NAME size:s]

@implementation BadgeView
@synthesize setBadgeStyle;
@synthesize bgImg;
@synthesize numLab;

- (id)init{
    self = [super init];
    if (self) {
        self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badgeBg.png"]];
        self.bgImg.frame = CGRectMake(0, 0, 20, 20);
        [self addSubview:self.bgImg];
        
        self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, 20, 20)];
        self.numLab.backgroundColor = [UIColor clearColor];
        self.numLab.textColor = [UIColor whiteColor];
        self.numLab.font = FONT_DEF_SIZE(15);
        self.numLab.numberOfLines = 1;
        self.numLab.textAlignment = NSTextAlignmentCenter;
        self.numLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.numLab];
        
        self.hidden = YES;
    }
    return self;
}

-(void)setBadgeNum:(NSUInteger) numCount{
    if (self.setBadgeStyle) {
        self.setBadgeStyle();
    }
    self.hidden = NO;
 

    if (numCount >= 10 && numCount < 100) {
        [self.bgImg.image stretchableImageWithLeftCapWidth:15 topCapHeight:5];
        self.bgImg.frame = CGRectMake(-10, 0, self.bgImg.image.size.width + 10, self.bgImg.image.size.height+5);
        self.numLab.frame = self.bgImg.frame;
        self.numLab.text = [NSString stringWithFormat:@"%ld",(unsigned long)numCount];
    }else if(numCount == 0){
        self.hidden = YES;
    }else if(numCount > 99){
        [self.bgImg.image stretchableImageWithLeftCapWidth:15 topCapHeight:5];
        self.bgImg.frame = CGRectMake(-10, 0, self.bgImg.image.size.width + 10, self.bgImg.image.size.height+5);
        self.numLab.frame = self.bgImg.frame;
        self.numLab.text = @"99+";
    }else{
        self.numLab.text = [NSString stringWithFormat:@"%ld",(unsigned long)numCount];
    }
}
@end
