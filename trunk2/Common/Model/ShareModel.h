//
//  ShareModel.h
//  Common
//
//  Created by zhouwengang on 15/5/26.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject<NSCoding>
@property (nonatomic,assign)NSInteger  courrentNum;
@property (nonatomic,copy)NSString * endTimeStr;
@property (nonatomic,assign)NSInteger hasMoney;
@property (nonatomic,assign)NSInteger limitNum;
@property (nonatomic,assign)NSInteger limitPerNum;
@property (nonatomic,copy)NSString *logoImg;
@property (nonatomic,assign)NSInteger makeMoney;
@property (nonatomic,assign)NSInteger maxMoney;
@property (nonatomic,assign)NSInteger mid;
@property (nonatomic,assign)NSInteger money;
@property (nonatomic,assign)NSInteger myCent;
@property (nonatomic,assign)NSInteger myCentMoney;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *oSmallImageUrl;
@property (nonatomic,assign)NSInteger readerCent;
@property (nonatomic,assign)NSInteger readerCentMoney;
@property (nonatomic,assign)NSInteger shareId;
@property (nonatomic,assign)NSInteger shareRuleid;
@property (nonatomic,assign)NSInteger shengMoney;
@property (nonatomic,copy)NSString *smallImageUrl;
@property (nonatomic,copy)NSString *startTimeStr;
@property (nonatomic,assign)NSInteger stauts;
@property (nonatomic,assign)NSInteger sumMoney;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)NSInteger userId;
@property (nonatomic,copy)NSString *username;

@property (nonatomic,copy)NSString *parentProfit;
@property (nonatomic,copy)NSString *myProfit;
@property (nonatomic,copy)NSString *regUrl;

+(ShareModel *)JsonParse:(NSDictionary *)dict;
@end
