//
//  CommunityModel.h
//  Common
//
//  Created by zhouwengang on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject<NSCoding>
@property (nonatomic,strong) NSString *communityName;
@property (nonatomic,assign) NSInteger communityId;
+(CommunityModel *)JsonParse:(NSDictionary *)dic;
@end
