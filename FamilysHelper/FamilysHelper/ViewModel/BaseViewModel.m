//
//  BaseViewModel.m
//  FamilysHelper
//
//  Created by 我 on 16/4/25.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)initWithViewController:(UIViewController*)viewContller
{
    self = [super init];
    if (self) {
        self.viewContller = viewContller;
    }
    return self;
}

@end
