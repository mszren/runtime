//
//  AddressBookNumsView.m
//  qeebuConference
//
//  Created by caoliang on 13-10-25.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import "AddressBookNumsView.h"

@implementation AddressBookNumsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void) setViewDefault{
    iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"persionIcon.png"]];
    [self addSubview:iconImg];
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(iconImg.frame.origin.x + iconImg.frame.size.width+3, 7, 36, 20)];
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.font = FONT_SIZE(16);
    nameLab.text = @"全部";
    [self addSubview:nameLab];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.frame.origin.x + nameLab.frame.size.width, 6, 70, 20)];
    numLab.font = FONT_SIZE(16);
    numLab.textColor = [UIColor redColor];
    numLab.backgroundColor = [UIColor clearColor];
    [self addSubview:numLab];
}

- (void) setNameLabText:(NSString *) nameLabText withNumLabText:(NSString *) numText{
    nameLab.text = nameLabText;
    numLab.text = numText;
}

@end
