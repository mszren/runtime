//
//  AppImageUtil.m
//  Common
//
//  Created by Owen on 15/7/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "AppImageUtil.h"

@implementation AppImageUtil

//指定长，按照长度等比压缩
+ (NSURL*)getImageURL:(NSString*)strName Width:(NSInteger)width
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ld",
                                          IMAGE_SERVER, strName, width * (int)SCREEN_SCALE]];
}

//制定高，按照高度等比压缩
+ (NSURL*)getImageURL:(NSString*)strName Height:(NSInteger)height
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ldh",
                                          IMAGE_SERVER, strName, height * (int)SCREEN_SCALE]];
}

//指定长和高 返回固定大小
+ (NSURL*)getImageURL:(NSString*)strName Size:(CGSize)size
{

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@1e_%dw_%dh_1c_0i_1o_90Q_1x.jpg",
                                          IMAGE_SERVER, strName, (int)size.width * (int)SCREEN_SCALE, (int)size.height * (int)SCREEN_SCALE]];
}

//指定长和高 返回固定大小
+ (NSURL*)getImageURL:(NSString*)strName Width:(NSInteger)width Height:(NSInteger)height
{

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@@%ldw_%ldh_0e",
                                          IMAGE_SERVER, strName, width * (int)SCREEN_SCALE, height * (int)SCREEN_SCALE]];
}

@end
