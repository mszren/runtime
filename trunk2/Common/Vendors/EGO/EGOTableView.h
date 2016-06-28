//
//  HomeViewController.h
//  qeebuConference
//
//  Created by caoliang on 13-1-29.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableHeaderView.h"
#import "MoreButtonView.h"



@protocol EGOTableViewDelegate <NSObject>
@required
- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView *)tableView;
@optional
//Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(EGOTableHeaderView *)tableView;
//Implement the follows to set date you want,Or Ignore them to use current date
- (NSDate *)pullingTableViewRefreshingFinishedDate;
- (NSDate *)pullingTableViewLoadingFinishedDate;
@end

@interface EGOTableView : UITableView <UIScrollViewDelegate>{
    EGOTableHeaderView *_headerView;
    EGOTableHeaderView *_footerView;
    UILabel *_msgLabel;
    BOOL _loading;
    BOOL _isFooterInAction;
    NSInteger _bottomRow;
}
@property (assign,nonatomic) id <EGOTableViewDelegate> pullingDelegate;
@property (nonatomic) BOOL autoScrollToNextPage;
@property (nonatomic) BOOL reachedTheEnd;
@property (nonatomic,getter = isHeaderOnly) BOOL headerOnly;
@property (nonatomic,getter = isFooterOnly) BOOL footerOnly;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;
- (void)tableViewDidFinishedLoading;
- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;
- (void)launchRefreshing;
- (void)hideFooterViewAndHeadView;
- (void)hideFooterViewAndHeadViewState;

//- (void)flashMessage:(NSString *)msg;
@end