//
//  CurrentAccount.m
//  qeebuConference
//
//  Created by caoliang on 13-1-14.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import "CurrentAccount.h"
#import "PathHelper.h"

static CurrentAccount* currentAccount;

@implementation CurrentAccount
@synthesize password;

#pragma mark -
#pragma mark Private Method
+ (NSString*)getAccountsStoragePath
{
    NSString* filePath = [[PathHelper documentDirectoryPathWithName:@"User"]
        stringByAppendingPathComponent:@"accounts"];
    return filePath;
}

+ (void)loadAccount
{
    NSString* filePath = [self getAccountsStoragePath];
    currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (void)saveAccount:(CurrentAccount*)account
{
    NSString* filePath = [self getAccountsStoragePath];
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
    [self loadAccount];
}

+ (void)removeAccount
{
    if (currentAccount) {
        currentAccount = nil;
        [self saveAccount:currentAccount];
    }
}

+ (BOOL)isHasLogin
{
    [self loadAccount];
    if (currentAccount && currentAccount.uid) {
        return YES;
    }
    else {
        return NO;
    }
}
+ (CurrentAccount*)currentAccount
{

    [self loadAccount];
    return currentAccount;
}
#pragma mark -
#pragma mark Initialization and teardown
- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.password = [decoder decodeObjectForKey:@"password"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.password forKey:@"password"];
}

+ (CurrentAccount*)JsonParse:(NSDictionary*)dic
{
    CurrentAccount* account = [[CurrentAccount alloc] init];

    account.uid = ([dic objectForKey:@"userId"] != [NSNull null]) && ([dic objectForKey:@"userId"] != nil) ? [[dic objectForKey:@"userId"] integerValue] : 0;
    account.username = ([dic objectForKey:@"username"] != [NSNull null]) && ([dic objectForKey:@"username"] != nil) ? [dic objectForKey:@"username"] : @"";
    account.nickname = ([dic objectForKey:@"nickname"] != [NSNull null]) && ([dic objectForKey:@"nickname"] != nil) ? [dic objectForKey:@"nickname"] : @"";
    account.face = ([dic objectForKey:@"face"] != [NSNull null]) && ([dic objectForKey:@"face"] != nil) ? [dic objectForKey:@"face"] : @"";
    account.isSign = ([dic objectForKey:@"isSign"] != [NSNull null]) && ([dic objectForKey:@"isSign"] != nil) ? [dic objectForKey:@"isSign"] : @"";
    account.telNumber = ([dic objectForKey:@"telNumber"] != [NSNull null]) && ([dic objectForKey:@"telNumber"] != nil) ? [dic objectForKey:@"telNumber"] : @"";
    account.markName = ([dic objectForKey:@"markName"] != [NSNull null]) && ([dic objectForKey:@"markName"] != nil) ? [dic objectForKey:@"markName"] : @"";

    account.num = ([dic objectForKey:@"num"] != [NSNull null]) && ([dic objectForKey:@"num"] != nil) ? [dic objectForKey:@"num"] : @"";
    account.birthday = ([dic objectForKey:@"birthday"] != [NSNull null]) && ([dic objectForKey:@"birthday"] != nil) ? [dic objectForKey:@"birthday"] : @"";
    account.token = ([dic objectForKey:@"token"] != [NSNull null]) && ([dic objectForKey:@"token"] != nil) ? [dic objectForKey:@"token"] : @"";
    account.signature = ([dic objectForKey:@"signature"] != [NSNull null]) && ([dic objectForKey:@"signature"] != nil) ? [dic objectForKey:@"signature"] : @"";
    account.sex = ([dic objectForKey:@"sex"] != [NSNull null]) && ([dic objectForKey:@"sex"] != nil) ? [dic objectForKey:@"sex"] : @"";
    account.address = ([dic objectForKey:@"address"] != [NSNull null]) && ([dic objectForKey:@"address"] != nil) ? [dic objectForKey:@"address"] : @"";

    account.userNum = ([dic objectForKey:@"userNum"] != [NSNull null]) && ([dic objectForKey:@"userNum"] != nil) ? [dic objectForKey:@"userNum"] : @"";
    account.cityId = ([dic objectForKey:@"cityId"] != [NSNull null]) && ([dic objectForKey:@"cityId"] != nil) ? [dic objectForKey:@"cityId"] : @"";
    account.communityId = ([dic objectForKey:@"communityId"] != [NSNull null]) && ([dic objectForKey:@"communityId"] != nil) ? [dic objectForKey:@"communityId"] : @"";
    account.cityName = ([dic objectForKey:@"cityName"] != [NSNull null]) && ([dic objectForKey:@"cityName"] != nil) ? [dic objectForKey:@"cityName"] : @"";
    account.communityName = ([dic objectForKey:@"communityName"] != [NSNull null]) && ([dic objectForKey:@"communityName"] != nil) ? [dic objectForKey:@"communityName"] : @"";

    return account;
}

@end
