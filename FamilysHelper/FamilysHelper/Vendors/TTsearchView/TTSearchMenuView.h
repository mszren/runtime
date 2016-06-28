//
//  HouseSearchMenuView.h
//  BeruiHouse
//
//  Created by Ting on 16/4/26.
//  Copyright © 2016年 wangyueyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSearchMenuView : UIView
 
- (instancetype)initWithOrigin:(CGPoint)origin
                        height:(CGFloat)height;

- (void)setString:(NSString *)titleStr
         atIndex:(NSInteger)index;

- (void)dismiss;

- (void)reloadData;

@end
