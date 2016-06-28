//
// PagePhotosView.h
//  Common
//
//  Created by 曹亮 on 15/4/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"

@interface PagePhotosView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
    
	NSMutableArray *UIViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}

@property (nonatomic, assign) id<PagePhotosDataSource> dataSource;
@property (nonatomic, strong) NSMutableArray *UIViews;


- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)_dataSource;


@end
