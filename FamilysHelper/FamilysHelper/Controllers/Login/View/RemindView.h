//
//  RemindView.h
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindView : NSObject
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UILabel *verticalLabel;

+ (instancetype)sharedInstance;

- (void)showRemindView:(NSString *)title;

@end
