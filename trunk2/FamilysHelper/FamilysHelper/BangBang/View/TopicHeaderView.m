//
//  TopicHeaderView.m
//  FamilysHelper
//
//  Created by Owen on 15/7/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TopicHeaderView.h"

@interface TopicHeaderView () {
    UILabel* _labelTitle;
}

@end
@implementation TopicHeaderView
- (instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 33)];
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        [_labelTitle setFont:FONT_SIZE_15];
        [_labelTitle setTextColor:TableCellDescColor];
        [self addSubview:_labelTitle];
    }

    return self;
}

- (void)bindHeader:(NSInteger)num
{
    _labelTitle.text = [NSString stringWithFormat:@"已关注%ld个话题", (long)num];
}
@end
