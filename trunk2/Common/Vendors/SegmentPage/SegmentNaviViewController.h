//
//  GuGuSegmentNaviViewController.h
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBarView.h"
@interface SegmentNaviViewController : BaseViewController <SegmentBarViewDelegate> {
}
- (id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers;
- (id)initWithItems:(NSArray*)titleArray andControllers:(NSArray*)controllers withHideBar:(BOOL)isHide;
- (void)hideBarView;

- (void)selectedChangedIndex:(int)newIndex;
@end
