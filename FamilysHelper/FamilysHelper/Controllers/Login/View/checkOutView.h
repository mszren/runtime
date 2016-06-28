//
//  CehckPhoneView.h
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckOutViewDelegate <NSObject>

- (void)certainJump;

@end

@interface CheckOutView : NSObject
@property (nonatomic,weak) id<CheckOutViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UILabel *verticalLabel;

+ (instancetype)sharedInstance;

- (void)showCheckOutView:(NSString *)title andRemind:(NSString *)remind andDelegate:(id<CheckOutViewDelegate>)delegate;

@end
