//
//  HomeModel.h
//  Common
//
//  Created by zhouwengang on 15/5/26.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  首页
 */

@interface IndexModel : NSObject<NSCoding>
@property (nonatomic,strong)NSArray *tribe;
@property (nonatomic,strong)NSArray *interaction;
@property (nonatomic,strong)NSArray *carouselDiagramList;

+(IndexModel *)JsonParse:(NSDictionary *)dict;
@end
