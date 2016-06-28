//
//  ActionHandlerBase.m
//  Common
//
//  Created by Owen on 15/7/7.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ActionHandlerBase.h"
#import "ActionConfig.h"

@implementation ActionHandlerBase
- (NSValue*)wrapSelector:(SEL)action
{
    return [NSValue valueWithPointer:action];
}

- (SEL)getSelector:(NSValue*)actionValue
{
    return [actionValue pointerValue];
}

#pragma mark -
- (NSDictionary*)actionDictionary
{
    if (_actionDictionary == nil) {

        _actionDictionary = [NSDictionary dictionaryWithObjectsAndKeys:nil];
    }
    return _actionDictionary;
}

- (void)excuteAction:(NSString*)actionString context:(id)context
{
    SEL action =
        [self getSelector:[[self actionDictionary] objectForKey:actionString]];
    if (action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:action
                   withObject:context];
#pragma clang diagnostic pop
    }
}

@end
