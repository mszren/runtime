//
//  APAuthV2Info.h
//  FamilysHelper
//
//  Created by 我 on 15/8/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APAuthV2Info : NSObject
@property(strong)NSString *apiName;
@property(strong)NSString *appName;
@property(strong)NSString *appID;
@property(strong)NSString *bizType;
@property(strong)NSString *pid;
@property(strong)NSString *productID;
@property(strong)NSString *scope;
@property(strong)NSString *targetID;
@property(strong)NSString *authType;
@property(strong)NSString *signDate;
@property(strong)NSString *service;



- (NSString *)description;
@end
