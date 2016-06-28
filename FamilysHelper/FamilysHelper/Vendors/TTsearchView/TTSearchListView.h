//
//  HouseSearchListView.h
//  BeruiHouse
//
//  Created by Ting on 16/4/28.
//  Copyright © 2016年 wangyueyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTSearchListView;

@protocol TTSearchListViewDataSource <NSObject>

@required

//各单位请注意,各单位请注意, row为左边行.item 为右边行. 怎么样
- (NSInteger)numberOfRow:(TTSearchListView *)menu;

- (NSString *)menu:(TTSearchListView *)menu titleOfRow:(NSInteger )row;

@optional

- (NSInteger)numberOfItem:(TTSearchListView *)menu
                      row:(NSInteger )row;

- (NSString *)menu:(TTSearchListView *)menu
       titleOfItem:(NSInteger )item
               row:(NSInteger )row;

@end

@protocol TTSearchListViewDelegate <NSObject>

- (void)menu:(TTSearchListView *)menu
didSelectRowAtItem:(NSInteger )item
         row:(NSInteger )row;


@end

@interface TTSearchListView : UIView

@property (nonatomic, weak) id <TTSearchListViewDataSource> dataSource;
@property (nonatomic, weak) id <TTSearchListViewDelegate> delegate;

- (instancetype)initWithHeight:(CGFloat)height singleTable:(BOOL )singleTable;

- (void)reloadData;

@end
