//
//  InviteViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteCell.h"
#import "UIView+Toast.h"
#import "IndexService.h"
#import "ShareModel.h"
#import "UMSocial.h"
#import "UIView+Toast.h"
#import "MyYaoyouControllerViewController.h"

@interface InviteViewController () <UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate, UMSocialDataDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* titleArry;
@property (nonatomic, strong) NSArray* colorArry;
@property (nonatomic, strong) NSArray* descripeArry;
@property (nonatomic, strong) ShareModel* shareModel;
@property (nonatomic, strong) UIPasteboard* generalPasteBoard;
@property (nonatomic, strong) ASIHTTPRequest* request;
@property (nonatomic, assign) BOOL loadRequest;

@end

@implementation InviteViewController
@synthesize messageListner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initializeNavTitleView:@"邀友赚"];
    [self initView];
    [self initData];
}

- (void)initView
{

    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"我的邀友" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnYaoyou:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TopBarHeight - 20)];

    _tableView.backgroundColor = COLOR_RED_DEFAULT_BackGround;

    _tableView.backgroundView = nil;

    _tableView.dataSource = self;

    _tableView.delegate = self;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
}

- (void)initData
{

    _titleArry = @[ @"微信邀请", @"朋友圈邀请", @"短信邀请", @"面对面邀请", @"微博邀请", @"邀请链接" ];
    _descripeArry = @[ @"通过微信邀请好友一起来赚钱", @"通过微信朋友圈邀请一起来赚钱", @"通过短信邀请好友一起来赚钱", @"通过二维码邀请好友一起来赚钱", @"通过新浪微博邀请好友一起来赚钱", @"复制个人邀友链接，发送到QQ、QQ空间等邀请好友一起来赚钱" ];
    _colorArry = @[ COLOR_GRAY_DEFAULT_58, COLOR_GRAY_DEFAULT_95, COLOR_GRAY_DEFAULT_232, COLOR_GRAY_DEFAULT_42, COLOR_GRAY_DEFAULT_107, COLOR_GRAY_DEFAULT_58 ];
    if (_request) {
        [_request cancel];
    }
    _request = [[IndexService shareInstance] newCountMoney:[CurrentAccount currentAccount].uid
                                                 onSuccess:^(DataModel* dataModel) {
                                                     if (dataModel.code == 200) {

                                                         _shareModel = dataModel.data;
                                                         _loadRequest = YES;
                                                     }

                                                 }];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    static NSString* InviteCellId = @"InviteCell";
    InviteCell* inviteCell = [tableView dequeueReusableCellWithIdentifier:InviteCellId];
    if (!inviteCell) {
        inviteCell = [[InviteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InviteCellId];
        inviteCell.selectionStyle = UITableViewCellSelectionStyleNone;
        inviteCell.backgroundColor = COLOR_RED_DEFAULT_BackGround;
    }
    inviteCell.descripeLabel.text = _descripeArry[indexPath.row];
    inviteCell.titleLabel.text = _titleArry[indexPath.row];
    inviteCell.titleLabel.backgroundColor = _colorArry[indexPath.row];

    return inviteCell;
}

#pragma mark
#pragma mark-- UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    switch (indexPath.row) {
    case 0: {
        if (_loadRequest) {

            //微信邀请
            [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@ibs/ibs/judgeWhetherTheUserRegistration?user_id=%ld",JAVA_API,(long)[CurrentAccount currentAccount].uid];
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatSession ]
                                                               content:[NSString stringWithFormat:@"成功加入家家帮，您可得%@帮币，您的好友%@可得%@帮币，邀请其他好友，您也可以继续赚钱，朋友越多赚的越多，赶快来注册吧!%@", _shareModel.myProfit, [CurrentAccount currentAccount].nickname, _shareModel.parentProfit, _shareModel.regUrl]
                                                                 image:[UIImage imageNamed:@"108x108"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {

                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
        }

    }

    break;

    case 1: {

        if (_loadRequest) {

            //朋友圈信息

            [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@ibs/ibs/judgeWhetherTheUserRegistration?user_id=%ld",JAVA_API,(long)[CurrentAccount currentAccount].uid];

            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatTimeline ]
                                                               content:@"家家帮里赚翻天！帮币冲抵更省钱"
                                                                 image:[UIImage imageNamed:@"108x108"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {

                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
        }

    }

    break;

    case 2: {
        if (_loadRequest) {
            //短信邀请
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToSms ]
                                                               content:[NSString stringWithFormat:@"您好，您的好友%@正在邀请您加入【家家帮】，点击%@链接注册成功即可享受新人礼金%@帮币，您的好友%@也可赚%@帮币，一起加入家家帮吧!", [CurrentAccount currentAccount].nickname, _shareModel.regUrl, _shareModel.myProfit, [CurrentAccount currentAccount].nickname, _shareModel.parentProfit]
                                                                 image:nil
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
        }

    } break;

    case 3: {
        //面对面邀请
        NSString* webURL = [NSString stringWithFormat:@"%@/ibsApp/page/qrcode/yycode.html?userid=%lu", JAVA_API, (unsigned long)[CurrentAccount currentAccount].uid];
        NSString* title = @"面对面邀请";

        NSDictionary* dic = [NSDictionary
            dictionaryWithObjectsAndKeys:
                self, ACTION_Controller_Name,
            webURL,
            ACTION_Web_URL,
            title,
            ACTION_Web_Title, nil];
        [messageListner RouteMessage:ACTION_SHOW_WEB_INFO withContext:dic];
    }

    break;
    case 4: {
        if (_loadRequest) {
            //微博邀请

            [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"成功加入家家帮，您可得%@帮币，您的好友可得%@帮币，邀请其他好友，您也可以继续赚钱，朋友越多赚的越多，赶快来注册吧!%@ibs/ibs/judgeWhetherTheUserRegistration?user_id=%ld", _shareModel.myProfit, _shareModel.parentProfit,JAVA_API, (long)[CurrentAccount currentAccount].uid] shareImage:[UIImage imageNamed:@"500x500"] socialUIDelegate:self]; //设置分享内容和回调对象
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
        }

    }

    break;

    case 5: {

        if (_loadRequest) {
            //邀请链接

            _generalPasteBoard = [UIPasteboard generalPasteboard];
            [_generalPasteBoard setString:[NSString stringWithFormat:@"您好，您的好友%@邀请您加入“家家帮”，让您躺在家里把钱赚。点击%@链接注册并下载，成功登陆后可赚%@帮币,好友%@也可赚%@帮币，邀请其他好友，您也可以继续赚钱，朋友越多赚的越多，赶快来注册吧！", [CurrentAccount currentAccount].nickname, _shareModel.regUrl, _shareModel.myProfit, [CurrentAccount currentAccount].nickname, _shareModel.parentProfit]];
            [self.view makeToast:@"复制成功，去邀友赚钱吧" duration:1.5 position:nil];
        }
    }

    break;

    default:

        break;
    }
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

#pragma mark
#pragma mark-- UIbutton-Addtarget

- (void)onBtnYaoyou:(UIButton*)sender
{
    [self RouteMessage:ACTION_SHOW_PERSON_MYINVITE withContext:@{ ACTION_Controller_Name : self }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
