//
//  UIGestureRecognizer+TargetsAccessable.h
//  Dolphin
//
//  Created by Hongliang Li on 10/20/11.
//  Copyright (c) 2011 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    id class;
    id target;
    SEL action;
}MyTargetAction;

@interface UIGestureRecognizer (TargetsAccessable)

-(void)getTargetAction:(MyTargetAction*)pPair atIndex:(int)index;

@end
