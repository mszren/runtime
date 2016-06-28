//
//  RedPacketWebController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/4/13.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RedPacketWebController.h"


@interface RedPacketWebController (){

    MBProgressHUD *_hud;
}
@end
@implementation RedPacketWebController

- (id)init{
    self = [super init];
    if (self) {
        //        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"群红包"];
    self.view.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight -  20 )];

    NSURLRequest *  request;
    if (_currentRedPacketModel) {
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:RedPackedInfoUrl(self.currentRedPacketModel.red_packet_id,(unsigned long)[CurrentAccount currentAccount].uid)] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    }else{
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:SendRedPackedUrl(self.groupName,(unsigned long)[CurrentAccount currentAccount].uid)] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    }
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setWhiteNavBg];

}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)leftItemAction:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)webView:(UIWebView *)lwebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)lwebView{
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [webView stringByEvaluatingJavaScriptFromString:@"myJsAndroid.jsStartLoading()"];
}
- (void)webViewDidFinishLoad:(UIWebView *)lwebView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"myJsAndroid.jsStartLoading()"];
    _hud.hidden = YES;
}

@end
