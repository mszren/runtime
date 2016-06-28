//
//  HomeViewController.h
//  qeebuConference
//
//  Created by caoliang on 13-1-29.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import "EGOTableView.h"
#import "FileCache.h"


#define kPROffsetY 60.f
#define kBottomOffsetY 60.0f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 38.f
#define kPRArrowHeight 38.f

#define kPRAnimationDuration 0.15f

#define PAGE_SIZE_WEIBO 2

@interface EGOTableView (privateMethod)
- (void)scrollToNextPage;
@end

@implementation EGOTableView
@synthesize pullingDelegate = _pullingDelegate;
@synthesize autoScrollToNextPage;
@synthesize reachedTheEnd = _reachedTheEnd;
@synthesize headerOnly = _headerOnly;

#pragma mark -
#pragma mark Initialization and teardown
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        CGRect rect = CGRectMake(0, 0 - frame.size.height, frame.size.width, frame.size.height);
        _headerView = [[EGOTableHeaderView alloc] initWithFrame:rect atTop:YES];
        _headerView.atTop = YES;
        [self addSubview:_headerView];
        
        _footerView = [[EGOTableHeaderView alloc] initWithFrame:CGRectMake(0, -10, 320, 60) atTop:NO];
        _footerView.atTop = NO;
        [_footerView setArrowHide];
        self.tableFooterView = _footerView;
        
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

 
- (void)setReachedTheEnd:(BOOL)reachedTheEnd{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd){
        _footerView.state = kPRStateHitTheEnd;
    } else {
        _footerView.state = kPRStateNormal;
    }
}

- (void)setHeaderOnly:(BOOL)headerOnly{
    _headerOnly = headerOnly;
    _footerView.hidden = _headerOnly;
}

-(void) setFooterOnly:(BOOL)footerOnly{
    _footerOnly = footerOnly;
    _headerView.hidden = _footerOnly;
}
#pragma mark - Scroll methods
- (void)scrollToNextPage {
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;

    [UIView animateWithDuration:0.7f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.contentOffset = CGPointMake(0, y);
                     }completion:^(BOOL bl){
                         
                     }];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
    
    float yMargin = offset.y + size.height - contentSize.height;
    if (offset.y < -kPROffsetY) {   //header totally appeard
        _headerView.state = kPRStatePulling;
    } else if (offset.y > -kPROffsetY && offset.y < 0){ //header part appeared
        _headerView.state = kPRStateNormal;
    } else if ( yMargin > kPROffsetY){  //footer totally appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStatePulling;
        }
    } else if ( yMargin < kPROffsetY && yMargin > 0) {//footer part appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStateNormal;
        }
    }
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView {
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    if (_headerView.state == kPRStatePulling) {
        _isFooterInAction = NO;
        _headerView.state = kPRStateLoading;
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(kPROffsetY, 0, 0, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing:)]) {
            [_pullingDelegate pullingTableViewDidStartRefreshing:_headerView];
        }
    } else if (_footerView.state == kPRStatePulling) {
        if (self.reachedTheEnd || self.headerOnly) {
            return;
        }
        _isFooterInAction = YES;
        _footerView.state = kPRStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, kBottomOffsetY, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoading:)]) {
            [_pullingDelegate pullingTableViewDidStartLoading:_footerView];
        }
    }
}

- (void)tableViewDidFinishedLoading {
    [self tableViewDidFinishedLoadingWithMessage:nil];
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg{
    if (_headerView.loading) {
        _headerView.loading = NO;
        [_headerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewRefreshingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_headerView updateRefreshDate:date];
        [UIView animateWithDuration:kPRAnimationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
    else if (_footerView.loading) {
        _footerView.loading = NO;
        [_footerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewLoadingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_footerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
}

#pragma mark -
#pragma mark 显示提示信息
- (void)flashMessage:(NSString *)msg{
//    __block CGRect rect = CGRectMake(0, self.contentOffset.y - 32, self.bounds.size.width, 32);
//    
//    if (_msgLabel == nil) {
//        _msgLabel = [[UILabel alloc] init];
//        _msgLabel.frame = rect;
//        _msgLabel.font = [UIFont systemFontOfSize:18.f];
//        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _msgLabel.backgroundColor = [UIColor blueColor];
//        _msgLabel.textAlignment = UITextAlignmentCenter;
//        [self addSubview:_msgLabel];
//    }
//    _msgLabel.text = msg;
//    
//    rect.origin.y += 32;
//    [UIView animateWithDuration:.4f animations:^{
//        _msgLabel.frame = rect;
//    } completion:^(BOOL finished){
//        rect.origin.y -= 32;
//        [UIView animateWithDuration:.4f delay:1.2f options:UIViewAnimationOptionCurveLinear animations:^{
//            _msgLabel.frame = rect;
//        } completion:^(BOOL finished){
//            [_msgLabel removeFromSuperview];
//            _msgLabel = nil;
//        }];
//    }];
}

- (void)launchRefreshing {
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:kPRAnimationDuration animations:^{
        self.contentOffset = CGPointMake(0, -kPROffsetY-1);
    } completion:^(BOOL finished){
        [self tableViewDidEndDragging:self];
    }];
}
-(void) hideFooterViewAndHeadView{
    _footerView.hidden =YES;
    _headerView.hidden =YES;
}

- (void)hideFooterViewAndHeadViewState{
    [_footerView setStateNull];
    [_headerView setStateNull];
}

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGRect frame = _footerView.frame;
    CGSize contentSize = self.contentSize;
    frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height  : contentSize.height;
    _footerView.frame = frame;
    if (self.autoScrollToNextPage && _isFooterInAction) {
        [self scrollToNextPage];
        _isFooterInAction = NO;
    } else if (_isFooterInAction) {
        CGPoint offset = self.contentOffset;
        offset.y += 44.f;
        self.contentOffset = offset;
    }
}
@end

