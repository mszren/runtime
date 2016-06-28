//
//  UIGestureRecognizer+TargetsAccessable.m
//  Dolphin
//
//  Created by Hongliang Li on 10/20/11.
//  Copyright (c) 2011 Microsoft. All rights reserved.
//

#import "UIGestureRecognizer+TargetsAccessable.h"

typedef struct {
    id class;
    NSMutableArray* actionTargets;
}GestureStruct;

@implementation UIGestureRecognizer (TargetsAccessable)

-(void)getTargetAction:(MyTargetAction*)pPair atIndex:(int)index {
    GestureStruct* this = (GestureStruct*)self;
    if ([this->actionTargets count] > index) {
        MyTargetAction* targetAction = (MyTargetAction*)[this->actionTargets objectAtIndex:index];
        if (pPair) {
            // Copy the result
            *pPair = *targetAction;
        }
    }
}

@end
