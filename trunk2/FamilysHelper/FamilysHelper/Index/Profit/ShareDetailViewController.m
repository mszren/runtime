//
//  ShareDetailViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShareDetailViewController.h"

@interface ShareDetailViewController ()

@end

@implementation ShareDetailViewController{
    UIWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    self.view.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"文章详情";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = COLOR_RED_DEFAULT_78;
    self.navigationItem.titleView = titleLabel ;
    
    
    NSString *strUrl = self.url;
    NSURL *url = [[NSURL alloc]initWithString:strUrl];
    
    //网络请求对象
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];
    [self.view addSubview:_webView];
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:request];//打开网页
}

-(void)onBtnBack:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
