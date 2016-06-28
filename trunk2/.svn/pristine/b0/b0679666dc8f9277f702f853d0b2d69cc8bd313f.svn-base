//
//  ActionHandlerBase.h
//  Common
//
//  Created by Owen on 15/7/7.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionHandlerBase : NSObject {
  NSDictionary *_actionDictionary;
  UIViewController *_viewController;
}
- (NSValue *)wrapSelector:(SEL)action;
- (NSDictionary *)actionDictionary;
- (void)excuteAction:(NSString *)actionString context:(id)context;
@end
