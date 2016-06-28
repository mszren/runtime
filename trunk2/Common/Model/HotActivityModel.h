//
//  HotActivityModel.h
//  Common
//
//  Created by hubin on 15/7/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotActivityModel : NSObject<NSCoding>
@property (nonatomic,strong)NSString* activityId;
@property (nonatomic,strong)NSString* activityTitle;
@property (nonatomic,assign)NSInteger activityStatus;
@property (nonatomic,strong)NSString* activityImage;
+(HotActivityModel *)JsonParse:(NSDictionary *)dic;
@end
