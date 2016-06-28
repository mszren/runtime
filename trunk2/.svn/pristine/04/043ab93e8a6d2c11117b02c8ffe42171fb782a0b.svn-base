//
//  MoreButtonView.h
//  HuobanWeibo
//
//  Created by caoliang on 13-1-29.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreButtonView;

@protocol MoreButtonViewDelegate <NSObject>
@required
- (void)egoRefreshTableHeaderDidTriggerRefresh;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading;
@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated;
@end

@interface MoreButtonView : UIView {
    UILabel *_stateLabel;
    UILabel *_dateLabel;
    UIActivityIndicatorView *_activityView;
    CALayer *_arrow;
    BOOL _loading;
}
@property (nonatomic,getter = isLoading) BOOL loading;
@property (nonatomic,getter = isAtTop) BOOL atTop;
@property (nonatomic) PRState state;

- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;

- (void)updateRefreshDate:(NSDate *)date;
- (void)setState:(PRState)state animated:(BOOL)animated;
@end
