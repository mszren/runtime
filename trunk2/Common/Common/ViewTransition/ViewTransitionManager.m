//
//  ViewTransitionManager.m
//  Dolphin
//
//  Created by Jim Huang on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define FADE_DURATION 0.5

#import "ViewTransitionManager.h"
#import <QuartzCore/QuartzCore.h>

#define ANIMATION_KEY		@"ViewTransitionManagerAnimationKey"

@interface ViewTransitionManager (private)

-(void)addView:(UIView*)view animate:(BOOL)animate;
-(void)schduleAnimationFor:(UIView*)target from:(id)from to:(id)to delegate:(id)delegate;
-(void)removeView;
-(void)fadeInCurrentView;
-(UIView*)rootAncestorOfView:(UIView*)view;

+(id<ITransitionView>)toTransitionView:(id)view;

@end

@implementation ViewTransitionManager
@synthesize pushTransition, popTransition, disableFullScreenFade, delegate;

+(UIWindow*)getWindow
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if(!window)
    {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        if([windows count] > 0)
        {
            window = [windows objectAtIndex:0];
        }
    }
    
    return window;
}

static UIView* _disableInputView;

+(UIView*)disableInputView
{
    if(!_disableInputView)
    {
        _disableInputView = [[UIView alloc] init];
        _disableInputView.userInteractionEnabled = YES;
    }
    
    return _disableInputView;
}

+(void)disableUserInput
{
    UIWindow* window = [ViewTransitionManager getWindow];
    UIView* disableInputView = [ViewTransitionManager disableInputView];
    if(disableInputView.superview == nil)
    {
        disableInputView.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
        disableInputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [window addSubview:[ViewTransitionManager disableInputView]];
    }
}

+(void)enableUserInput
{
    [[ViewTransitionManager disableInputView] removeFromSuperview];
}

-(id)initWithRootView:(UIView*)view superView:(UIView*)superView
{
    self = [super init];
    if (self)
    {
        _currentView = view;
        _superView = superView;
        _nextView = nil;
        _state = NOT_ANIMATING;
        _context = nil;
        _subviewStack = [[NSMutableArray alloc] init];
        if (_currentView)
        {
            [_subviewStack addObject:_currentView];
        }
        
        id<ITransitionView> transitionView = [ViewTransitionManager toTransitionView:view];
        if([transitionView respondsToSelector:@selector(setViewTransitionManager:)])
        {
            [transitionView setViewTransitionManager:self];
        }
        
//        if([_currentView respondsToSelector:@selector(viewWillAppear:)])
//        {
//            [_currentView performSelector:@selector(viewWillAppear:) withObject:_context];
//        }
    }
    
    return self;
}

-(id)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self)
    {
        _superView = superView;
        _currentView = nil;
        _nextView = nil;
        _state = NOT_ANIMATING;
        _context = nil;
        _subviewStack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(UIView*)superview
{
    return _superView;
}

-(NSArray*)subViews
{
    return _subviewStack;
}

+(id<ITransitionView>)toTransitionView:(id)view
{
    if([view conformsToProtocol:@protocol(ITransitionView)])
    {
        return (id<ITransitionView>)view;
    }
    else
    {
        return nil;
    }
}

-(BOOL)isAnimating
{
    return _state != NOT_ANIMATING;
}

-(void)makeDefaultTransitions {
    CATransition* push = [CATransition animation];
	push.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    push.type = kCATransitionPush;
    push.subtype = kCATransitionFromRight;
    self.pushTransition = push;
    
    CATransition* pop = [CATransition animation];
    pop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pop.type = kCATransitionPush;
    pop.subtype = kCATransitionFromLeft;
    self.popTransition = pop;
}

-(void)pushView:(UIView*)view withAnimation:(BOOL)animate
{
    if([self isAnimating])
    {
        return;
    }
    
    [delegate viewWillChangeFrom:_currentView to:view];
    
    if(animate)
    {
        if (pushTransition) {
            [[self superview].layer addAnimation:pushTransition forKey:ANIMATION_KEY];
            [self addView:view animate:animate];
        }
        else {
            [ViewTransitionManager disableUserInput];
            
            if ([delegate respondsToSelector:@selector(viewDidStartAnimationPush)]) {
                [delegate viewDidStartAnimationPush];
            }
            
            _state = PUSH_FADE_OUT;
            [self schduleAnimationFor:[self rootAncestorOfView:_currentView] 
                                 from:[NSNumber numberWithInt:1]
                                   to:[NSNumber numberWithInt:0] 
                             delegate:self];
            _nextView = view;
            
            if ([_nextView respondsToSelector:@selector(fadeOutStarted)]) {
                [(id<ITransitionView>)_nextView fadeOutStarted];
            }
        }
    }
    else
    {
        [self addView:view animate:NO];
    }

}

-(void)popViewWithAnimation:(BOOL)animate withContext:(id)context
{
    if([self isAnimating])
    {
        return;
    }
    
    _context = context;
    
    NSAssert([_subviewStack count] > 0, @"Should have at least 1 view before pop");
    id toView = ([_subviewStack count] >= 2 ? [_subviewStack objectAtIndex:[_subviewStack count]-2] : nil);
    [delegate viewWillChangeFrom:_currentView to:toView];
    
    if(animate)
    {
        if (popTransition) {
            [self removeView];
            [[self superview].layer addAnimation:popTransition forKey:ANIMATION_KEY];
        }
        else {
            [ViewTransitionManager disableUserInput];
            
            if ([delegate respondsToSelector:@selector(viewDidStartAnimationPop)]) {
                [delegate viewDidStartAnimationPop];
            }
            
            _state = POP_FADE_OUT;
            
            [self schduleAnimationFor:[self rootAncestorOfView:_currentView]
                                 from:[NSNumber numberWithInt:1]
                                   to:[NSNumber numberWithInt:0]
                             delegate:self];
            
            if ([_currentView respondsToSelector:@selector(fadeOutStarted)]) {
                [(id<ITransitionView>)_currentView fadeOutStarted];
            }
        }
    }
    else
    {
        [self removeView];
        [[self rootAncestorOfView:_currentView].layer removeAllAnimations];
        _currentView.hidden = NO;
    }            
}

-(void)popViewWithAnimation:(BOOL)animate
{
    [self popViewWithAnimation:animate withContext:nil];
}

-(UIView*)currentView
{
    return _currentView;
}

-(UIView*)showingView
{
    if(_state == PUSH_FADE_OUT)
    {
        return _nextView;
    }
    else if(_state == POP_FADE_OUT)
    {
        NSAssert([_subviewStack count] > 0, @"Should at least 1 subview before popup");
        return ([_subviewStack count] >= 2 ? [_subviewStack objectAtIndex:[_subviewStack count]-2] : nil);
    }
    else
    {
        return _currentView;
    }
}

-(void)schduleAnimationFor:(UIView*)target from:(id)from to:(id)to delegate:(id)theDelegate
{
    CABasicAnimation* fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.delegate = theDelegate;
    fadeOutAnimation.fromValue = from;
    fadeOutAnimation.toValue = to;
    fadeOutAnimation.duration = FADE_DURATION;
    fadeOutAnimation.removedOnCompletion = NO;
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    [[target layer] addAnimation:fadeOutAnimation forKey:ANIMATION_KEY];
}

-(void)addView:(UIView*)view animate:(BOOL)animate
{
    view.frame = CGRectMake(0, 0, [self superview].frame.size.width, [self superview].frame.size.height);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if([view respondsToSelector:@selector(viewWillBeAdd)])
    {
        [view performSelector:@selector(viewWillBeAdd)];
    }
	
	if ([_currentView respondsToSelector:@selector(viewWillDisAppear:)])
	{
		[_currentView performSelector:@selector(viewWillDisAppear:) withObject:nil];
	}
	
    [[self superview] addSubview:view];
    _currentView = view;
    [_subviewStack addObject:view];
    
    if([view respondsToSelector:@selector(viewAdded)])
    {
        [view performSelector:@selector(viewAdded)];
    }
    
//    if([view respondsToSelector:@selector(viewWillAppear:)])
//    {
//        [view performSelector:@selector(viewWillAppear:) withObject:_context];
//    }
    
    id<ITransitionView> transitionView = [ViewTransitionManager toTransitionView:view];
    if([transitionView respondsToSelector:@selector(setViewTransitionManager:)])
    {
        [transitionView setViewTransitionManager:self];
    }
    
    if(animate && pushTransition == nil)
    {
        [self fadeInCurrentView];
    }
}

-(void)removeView
{
    if([_currentView respondsToSelector:@selector(viewWillBeRemove)])
    {
        [_currentView performSelector:@selector(viewWillBeRemove)];
    }
    
    id<ITransitionView> transitionView = [ViewTransitionManager toTransitionView:_currentView];
    if([transitionView respondsToSelector:@selector(setViewTransitionManager:)])
    {
        [transitionView setViewTransitionManager:nil];
    }
	
	if ([_currentView respondsToSelector:@selector(viewWillDisAppear:)])
	{
		[_currentView performSelector:@selector(viewWillDisAppear:) withObject:nil];
	}
	
    [_currentView removeFromSuperview];
    [_subviewStack removeObject:_currentView];
    _currentView = [_subviewStack lastObject];
    
//    if([_currentView respondsToSelector:@selector(viewWillAppear:)])
//    {
//        [_currentView performSelector:@selector(viewWillAppear:) withObject:_context];
//    }
}

-(UIView*)rootAncestorOfView:(UIView*)view {
    if (self.disableFullScreenFade) {
        return view;
    }
    
    UIView* rootView = view;
    while(rootView != nil) {
        UIView* parent = [rootView superview];
        if ([parent isKindOfClass:[UIWindow class]]) {
            break;
        }
        
        rootView = parent;
    }
    
    return rootView;
}

-(void)fadeInCurrentView
{
    [self schduleAnimationFor:[self rootAncestorOfView:_currentView] from:[NSNumber numberWithInt:0]
                           to:[NSNumber numberWithInt:1]
                     delegate:self];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	[[self rootAncestorOfView:_currentView].layer removeAnimationForKey:ANIMATION_KEY];
    if(_state == PUSH_FADE_OUT)
    {
        if ([_currentView respondsToSelector:@selector(fadeOutCompleted)]) {
            [(id<ITransitionView>)_currentView fadeOutCompleted];
        }
        _currentView.hidden = YES;
        // PUSH View, previous view finished fade out, animate in _nextView.
        [self addView:_nextView animate:YES];
        _state = PUSH_FADE_IN;
        
        if ([_nextView respondsToSelector:@selector(fadeInStarted)]) {
            [(id<ITransitionView>)_nextView fadeInStarted];
        }
        _nextView = nil;
    }
    else if (_state == PUSH_FADE_IN)
    {
        // PUSH view finished, current view finished fade in.
        [ViewTransitionManager enableUserInput];
        _state = NOT_ANIMATING;
        
        if ([_currentView respondsToSelector:@selector(fadeInCompleted)]) {
            [(id<ITransitionView>)_currentView fadeInCompleted];
        }
        if ([delegate respondsToSelector:@selector(viewDidEndAnimationPush)]) {
            [delegate viewDidEndAnimationPush];
        }
	}
    else if (_state == POP_FADE_OUT)
    {
        
        if ([_currentView respondsToSelector:@selector(fadeOutCompleted)]) {
            [(id<ITransitionView>)_currentView fadeOutCompleted];
        }
        
        [self removeView];
        [self fadeInCurrentView];
        _state = POP_FADE_IN;

        _currentView.hidden = NO;
        if ([_currentView respondsToSelector:@selector(fadeInStarted)]) {
            [(id<ITransitionView>)_currentView fadeInStarted];
        }
    }
    else if (_state == POP_FADE_IN)
    {
        // POP View finished, previous view finished fade in.
        [ViewTransitionManager enableUserInput];
        _state = NOT_ANIMATING;
        
        if ([_currentView respondsToSelector:@selector(fadeInCompleted)]) {
            [(id<ITransitionView>)_currentView fadeInCompleted];
        }
        if ([delegate respondsToSelector:@selector(viewDidEndAnimationPop)]) {
            [delegate viewDidEndAnimationPop];
        }
    }
}

#pragma mark IAnimationHost

-(void)addAnimationView:(UIView*)animationView
{
    [self pushView:animationView withAnimation:NO];
}

-(void)removeAnimationView:(UIView*)animationView
{
    NSAssert(_currentView == animationView, @"current view is not animation view when remove animationView");
    [self popViewWithAnimation:NO];
}



@end
