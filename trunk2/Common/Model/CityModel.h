//
//  CityModel.h
//  Common
//
//  Created by zhouwengang on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject<NSCoding>
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,assign)NSInteger cityId;
+(CityModel *)JsonParse:(NSDictionary *)dic;
@end
