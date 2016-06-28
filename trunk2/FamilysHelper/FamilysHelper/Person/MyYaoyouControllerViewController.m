//
//  MyYaoyouControllerViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyYaoyouControllerViewController.h"
#import "UserService.h"
#import "MyYaoyouModel.h"

@interface MyYaoyouControllerViewController () {
    DataModel* _dataModel;
}

@end

@implementation MyYaoyouControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self loadData];
    [self initializeWhiteBackgroudView:@"我的邀友"];
    [self initializeNavBackView];
    self.view.backgroundColor = COLOR_VIEW_BG;
    self.progressView1.progress = 0;
    self.progressView1.thicknessRatio = 0.1;
    self.progressView1.textColor = [UIColor redColor];
    self.progressView1.font = [UIFont systemFontOfSize:5.0];
    self.progressView2.progress = 0;
    self.progressView2.thicknessRatio = 0.1;
    self.progressView3.progress = 0;
    self.progressView3.thicknessRatio = 0.1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadData
{
    [[UserService shareInstance] getMyYaoyou:[CurrentAccount currentAccount].uid
                                   OnSuccess:^(DataModel* dataModel) {
                                       _dataModel = dataModel;
                                       [self displayData];
                                   }];
}

- (void)displayData
{
    MyYaoyouModel* model = _dataModel.data;
    self.progressView1.progress = model.oneFriendNumber / 100.0;
    self.progressView2.progress = model.twoFriendNumber / 100.0;
    self.progressView3.progress = model.threeFriendNumber / 100.0;
}

@end
