//
//  AttestationControllerViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/4.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AttestationControllerViewController.h"
#import "UserService.h"
#import "AttestationModel.h"
@interface AttestationControllerViewController () <UITextFieldDelegate>
@property (nonatomic, strong) DataModel* dataModel;
@end

@implementation AttestationControllerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    self.view.backgroundColor = COLOR_VIEW_BG;
    [self initializeWhiteBackgroudView:@"申请成为经纪人"];
    UIView* bgview = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 80)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];

    UILabel* reallabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 40)];
    reallabel.text = @"姓  名";
    [self.view addSubview:reallabel];

    _realname = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, SCREEN_WIDTH, 40)];
    _realname.delegate = self;
    _realname.placeholder = @"请输入真实姓名";
    _realname.textColor = [UIColor grayColor];
    ;
    [self.view addSubview:_realname];

    UIView* lineview = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 1)];
    lineview.backgroundColor = BGViewGray;
    [self.view addSubview:lineview];

    UILabel* cardlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 56, 100, 40)];
    cardlabel.text = @"身份证";
    [self.view addSubview:cardlabel];

    _cardid = [[UITextField alloc] initWithFrame:CGRectMake(100, 56, SCREEN_WIDTH, 40)];
    _cardid.delegate = self;
    _cardid.placeholder = @"请输入身份证号";
    _cardid.textColor = [UIColor grayColor];
    ;
    [self.view addSubview:_cardid];

    _applybotton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applybotton.frame = CGRectMake(10, 115, SCREEN_WIDTH - 20, 40);
    [_applybotton setTitle:@"申请成为经纪人" forState:UIControlStateNormal];
    [_applybotton addTarget:self action:@selector(applyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_applybotton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _applybotton.backgroundColor = HomeNavBarBgColor;
    _applybotton.layer.cornerRadius = 5.0;
    [self.view addSubview:_applybotton];

    UIView* textbgview = [[UILabel alloc] initWithFrame:CGRectMake(0, 175, SCREEN_WIDTH, SCREEN_HEIGHT - 175)];
    textbgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textbgview];

    UILabel* titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, SCREEN_WIDTH - 20, 20)];
    titlelabel.text = @"如何迅速成为一名合格的经纪人赚钱？";
    titlelabel.textColor = HomeNavBarBgColor;
    [self.view addSubview:titlelabel];

    UILabel* contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 170)];
    contentlabel.text = @"1.您需要加入家家帮并注册为会员，然后进入推荐赚，选择您要推荐的项目；\n 2.点击“申请经纪人”，进入经纪人注册页面，填写您的真实资料；\n 3.如果您填写的经纪人姓名、身份证号，和您真实的身份证号、姓名不一致，即使您成功推荐了购房者，您也无法获得奖金；\n 4.如果您已经填写了申请成为经纪人所需的信息，请点击申请认证按钮，我们将在1～3个工作日内对您的信息进行审核；\n 6.如果您成功的通过审核，成为了“家家帮”的经纪人，您可进入“推荐赚”页面中选择各个项目推荐个亲朋好友；\n 7.成功推荐一名购房者，我们将按照系统显示佣金打入您的账户，推荐越多，赚的越多。";
    contentlabel.numberOfLines = 0; // 最关键的一句
    contentlabel.font = FONT_SIZE(14);
    [self.view addSubview:contentlabel];

    [[UserService shareInstance] getRecommendBrokerdatailNew:[CurrentAccount currentAccount].uid
                                                   OnSuccess:^(DataModel* dataModel) {

                                                       if (dataModel.code == 200) {

                                                           AttestationModel* msgNewListModel = dataModel.data;

                                                           if (msgNewListModel.status == 1) {
                                                               _realname.text = msgNewListModel.brokerName;
                                                               _cardid.text = msgNewListModel.cardId;
                                                               [_applybotton setTitle:@"恭喜您，审核通过" forState:UIControlStateNormal];
                                                               _applybotton.backgroundColor = [UIColor grayColor];
                                                               [_applybotton setEnabled:NO];
                                                               [_realname setEnabled:NO];
                                                               [_cardid setEnabled:NO];
                                                           }
                                                           else if (msgNewListModel.status == 0) {

                                                               _realname.text = msgNewListModel.brokerName;
                                                               _cardid.text = msgNewListModel.cardId;
                                                               [_applybotton setTitle:@"请耐心等待审核" forState:UIControlStateNormal];
                                                               _applybotton.backgroundColor = [UIColor grayColor];
                                                               [_applybotton setEnabled:NO];
                                                               [_realname setEnabled:NO];
                                                               [_cardid setEnabled:NO];
                                                           }
                                                       }
                                                       else {
                                                           [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                       }
                                                   }];
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)applyBtnAction:(id)sender
{

    [[UserService shareInstance] addRecommendBrokerNew:[CurrentAccount currentAccount].uid
                                            brokerName:_realname.text
                                           brokerPhone:[CurrentAccount currentAccount].username
                                                cardId:_cardid.text
                                             OnSuccess:^(DataModel* dataModel) {

                                                 if (dataModel.code != 200) {
                                                     [ToastManager showToast:dataModel.error withTime:Toast_Hide_TIME];
                                                 }
                                                 else {
                                                 }

                                             }];
}
@end
