//
//  profitView.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ProfitCell.h"
#import "IndexService.h"
#import "ActivityViewController.h"
#import "RecommendViewController.h"
#import "ShareViewController.h"
#import "InviteViewController.h"

@implementation ProfitCell
@synthesize messageListner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* profitView =
            [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 83)];
        profitView.backgroundColor = [UIColor whiteColor];
        [self addSubview:profitView];

        NSArray* nameArry = @[ @"邀友赚", @"活动赚", @"推荐赚", @"分享赚" ];
        NSArray* imageArry =
            @[ @"btn_invite", @"btn_active", @"btn_groom", @"btn_share" ];
        for (NSInteger i = 0; i < imageArry.count; i++) {
            UIButton* profitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            profitButton.frame = CGRectMake(20 + SCREEN_WIDTH / 4 * i, 11, 40, 40);
            profitButton.layer.cornerRadius = 20;
            profitButton.clipsToBounds = YES;
            profitButton.tag = 300 + i;
            [profitButton setImage:[UIImage imageNamed:imageArry[i]]
                          forState:UIControlStateNormal];
            [profitButton addTarget:self
                             action:@selector(onBtnProfit:)
                   forControlEvents:UIControlEventTouchUpInside];
            [profitView addSubview:profitButton];

            UILabel* nameLabel = [[UILabel alloc]
                initWithFrame:CGRectMake(20 + SCREEN_WIDTH / 4 * i, 57, 40, 15)];
            nameLabel.text = nameArry[i];
            nameLabel.font = [UIFont systemFontOfSize:12];
            nameLabel.textColor = COLOR_GRAY_DEFAULT_30;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [profitView addSubview:nameLabel];
        }
    }
    return self;
}

//按钮点击事件
- (void)onBtnProfit:(UIButton*)sender
{
    if (sender.tag == 300) {

        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];

        [messageListner RouteMessage:ACTION_SHOW_SYSTEM_INVITE
                         withContext:dic];
    }
    else if (sender.tag == 301) {
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];
        [messageListner RouteMessage:ACTION_SHOW_SYSTEM_ACTIVITY
                         withContext:dic];
    }
    else if (sender.tag == 302) {
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];
        [messageListner RouteMessage:ACTION_SHOW_SYSTEM_RECOMMEND
                         withContext:dic];
    }
    else if (sender.tag == 303) {
        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:messageListner, ACTION_Controller_Name, nil];
        [messageListner RouteMessage:ACTION_SHOW_SYSTEM_SHARE
                         withContext:dic];
    }
}

@end
