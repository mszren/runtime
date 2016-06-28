//
//  Globals.m
//  Dolphin
//
//  Created by Jim Huang on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"


@implementation Globals

static UIView* _rootView;
static UIViewController* _rootViewController;
static ViewTransitionManager* _transitionManager;

+(UIView*)rootView
{
    return _rootView;
}

+(void)setRootView:(UIView*)view
{
    _rootView = view;
}

+(UIViewController*)rootViewController
{
    return _rootViewController;
}

+(void)setRootViewController:(UIViewController*)viewController
{
    _rootViewController = viewController;
}

+(void)setViewTransitionManager:(ViewTransitionManager*)manager
{
    _transitionManager = manager;
}

+(ViewTransitionManager*)viewTransitionManager
{
    NSAssert(_transitionManager!=nil, @"_transitionManager should not be nil");
    return _transitionManager;
}

@end
