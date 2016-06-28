//
//  Constaints.h
//  Diary
//
//  Created by Owen on 15/10/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#ifndef Constaints_h
#define Constaints_h


// COLOR
#define RGBCOLOR(r, g, b)                                                      \
[UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define RGBACOLOR(r, g, b, a)                                                  \
[UIColor colorWithRed:(r) / 255.0                                            \
green:(g) / 255.0                                            \
blue:(b) / 255.0                                            \
alpha:(a)]

#define Toast_Hide_TIME 1

#define IOS7 (［[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]

// dir file name
#define Img_Dir_Name @"ImgDirName"

#define FILEHOMENAME                                                           \
[@"File_cache" stringByAppendingFormat:@"/User_%ld", (long)1]

// DBname
#define DBNAME @"Diary.db" //数据库名

//高德开发Key
#define ApiKey @"2faa79d859dfef7fb1f8f754679077c9"

//录音文件存储地址
#define LVRecordFielName @"lvRecord.caf"

// language
#define Refresh_More @"加载更多"
#define Refresh_NOData @"没有数据"
#define Refresh_Therefresh @"下拉刷新"
#define Refresh_Refreshing @"正在刷新"
#define Refresh_Loading @"正在拼命加载"
#define Refresh_Release_refresh @"释放刷新"
#define Refresh_Release_load_more @"释放加载更多"
#define Refresh_Pull_up_loading_more @"上拉加载更多"
#define Refresh_No_oh @"没有了哦"
#define Refresh_Today @"今天"
#define Refresh_Yesterday @"昨天"
#define Refresh_The_day_before_yesterday @"前天"
#define Refresh_Last_update @"最后更新"
#define Refresh_Drag_can_refresh @"下拉可以刷新..."
#define Refresh_Undo_can_refresh @"松开即可刷新..."

#define NavBarBgColor RGBCOLOR(135, 213, 27)
#define TabBarColor RGBCOLOR(239, 239, 239)

//背景
#define BGViewColor RGBCOLOR(255, 255, 255)
#define BGViewGray RGBCOLOR(242, 242, 242)
#define BGViewGreen RGBCOLOR(135, 213, 27)
#define BGViewAGreen RGBACOLOR(135, 213, 27，0)
#define BGViewLightGreen RGBCOLOR(34, 139, 34)
#define COLOR_Orange_230 RGBACOLOR(230, 231, 33, 1)
#define COLOR_GRAY_DEFAULT_185 RGBACOLOR(185, 185, 185, 1)
#define COLOR_GRAY_DEFAULT_30 RGBACOLOR(30, 30, 30, 1)

//table
#define AllTableViewColor RGBCOLOR(238, 238, 238)
#define TableSeparatorColor RGBCOLOR(224, 224, 224)
#define COLOR_GRAY_LIGHT RGBCOLOR(245, 247, 250)

#define COLOR_GRAY_DEFAULT_47 RGBACOLOR(47, 47, 47, 1)
#define COLOR_GRAY_DEFAULT_133 RGBACOLOR(133, 133, 133, 1)
#define COLOR_GRAY_DEFAULT_153 RGBACOLOR(153, 153, 153, 1)
#define COLOR_GRAY_DEFAULT_180 RGBACOLOR(186, 180, 185, 1)
#define COLOR_GRAY_DEFAULT_190 RGBACOLOR(190, 190, 190, 1)
#define COLOR_GRAY_DEFAULT_240 RGBACOLOR(240, 240, 240, 1)


//Font
#define FONT_NAME @"Helvetica"
#define FONT_SIZE(s) [UIFont fontWithName:FONT_NAME size:s]
#define BOLDFont_SIZE(s) [UIFont boldSystemFontOfSize:s]

#define FONT_SIZE_11 FONT_SIZE(11)
#define FONT_SIZE_12 FONT_SIZE(12)
#define FONT_SIZE_13 FONT_SIZE(13)
#define FONT_SIZE_14 FONT_SIZE(14)
#define FONT_SIZE_15 FONT_SIZE(15)
#define FONT_SIZE_16 FONT_SIZE(16)
#define FONT_SIZE_17 FONT_SIZE(17)
#define FONT_SIZE_18 FONT_SIZE(18)
#define FONT_SIZE_19 FONT_SIZE(19)
#define FONT_SIZE_20 FONT_SIZE(20)

#define BOLDFont_SIZE_13  BOLDFont_SIZE(13)
#define BOLDFont_SIZE_14  BOLDFont_SIZE(14)
#define BOLDFont_SIZE_15  BOLDFont_SIZE(15)
#define BOLDFont_SIZE_16  BOLDFont_SIZE(16)
#define BOLDFont_SIZE_17  BOLDFont_SIZE(17)
#define BOLDFont_SIZE_19  BOLDFont_SIZE(19)

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height


#define CoolNavHeight 300.0f
#define SearchBarHeight 44
#define TabBarHeigh 44
#define TabBarWidth 240
#define statusHeight 20
#define TabBarHeight 49
#define NavigationBarHeight 64

//发布
#define PublishImageTileWidth ([UIScreen mainScreen].bounds.size.width - 100)/4
#define PublishImageTileHeight ([UIScreen mainScreen].bounds.size.width - 100)/4

#define TopBarHeight 48

#endif /* Constaints_h */
