//
//  IAnimationHost.h
//  Dolphin
//
//  Created by Jim Huang on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IAnimationHost <NSObject>

-(void)addAnimationView:(UIView*)animationView;
-(void)removeAnimationView:(UIView*)animationView;

@end
