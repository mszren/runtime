//
//  ActivityDetailViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "ShareView.h"
#import "UMSocial.h"
@interface WebViewController () <UIWebViewDelegate, UMSocialUIDelegate, UMSocialDataDelegate>
@property WebViewJavascriptBridge* bridge;

@end

@implementation WebViewController {
    UIWebView* _webView;
    UIWebView* phoneCallWebView;
    NSDictionary* dic;
    ShareView* _shareView;
    NSString* _title;
    NSString* _content;
    NSString* _url;
    NSString* _iconUrl;
    NSString* _sourceId;
    NSString* _shareId;
    NSDictionary* _rightData;
    NSInteger _activityId;
    MBProgressHUD *_hud;
}
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    [self setWhiteNavBg];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 14, SCREEN_WIDTH - 160, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _titleName;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = COLOR_RED_DEFAULT_78;
    self.navigationItem.titleView = titleLabel ;

    _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    NSString* strUrl = self.detailUrl;
    NSURL* url = [[NSURL alloc] initWithString:strUrl];
    NSLog(strUrl, @"strUrl===");
    //网络请求对象
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];
    [self.view addSubview:_webView];
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:request]; //打开网页
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView
                                        webViewDelegate:self
                                                handler:^(id data, WVJBResponseCallback responseCallback) {
                                                    dic = data;
                                                    NSLog(@"ObjC 接受消息来自JS: %@", data);

                                                }];
    [_bridge registerHandler:@"StartLoading"
                     handler:^(id data, WVJBResponseCallback responseCallback){
                          _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                     }];
    [_bridge registerHandler:@"StopLoading"
                     handler:^(id data, WVJBResponseCallback responseCallback){
                          [_hud hide:YES];
                     }];
    [_bridge registerHandler:@"SetTitle"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         NSDictionary* dicData = data;
                         NSString* strTitle = [dicData objectForKey:@"title"];
                         [self initializeWhiteBackgroudView:strTitle];
                     }];
    [_bridge registerHandler:@"setCommentity"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         [self.navigationController popToRootViewControllerAnimated:YES];
                     }];
    [_bridge registerHandler:@"setRightAction"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         [self setRightAction:data];
                     }];
    [_bridge registerHandler:@"Redirect"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         NSDictionary* dicData = data;
                         ;
                         NSString* strURL = [NSString stringWithFormat:@"%@/ibsApp/%@", JAVA_API, [dicData objectForKey:@"webURL"]];
                         NSString* strTitle = [dicData objectForKey:@"title"];
                         [self RouteMessage:ACTION_SHOW_WEB_INFO withContext:@{ ACTION_Controller_Name : self, ACTION_Web_URL : strURL, ACTION_Web_Title : strTitle }];
                     }];
    [_bridge registerHandler:@"DoAction"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         NSDictionary* dicData = data;
                         NSString* action = [dicData objectForKey:@"action"];
                         NSDictionary* actionData = [dicData objectForKey:@"data"];

                         [self RouteMessage:action
                                withContext:@{
                                    ACTION_Controller_Name : self,
                                    ACTION_Controller_Data : actionData
                                }];
                     }];
    [_bridge registerHandler:@"CallPhone"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         NSDictionary* dicData = data;
                         NSString* strPhone = [NSString stringWithFormat:@"tel://%@", [dicData objectForKey:@"phoneNumber"]];
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhone]];
                     }];
    [_bridge registerHandler:@"Share"
                     handler:^(id data, WVJBResponseCallback responseCallback) {

                         NSDictionary* dicData = data;
                         _title = [dicData objectForKey:@"title"];
                         _content = [dicData objectForKey:@"content"];
                         _url = [dicData objectForKey:@"url"];
                         _iconUrl = [dicData objectForKey:@"iconUrl"];

                         NSMutableString* string1 = [[NSMutableString alloc] initWithFormat:@"%@", _url];
                         NSRange range1 = [_url rangeOfString:@"%3D"];
                         [string1 deleteCharactersInRange:NSMakeRange(0, range1.location + range1.length)];

                         NSMutableString* string2 = [[NSMutableString alloc] initWithFormat:@"%@", string1];
                         NSArray* arry1 = [string1 componentsSeparatedByString:@"%"];
                         _sourceId = arry1[0];

                         NSRange range2 = [string2 rangeOfString:@"%3D"];
                         [string2 deleteCharactersInRange:NSMakeRange(0, range2.location + range2.length)];
                         NSArray* arry2 = [string2 componentsSeparatedByString:@"%"];
                         _shareId = arry2[0];

                         [_shareView.cancelButton addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];

                         UITapGestureRecognizer* tapwechatTimeline = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatTimeline:)];
                         [_shareView.wechatTimeline addGestureRecognizer:tapwechatTimeline];

                         UITapGestureRecognizer* tapwechatSession = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatSession:)];
                         [_shareView.wechatSession addGestureRecognizer:tapwechatSession];
                         _shareView.hidden = NO;
                         [self.view.window addSubview:_shareView];

                     }];
    [_bridge registerHandler:@"QianDao"
                     handler:^(id data, WVJBResponseCallback responseCallback) {
                         
                         NSDictionary *dicData = data;
                         NSMutableString* string1 = [[NSMutableString alloc] initWithFormat:@"%@", _detailUrl];
                         NSRange range1 = [_detailUrl rangeOfString:@"="];
                         [string1 deleteCharactersInRange:NSMakeRange(0, range1.location + range1.length)];
                         NSArray *arry = [string1 componentsSeparatedByString:@"&"];
                         _activityId = [arry[0] integerValue];
                         [self RouteMessage:ACTION_SHOW_SYSTEM_ACTIVITYQIANDAO withContext:@{ACTION_Controller_Name:self,ACTION_Controller_Data:@(_activityId)}];
  
                     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setWhiteNavBg];
}

- (void)setRightAction:(NSDictionary*)data
{
    _rightData = data;
    NSString* strTitle = [_rightData objectForKey:@"title"];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]
        initWithTitle:strTitle
                style:UIBarButtonItemStylePlain
               target:self
               action:@selector(RightAction:)];
    self.navigationItem.rightBarButtonItem = leftItem;
}

- (void)RightAction:(id)sender
{
    NSString* action = [_rightData objectForKey:@"action"];
    if ([action isEqualToString:ACTION_SHOW_WEB_INFO]) {
        NSDictionary* data = [_rightData objectForKey:@"data"];
        NSString* strURL = [NSString stringWithFormat:@"%@/ibsApp/%@", JAVA_API, [data objectForKey:@"webURL"]];
        NSString* strTitle = [data objectForKey:@"title"];
        [self RouteMessage:ACTION_SHOW_WEB_INFO withContext:@{ ACTION_Controller_Name : self, ACTION_Web_URL : strURL, ACTION_Web_Title : strTitle }];
    }
    else {
        NSDictionary* actionData = [_rightData objectForKey:@"data"];
        [self RouteMessage:action
               withContext:@{
                   ACTION_Controller_Name : self,
                   ACTION_Controller_Data : actionData
               }];
    }
}

#pragma mark
#pragma mark-- UIButtonAction
- (void)onBtnCancel:(UIButton*)sender
{
    _shareView.hidden = !_shareView.hidden;
}

- (void)onBtnCustomer:(UIButton*)sender
{
}

#pragma mark
#pragma mark-- UITapGestureRecognizer
- (void)wechatTimeline:(UITapGestureRecognizer*)sender
{

    //朋友圈信息

    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@ibs/ibs/judgeShareRederIsRegist?source_id=%@&share_id=%@", JAVA_API, _sourceId, _shareId];
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _title;
    UIImage* myImage5 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _iconUrl]]]];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatTimeline ]
                                                       content:_content
                                                         image:myImage5
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:self
                                                    completion:^(UMSocialResponseEntity* response) {

                                                        if (response.responseCode == UMSResponseCodeSuccess) {
                                                            _shareView.hidden = !_shareView.hidden;
                                                        }
                                                    }];
}

- (void)wechatSession:(UITapGestureRecognizer*)sender
{

    //微信邀请
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@/ibs/ibs/judgeShareRederIsRegist?source_id=%@&share_id=%@", JAVA_API, _sourceId, _shareId];
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _title;

    UIImage* myImage5 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _iconUrl]]]];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatSession ]
                                                       content:_content
                                                         image:myImage5
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:self
                                                    completion:^(UMSocialResponseEntity* response) {

                                                        if (response.responseCode == UMSResponseCodeSuccess) {
                                                            _shareView.hidden = !_shareView.hidden;
                                                        }
                                                    }];
}

- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView*)webView

{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString* strTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (strTitle && !_titleName) {
        [self initializeWhiteBackgroudView:strTitle];
    }
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark
#pragma mark-- UM
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity*)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if (response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@", [[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity*)response
{
}

@end
