//
//  AnimationUtils.m
//  Dolphin
//
//  Created by Jiaji Yin on 12/6/11.
//  Copyright (c) 2011 Bainainfo. All rights reserved.
//

#import "AnimationUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationUtils

+ (void)fadeInFromOpacity:(CGFloat)fromOpacity toOpacity:(CGFloat)toOpacity duration:(CGFloat)duration WithView:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = [NSNumber numberWithFloat:toOpacity];
    animation.fromValue = [NSNumber numberWithFloat:fromOpacity];
    animation.duration = duration;
    view.layer.opacity = 1.0; // This is required to update the model's value.  Comment out to see what happens.
    [view.layer addAnimation:animation forKey:@"animateOpacity"];
}

+ (void)fadeOutFromOpacity:(CGFloat)fromOpacity toOpacity:(CGFloat)toOpacity duration:(CGFloat)duration WithView:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = [NSNumber numberWithFloat:toOpacity];
    animation.fromValue = [NSNumber numberWithFloat:fromOpacity];
    animation.duration = duration;
    view.layer.opacity = 0.0; // This is required to update the model's value.  Comment out to see what happens.
    [view.layer addAnimation:animation forKey:@"animateOpacity"];
}

+ (void)moveFromPosition:(CGPoint)fromPoint toPosition:(CGPoint)toPoint duration:(CGFloat)duration withView:(UIView *)view
{
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + (toPoint.x - fromPoint.x), view.center.y + (toPoint.y - fromPoint.y));	
    }];
}

+ (void)removeOnMoveFromPosition:(CGPoint)fromPoint 
					  toPosition:(CGPoint)toPoint 
						duration:(CGFloat)duration 
						withView:(UIView *)view 
{
    [UIView animateWithDuration:duration 
					 animations:^{
						 view.center = CGPointMake(view.center.x + (toPoint.x - fromPoint.x), view.center.y + (toPoint.y - fromPoint.y));	
					 }
					 completion:^(BOOL finished){
						 [view removeFromSuperview];
					 }
	 ];
}


+ (void)moveByHeight:(CGFloat)height withView:(UIView *)view animationId:(NSString *)animationId duration:(CGFloat)duration delegate:(id)delegate
{
    [UIView beginAnimations:animationId context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:delegate];
    view.center = CGPointMake(view.center.x, view.center.y + height);
    [UIView commitAnimations];
}

+ (CABasicAnimation*)getAnimationWithKeyPath:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue beginTime:(CGFloat)beginTime duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.beginTime = beginTime;
    animation.duration = duration;
    return animation;
}

@end
