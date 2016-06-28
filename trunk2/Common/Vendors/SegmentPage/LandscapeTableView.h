//
//  GuGuLandscapeTableView.h
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentBarView.h"


@interface LandscapeTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
}
@property(nonatomic,retain)NSArray *cellDataSource;
- (void)reloadTableWithArray:(NSArray*)array;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array;
-(void)selectIndex:(int)index;
-(void)selectIndex:(int)index withAnimated:(BOOL) animated;

@property(nonatomic,unsafe_unretained)id<SegmentBarViewDelegate>swipeDelegate;
@end
