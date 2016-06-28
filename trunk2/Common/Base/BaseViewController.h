//
//  BaseViewController.h
//  ipadConference
//
//  Created by caoliang on 13-5-20.
//  Copyright (c) 2013年 caoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageRoutable.h"

@interface BaseViewController : UIViewController <MessageRoutable> {
    UIButton* _inviteBtn;
}
- (void)initializeNavTitleView:(NSString*)titileStr;
- (void)initializeNavBackView;

- (void)initializeWhiteBackgroudView:(NSString*)titileStr;

- (void)setRedNavBg;
- (void)setWhiteNavBg;
- (void)setLeftPersonAction;
- (void)setCleanNavBg;

- (void)setBackToRoot:(BOOL)iToRoot;
@end
