//
//  SettingViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SettingViewController.h"
#import "ResetpwdController.h"
#import "MyDatePicker.h"
@interface SettingViewController ()<MyDatePickerDelegate,UIAlertViewDelegate>{
MyDatePicker* _datePicker;
    NSInteger tag;
    NSString *_trackViewUrl;
}

@property(nonatomic,assign)NSInteger mySound;
@property(nonatomic,strong)NSString* startTimeText;
@property(nonatomic,strong)NSString* endTimeText;

@end
NSString* version;

@implementation SettingViewController
@synthesize messageListner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"设置"];
    [self initializeNavBackView];
    self.view.backgroundColor = COLOR_VIEW_BG;
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versioncode.text = version;
    UITapGestureRecognizer* clearCacheGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_clearCache:)];
    [self.clearcache addGestureRecognizer:clearCacheGesture];

    UITapGestureRecognizer* resetpwdGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_resetpwd:)];
    [self.resetpwd addGestureRecognizer:resetpwdGesture];
    UITapGestureRecognizer* aboutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_about:)];
    [self.about addGestureRecognizer:aboutGesture];
    UITapGestureRecognizer* setstarttimeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_setstarttime:)];
    [self.setstarttime addGestureRecognizer:setstarttimeGesture];
    UITapGestureRecognizer* setendtimeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_setendtime:)];
    [self.setendtime addGestureRecognizer:setendtimeGesture];
    UITapGestureRecognizer* versioncodeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ac_versioncode:)];
    [self.version addGestureRecognizer:versioncodeGesture];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _mySound=[userDefaults integerForKey:@"mySound"];
    _startTimeText=[userDefaults stringForKey:@"starttime"];
    _endTimeText=[userDefaults stringForKey:@"endtime"];
    if(_startTimeText){
        _starttime.text=_startTimeText;
    }
    if(_endTimeText){
        _endtime.text=_endTimeText;
    }

    if(!_mySound||_mySound==0){
        _settime.on=YES;
        _mySound=1;
    }else{
        if(_mySound==2){
            _settime.on=NO;
        }else if(_mySound==1){
            _settime.on=YES;
        }
    }
    [_settime addTarget:self action:@selector(saveConfigure) forControlEvents:UIControlEventValueChanged];
}
-(void)viewDidLayoutSubviews
{

    [self isShowTime];

}
-(void)isShowTime{
    if(_mySound==2){
        self.setstarttime.hidden=YES;
        self.setendtime.hidden=YES;
        _about.frame=CGRectMake(0, 314-self.setstarttime.bounds.size.height-self.setendtime.bounds.size.height, 320, 40);
        _version.frame=CGRectMake(0, 273-self.setstarttime.bounds.size.height-self.setendtime.bounds.size.height, 320, 40);
        _outButton.frame=CGRectMake(8, 364-self.setstarttime.bounds.size.height-self.setendtime.bounds.size.height, 304, 30);
    }else{
        self.setstarttime.hidden=NO;
        self.setendtime.hidden=NO;
        _about.frame=CGRectMake(0, 314, 320, 40);
        _version.frame=CGRectMake(0, 273, 320, 40);
        _outButton.frame=CGRectMake(8, 364, 304, 30);
    }
}



- (void)viewDidAppear:(BOOL)animated{
}
- (void)viewWillAppear:(BOOL)animated{

    NSDate *now = [NSDate date];
    _datePicker = [[MyDatePicker alloc] initWithSelectTitle:@"选择日期" NSDate:now viewOfDelegate:self.view delegate:self];
    _datePicker.isBeforeTime = YES; //(是否可选择以前时间)
    _datePicker.theTypeOfDatePicker = 1; //(datePicker显示类别，只写了三种主流)

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ac_clearCache:(id)sender
{
    if ([AppCache clearCache]) {
        [ToastManager showToast:@"清除成功！" withTime:Toast_Hide_TIME];
    }
    else
        [ToastManager showToast:@"清除失败！" withTime:Toast_Hide_TIME];
}

- (void)ac_resetpwd:(id)sender
{
    ResetpwdController* controller = [[ResetpwdController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)ac_about:(id)sender
{
    NSString* _strURL = [NSString stringWithFormat:@"%@/ibsApp/page/login/aboutMe.html?userId=%lu", JAVA_API, (unsigned long)[CurrentAccount currentAccount].uid];
    [self RouteMessage:ACTION_SHOW_WEB_INFO
           withContext:@{ ACTION_Controller_Name : self,
               ACTION_Web_URL : _strURL,
               ACTION_Web_Title : @"关于我们" }];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
        [_datePicker popDatePicker];
    
}
//回调，字符串可自行进行截取
- (void)MyDatePickerDidConfirm:(NSString*)confirmString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (tag==1) {
       _starttime.text = confirmString;
        [userDefaults setObject:confirmString  forKey:@"starttime"];
    }else if (tag==2){
        _endtime.text = confirmString;
        [userDefaults setObject:confirmString forKey:@"endtime"];
    }
}
- (void)ac_setstarttime:(id)sender
{
    tag=1;
    [_datePicker pushDatePicker];
}

- (void)ac_setendtime:(id)sender
{
    tag=2;
    [_datePicker pushDatePicker];
}

-(void)saveConfigure{
    if(_mySound==0||_mySound==1){
        _settime.on=NO;
        _mySound=2;
    }else if(_mySound==2){
        _mySound=1;
        _settime.on=YES;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:_mySound forKey:@"mySound"];
    [self isShowTime];

}
- (void)ac_versioncode:(id)sender
{
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    //CFShow((__bridge CFTypeRef)(infoDic));
//    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
//    
//    NSString *URL = @"http://itunes.apple.com/lookup?id=你的应用程序的ID";
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:URL]];
//    [request setHTTPMethod:@"POST"];
//    NSHTTPURLResponse *urlResponse = nil;
//    NSError *error = nil;
//    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData NSJSONReadingMutableLeaves error:nil];
//    NSArray *infoArray = [dic objectForKey:@"results"];
//    if ([infoArray count]) {
//        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
//        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
//        _trackViewUrl =  [releaseInfo objectForKey:@"trackViewUrl"];
//
//        
//        if (![lastVersion isEqualToString:currentVersion]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
//            alert.tag = 10000;
//            [alert show];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alert.tag = 10001;
//            [alert show];
//        }
//    }
//    NSString *appVersion  = [infoDic objectForKey:@"CFBundleVersion"];
    
    [ToastManager showToast:@"此版本为最新版本" withTime:Toast_Hide_TIME];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:_trackViewUrl];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (IBAction)loginOut:(id)sender
{
    [CurrentAccount removeAccount];
    [[AppDelegate shareDelegate] loadLoginController];
}

@end
