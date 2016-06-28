//
//  QDModel.h
//  Common
//
//  Created by zhouwengang on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDModel : NSObject<NSCoding>

@property (nonatomic,strong)NSString *signMessage;
@property (nonatomic,assign) NSInteger signPrice;
@property (nonatomic,strong)NSString * flag;
@property (nonatomic,strong)NSString * signMoney;
@property (nonatomic,strong)NSString * priceTotal;
+(QDModel *)JsonParse:(NSDictionary *)dict;
@end
