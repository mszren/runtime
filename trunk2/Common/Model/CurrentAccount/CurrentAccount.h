//
//  CurrentAccount.h
//  qeebuConference
//
//  Created by caoliang on 13-1-14.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CurrentAccount : User<NSCoding>{
    NSString * password;
}
@property(nonatomic,strong) NSString * password;

+(CurrentAccount *)currentAccount;
+ (void)saveAccount:(CurrentAccount *)account;
+ (void)removeAccount;
+(BOOL) isHasLogin;

+(CurrentAccount *)JsonParse:(NSDictionary *)dic;
@end
