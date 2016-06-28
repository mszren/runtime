//
//  AnimationUtils.h
//  Dolphin
//
//  Created by Jiaji Yin on 12/6/11.
//  Copyright (c) 2011 Bainainfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimationUtils : NSObject

+ (void)fadeInFromOpacity:(CGFloat)fromOpacity toOpacity:(CGFloat)toOpacity duration:(CGFloat)duration WithView:(UIView *)view;

+ (void)fadeOutFromOpacity:(CGFloat)fromOpacity toOpacity:(CGFloat)toOpacity duration:(CGFloat)duration WithView:(UIView *)view;

+ (void)moveFromPosition:(CGPoint)fromPoint toPosition:(CGPoint)toPoint duration:(CGFloat)duration withView:(UIView *)view;

+ (void)removeOnMoveFromPosition:(CGPoint)fromPoint 
					  toPosition:(CGPoint)toPoint 
						duration:(CGFloat)duration 
						withView:(UIView *)view;

+ (void)moveByHeight:(CGFloat)height withView:(UIView *)view animationId:(NSString *)animationId duration:(CGFloat)duration delegate:(id)delegate;


+ (CABasicAnimation*)getAnimationWithKeyPath:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue beginTime:(CGFloat)beginTime duration:(CGFloat)duration;

@end
