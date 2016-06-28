//
//  MyYaoyouModel.h
//  Common
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyYaoyouModel : NSObject <NSCoding>
@property (nonatomic, assign) NSInteger oneFriendNumber;
@property (nonatomic, assign) NSInteger twoFriendNumber;
@property (nonatomic, assign) NSInteger threeFriendNumber;
+ (MyYaoyouModel*)JsonParse:(NSDictionary*)dic;

@end
