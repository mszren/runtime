//
//  MessageRoutable.h
//  Dolphin
//
//  Created by Li Hongliang on 5/17/11.
//  Copyright 2011 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

// Any custom view can implement this protocol, so that parent view or chid
// view's can receive its unhandled message.
@protocol MessageRoutable <NSObject>
@optional
- (void)RouteMessage:(NSString *)message withContext:(id)context;

@optional
@property(nonatomic, assign) id messageListner;
@end

// For those views who are not interested in the message but want to pass
// through message to parent.
// The last else if ([self isKindOfClass:[UIView class]]) is to jump parent view
// to find MessageRoutable view.
#define IMPLEMENT_MESSAGE_ROUTABLE                                             \
  -(void)RouteMessage : (NSString *)message withContext : (id)context {        \
    if ([self isKindOfClass:[UIView class]] &&                                 \
        [(UIView *)self superview] != nil &&                                   \
        [[(UIView *)self superview]                                            \
            conformsToProtocol:@protocol(MessageRoutable)]) {                  \
      [(id<MessageRoutable>)[(UIView *)self superview] RouteMessage:message    \
                                                        withContext:context];  \
    } else if ([self respondsToSelector:@selector(messageListner)] &&          \
               self.messageListner &&                                          \
               [[self messageListner]                                          \
                   conformsToProtocol:@protocol(MessageRoutable)]) {           \
      [[self messageListner] RouteMessage:message withContext:context];        \
    } else if ([self isKindOfClass:[UIView class]]) {                          \
      UIView *superView = [(UIView *)self superview];                          \
      while (superView) {                                                      \
        if ([superView conformsToProtocol:@protocol(MessageRoutable)]) {       \
          break;                                                               \
        }                                                                      \
        superView = [superView superview];                                     \
      }                                                                        \
      if (superView) {                                                         \
        [(id<MessageRoutable>)superView RouteMessage:message                   \
                                         withContext:context];                 \
      }                                                                        \
    }                                                                          \
  }
