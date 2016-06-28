//
//  BadgeView.h
//  sina
//
//  Created by caoliang on 12-12-2.
//  Copyright (c) 2012年 caoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! @brief 角标，个位数为圆形，两位数为椭圆
 *
 *使用方法
 *BadgeView * badge = [[BadgeView alloc] init];
 *badge.frame = CGRectMake(120, 23, 50, 50);
 *[badge setBadgeNum:2];
 */

@interface BadgeView : UIView{

}
@property(nonatomic,strong) void (^setBadgeStyle)();
@property(nonatomic,strong) UIImageView * bgImg;
@property(nonatomic,strong) UILabel * numLab;

-(void)setBadgeNum:(NSUInteger) numCount;

@end
