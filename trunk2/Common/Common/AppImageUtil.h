//
//  AppImageUtil.h
//  Common
//
//  Created by Owen on 15/7/9.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppImageUtil : NSObject

//指定长，按照长度等比压缩
+ (NSURL*)getImageURL:(NSString*)strName Width:(NSInteger)width;

//制定高，按照高度等比压缩
+ (NSURL*)getImageURL:(NSString*)strName Height:(NSInteger)height;

//指定长和高 返回固定大小
+ (NSURL*)getImageURL:(NSString*)strName Size:(CGSize)size;

//指定长和高 返回固定大小
+ (NSURL*)getImageURL:(NSString*)strName Width:(NSInteger)width Height:(NSInteger)height;
@end
