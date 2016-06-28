//
//  ViewTransitionManager.h
//  WebzineDemo
//
//  Created by Jim Huang on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  This class manages Views transition inside a view controller.

#import <Foundation/Foundation.h>
#import "IAnimationHost.h"
#import <QuartzCore/QuartzCore.h>

@class ViewTransitionManager;

typedef enum
{
    NOT_ANIMATING,
    PUSH_FADE_OUT,    // Previous view is fading out when push view.
    PUSH_FADE_IN,     // Current view is fading in when push view.
    POP_FADE_OUT,     // Current view is fading out when pop view.
    POP_FADE_IN       // Previous view is fading in when pop view.
}ViewTransitionState;

@protocol ViewTransitionDelegate <NSObject>

// Will get called when the current view will change. Either triggered by pop or push.
-(void)viewWillChangeFrom:(id)from to:(id)to;

@optional
-(void)viewDidStartAnimationPush;
-(void)viewDidEndAnimationPush;

-(void)viewDidStartAnimationPop;
-(void)viewDidEndAnimationPop;

@end

@protocol ITransitionView <NSObject>

@optional

-(void)viewWillBeAdd;

-(void)viewAdded;

-(void)viewWillBeRemove;

-(void)fadeOutStarted;

-(void)fadeOutCompleted;

-(void)fadeInStarted;

-(void)fadeInCompleted;

// Called everytime that view will comes to front.
-(void)viewWillAppear:(id)withContext;
- (void)viewWillDisAppear:(id)withContext;

@property (nonatomic, assign) ViewTransitionManager* viewTransitionManager;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIButton* leftButton;

@end

@interface ViewTransitionManager : NSObject <IAnimationHost>
{
    UIViewController* _viewController;
    
    ViewTransitionState _state;
    
    UIView* _currentView;
    
    UIView* _nextView;    // The view is going to be pushed in.
    
    UIView* _superView;
    
    NSMutableArray* _subviewStack;
    
    id _context;
    
}

@property (nonatomic, retain) CATransition* pushTransition;
@property (nonatomic, retain) CATransition* popTransition;
@property (nonatomic, assign) BOOL disableFullScreenFade;

@property (nonatomic, assign) id<ViewTransitionDelegate> delegate;

-(void)makeDefaultTransitions;

-(id)initWithRootView:(UIView*)view superView:(UIView*)superView;

-(id)initWithSuperView:(UIView *)superView;

-(void)pushView:(UIView*)view withAnimation:(BOOL)animate;

-(void)popViewWithAnimation:(BOOL)animate withContext:(id)context;

-(void)popViewWithAnimation:(BOOL)animate;

-(UIView*)superview;   // The superview that contains all the managed views.

-(UIView*)currentView;

// It's different with currentView when pop/push with fade in/out effect.
// showingView is the view is going to be shown. 
// e.g. When pop out current view with fade out, the showing view is the view 
// will be shown after current view fade out.
-(UIView*)showingView;

-(NSArray*)subViews;  // All the managed views.

// Whether the we are in view transition animating state.
-(BOOL)isAnimating;

@end
