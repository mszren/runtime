//
//  HomeViewController.h
//  qeebuConference
//
//  Created by caoliang on 13-1-29.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//


#import "EGOTableHeaderView.h"

#define kPROffsetY 60.f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 38.f
#define kPRArrowHeight 38.f

#define kTextColor [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define kPRBGColor [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:0.0]
#define kPRAnimationDuration 0.3f

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.1f

#define SOUNDSWITCH_KEY   @"SoundSwitch"

@interface EGOTableHeaderView()
- (void)layouts;
@end

@implementation EGOTableHeaderView
@synthesize atTop = _atTop;
@synthesize state = _state;
@synthesize loading = _loading;

#pragma mark -
#pragma mark Initialization and teardown
- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top {
    self = [super initWithFrame:frame];
    if (self) {
        self.atTop = top;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = kPRBGColor;
        _stateLabel = [[UILabel alloc] init ];
        _stateLabel.font = FONT_SIZE(12.0f);
        _stateLabel.textColor = kTextColor;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = kPRBGColor;
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _stateLabel.text = Refresh_Therefresh;
        [self addSubview:_stateLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT_SIZE(12.0f);
        _dateLabel.textColor = kTextColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.backgroundColor = kPRBGColor;
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_dateLabel];
        
        _arrow = [CALayer layer];
        _arrow.contentsGravity = kCAGravityResizeAspect;
        _arrow.contents = (id)[UIImage imageWithCGImage:[UIImage imageNamed:@"blueArrow.png"].CGImage scale:1 orientation:UIImageOrientationDown].CGImage;
        [self.layer addSublayer:_arrow];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];

        [self layouts];
    }
    return self;
}
- (void) setArrowHide{
    [_arrow removeFromSuperlayer];
}
#pragma mark -
#pragma mark 每个UI控件的布局
- (void)layouts {
    CGSize size = self.frame.size;
    CGRect stateFrame,dateFrame,arrowFrame;
    
    float x = 0,y,margin;
    margin = (kPROffsetY - 2*kPRLabelHeight)/2;
    if (self.isAtTop) {
        y = size.height - margin - kPRLabelHeight;
        dateFrame = CGRectMake(0,y,size.width,kPRLabelHeight);
        
        y = y - kPRLabelHeight;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = size.height - margin - kPRArrowHeight;
        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        
        UIImage *arrow = [UIImage imageNamed:@"blueArrow.png"];
        _arrow.contents = (id)arrow.CGImage;
    } else {    //at bottom
        y = margin;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight );
        
        y = y + kPRLabelHeight;
        dateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = margin;
        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        
        UIImage *arrow = [UIImage imageNamed:@"blueArrow.png"];
        _arrow.contents = (id)arrow.CGImage;
        _stateLabel.text = Refresh_Pull_up_loading_more;
    }
    _stateLabel.frame = stateFrame;
    _dateLabel.frame = dateFrame;
    _arrow.frame = arrowFrame;
    _activityView.frame = arrowFrame;
    _arrow.transform = CATransform3DIdentity;
}
- (void)setState:(PRState)state {
    [self setState:state animated:YES];
}
- (void)setState:(PRState)state animated:(BOOL)animated{
    float duration = animated ? kPRAnimationDuration : 0.0f;
    if (_state != state) {
        _state = state;
        if (_state == kPRStateLoading) {    //Loading
            _arrow.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            _loading = YES;
            if (self.isAtTop) {
                _stateLabel.text = Refresh_Refreshing;
            } else {
                _stateLabel.text = Refresh_Loading;
            }
        } else if (_state == kPRStatePulling && !_loading) {    //Scrolling
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];

            [UIView animateWithDuration:duration animations:^{
                _arrow.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            }];
            if (self.isAtTop) {
                _stateLabel.text = Refresh_Release_refresh;
            } else {
                _stateLabel.text = Refresh_Release_load_more;
            }
        } else if (_state == kPRStateNormal && !_loading){    //Reset
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [UIView animateWithDuration:duration animations:^{
                _arrow.transform = CATransform3DIdentity;
            }];
            
            if (self.isAtTop) {
                _stateLabel.text = Refresh_Therefresh;
            } else {
                _stateLabel.text = Refresh_Pull_up_loading_more;
            }
        } else if (_state == kPRStateHitTheEnd) {
            if (!self.isAtTop) {    //footer
                _arrow.hidden = YES;
                [_activityView stopAnimating];
                _stateLabel.text = Refresh_No_oh;
            }
        }
    }
}

-(void) setStateNull{
    _stateLabel.text = @"";
    _dateLabel.text  = @"";
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
}
- (void)updateRefreshDate :(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [df stringFromDate:date];
    NSString *title = Refresh_Today;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:date toDate:[NSDate date] options:0];
    NSUInteger year = [components year];
    NSUInteger month = [components month];
    NSUInteger day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            title = Refresh_Today;
        } else if (day == 1) {
            title = Refresh_Yesterday;
        } else if (day == 2) {
            title = Refresh_The_day_before_yesterday;
        }
        df.dateFormat = @"HH:mm";
        dateString = [df stringFromDate:date];
        
    }
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@ %@",Refresh_Last_update,title,dateString];
}

@end
