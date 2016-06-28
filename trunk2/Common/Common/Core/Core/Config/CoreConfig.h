//
//  SDKConfig.h
//  MicroRoad
//
//  Created by aqxu on 12-6-11.
//  Copyright (c) 2012年 Ecpalm. All rights reserved.
//

#define KCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define KGreaterThanSevenSystemVersion (KCurrentSystemVersion >= 7.0)
#define KLessThanSevenSystemVersion (KCurrentSystemVersion < 7.0)

#define KIsIphone5 ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) \
    && (([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >= 1136)

#define ASAlert(_title, _message, _ok)             \
    [[[UIAlertView alloc] initWithTitle:(_title)   \
                                message:(_message) \
                               delegate:nil        \
                      cancelButtonTitle:(_ok)      \
                      otherButtonTitles:nil] show]

#define ASShowRect(rect) \
    NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)

#define kDevelopersGuideFileName @"DevelopersGuide.pdf"
#define kPaperExampleFileName @"amazon-dynamo-sosp2007.pdf"
#define kPSPDFCatalog @"PSPDFKit.pdf"
#define kHackerMagazineExample @"hackermonthly12.pdf"

#ifndef qeebuConference_config_h
#define qeebuConference_config_h

//常用变量配置
#define DeviceWidth 1024
#define DeviceHeight 768
#define TimeRequestTimeOut 5
#define AllTitleFontSize 15

#define TypeFontSize 14

#define ContentsTableViewWidth 200
#define KBrightnessViewAlpha @"BrightnessViewAlpha"
#define KCurrentDeviceToken @"CurrentDeviceToken"

#define kShareDefaultTitle @"人大就业"
#define kShareDefaultContent0 @"我安装了人大就业,它除了让知道你的家庭室内是否威胁你及家人健康, 还会根据你室内的情况,手机上给出有效的改善建议,帮助你改善自己的室内环境哦.很有意思,你也试试吧."
#define kShareDefaultImage0 [UIImage imageNamed:@"share_logo.png"]
#define KShareDefaultImage1 [UIImage imageNamed:@"intro0_5.png"]
#define kShareDefaultContent kBConfigDevice(kShareDefaultContent0, KShareDefaultContent1)
#define kShareDefaultImage kBConfigDevice(kShareDefaultImage0, KShareDefaultImage1)
#define kShareDefaultSuccess @"分享成功，你的分享将帮助大家的就业。"
#define kShareURL @"http://career.ruc.edu.cn"

#define Back_Image @"presonHeadDefault"

#define degreesToRadians(x) (M_PI * x / 180.0)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_SCALE [UIScreen mainScreen].scale

#define HOME_MSG_WIDTH SCREEN_WIDTH - 80

#define DBNAME @"messages.db" //数据库名
#define DBOPENPASSWORD @"qeebu123" //数据库密码

#define kHarpyAppID @"786232995"

#define AlterSize CGSizeMake(250, 200)
#define AlterDismissTime 0.8f

//Notification
#define SyncStartLoadFinishName @"syncStartFinishLoad"
#define WEBVIEWREQUEST @"webviewRequest"
#define ChanageLanguage @"ChangeLanguagePost"



//软件过期
#define AppExpireName @"AppExpire"

//语言
#define English @"en"
#define Chinese @"zh-Hans"

//网络请求失效
#define TimeOutInterval 3
#define RequestTimeOutInterval 30
#define RequestFileTimeOutInterval 60

//时间戳
#define LastUpdatetime @"lastupdatetime"

//加密私钥
#define ASECryptPassword @"qeebu"
#define ZipPassword @"qee123bu#@!"

//全局配置模块
#define BaseConfig @"BaseConfig"
#define ConfigVersion @"ConfigVersion"
#define ConfigZipUrl @"ConfigZipUrl"
#define ConfigTxtUrl @"ConfigUrl"

//发布
#define PublishImageTileWidth 78
#define PublishImageTileHeight 78

//键盘显示类型
typedef enum {
    showNoView = 0, //不显示
    showKeyBoard = 1, //显示键盘
    showEmojiView = 2 //显示表情
} ShowType;

typedef enum {
    EGOOPullRefreshNormal = 0, //拉拽加载更多
    EGOOPullRefreshPulling = 1, //松开加载更多
    EGOOPullRefreshLoading = 2 //正在加载
} EGOPullRefreshState;

typedef enum {
    kPRStateNormal = 0,
    kPRStatePulling = 1,
    kPRStateLoading = 2,
    kPRStateHitTheEnd = 3
} PRState;

//页码
typedef enum {
    FirstPage = 0, //首页
    LastPage, //最后一页
    CententPage //中间页
} EScrollPageType;

//文件类型
typedef enum {
    MP4Type = 1, //MP4
    MP3Type, //ppt
    PDFType, //pdf
    NEWSType, //news
    GoodsType, //商品信息news
    BaiscsType, //基础设施news
    InfosType //信息服务news
} EFileType;

//操作类型
typedef enum {
    OperationBrowse = 1, //浏览
    OperationDownLoad, //下载
    OperationFav, //收藏
} EOperationType;

//下载类型
typedef enum {
    EDOWNLOADSTOP = 0,
    EDOWNLOADDOWN,
    EDOWNLOADCACEL,
    EDOWNLOADCOMPLETE
} EDOWNTYPE;

//下载类型
typedef enum {
    EMESSAGESUCCESS = 0,
    EMESSAGEFAILURE,
    EMESSAGEWARNING,
} EMessageTYPE;

//下载类型
typedef enum {
    ELanguageChinese = 0,
    ELanguageMengu
} ELanguage;

#define OSSUserPath @"User"
#define OSSChatPath @"Chat"
#define OSSMessagePath @"Message"
#define OSSGroupHeadPath @"Chat/Group"

#endif
