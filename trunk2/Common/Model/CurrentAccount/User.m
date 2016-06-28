//
//  User.m
//  qeebuConference
//
//  Created by caoliang on 13-1-14.
//  Copyright (c) 2013年 _qeebu_. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize uid, username, nickname, face, isSign, telNumber, markName;
@synthesize num, birthday, token, signature, sex, address, userNum, cityId, communityId, cityName, communityName,imagePath;

- (id)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        if (dic) {
            self.uid = [dic objectForKey:@"uid"] != [NSNull null] ? [[dic objectForKey:@"uid"] integerValue] : 0;
            self.username = [dic objectForKey:@"username"] != [NSNull null] ? [dic objectForKey:@"username"] : @"";
            self.nickname = [dic objectForKey:@"nickname"] != [NSNull null] ? [dic objectForKey:@"nickname"] : @"";
            self.face = [dic objectForKey:@"face"] != [NSNull null] ? [dic objectForKey:@"face"] : @"";
            self.isSign = [dic objectForKey:@"isSign"] != [NSNull null] ? [dic objectForKey:@"isSign"] : @"";
            self.telNumber = [dic objectForKey:@"telNumber"] != [NSNull null] ? [dic objectForKey:@"telNumber"] : @"";
            self.markName = [dic objectForKey:@"markName"] != [NSNull null] ? [dic objectForKey:@"markName"] : @"";

            self.num = [dic objectForKey:@"num"] != [NSNull null] ? [dic objectForKey:@"num"] : @"";
            self.birthday = [dic objectForKey:@"birthday"] != [NSNull null] ? [dic objectForKey:@"birthday"] : @"";
            self.token = [dic objectForKey:@"token"] != [NSNull null] ? [dic objectForKey:@"token"] : @"";
            self.signature = [dic objectForKey:@"signature"] != [NSNull null] ? [dic objectForKey:@"signature"] : @"";
            self.sex = [dic objectForKey:@"sex"] != [NSNull null] ? [dic objectForKey:@"sex"] : @"";

            self.address = [dic objectForKey:@"address"] != [NSNull null] ? [dic objectForKey:@"address"] : @"";
            self.userNum = [dic objectForKey:@"userNum"] != [NSNull null] ? [dic objectForKey:@"userNum"] : @"";
            self.cityId = [dic objectForKey:@"cityId"] != [NSNull null] ? [dic objectForKey:@"cityId"] : @"";
            self.communityId = [dic objectForKey:@"communityId"] != [NSNull null] ? [dic objectForKey:@"communityId"] : @"";
            self.cityName = [dic objectForKey:@"cityName"] != [NSNull null] ? [dic objectForKey:@"cityName"] : @"";
            self.communityName = [dic objectForKey:@"communityName"] != [NSNull null] ? [dic objectForKey:@"communityName"] : @"";
            self.norel = [dic objectForKey:@"norel"] != [NSNull null] ? [dic objectForKey:@"norel"] : @"";
            self.yrel = [dic objectForKey:@"yrel"] != [NSNull null] ? [dic objectForKey:@"yrel"] : @"";
            self.isF = [dic objectForKey:@"isF"] != [NSNull null] ? [[dic objectForKey:@"isF"] integerValue] : 0;

            NSString* nick = [dic objectForKey:@"nick"] != [NSNull null] ? [dic objectForKey:@"nick"] : nil;
            if (nick) {
                self.nickname = nick;
            }

            NSString* name = [dic objectForKey:@"name"] != [NSNull null] ? [dic objectForKey:@"name"] : nil;
            if (name) {
                self.username = name;
            }

            NSString* lface = [dic objectForKey:@"face"] != [NSNull null] ? [dic objectForKey:@"face"] : nil;
            if (lface) {
                self.face = lface;
            }
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone
{
    User* copy = [[[self class] allocWithZone:zone] init];
    copy.uid = self.uid;
    copy.username = [self.username copy];
    copy.nickname = [self.nickname copy];
    copy.face = [self.face copy];
    copy.isSign = [self.isSign copy];
    copy.isF = self.isF;
    copy.telNumber = [self.telNumber copy];
    copy.markName = [self.markName copy];
    copy.token = [self.token copy];
    copy.norel = [self.norel copy];
    copy.yrel = [self.yrel copy];
    
    return copy;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeIntForKey:@"uid"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.face = [decoder decodeObjectForKey:@"face"];
        self.isSign = [decoder decodeObjectForKey:@"isSign"];
        self.telNumber = [decoder decodeObjectForKey:@"telNumber"];
        self.markName = [decoder decodeObjectForKey:@"markName"];
        self.isF = [decoder decodeIntForKey:@"isF"];
        self.num = [decoder decodeObjectForKey:@"num"];
        self.birthday = [decoder decodeObjectForKey:@"birthday"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.signature = [decoder decodeObjectForKey:@"signature"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.address = [decoder decodeObjectForKey:@"address"];

        self.userNum = [decoder decodeObjectForKey:@"userNum"];
        self.cityId = [decoder decodeObjectForKey:@"cityId"];
        self.communityId = [decoder decodeObjectForKey:@"communityId"];
        self.cityName = [decoder decodeObjectForKey:@"cityName"];
        self.communityName = [decoder decodeObjectForKey:@"communityName"];
        self.imagePath = [decoder decodeObjectForKey:@"imagePath"];
        self.norel = [decoder decodeObjectForKey:@"norel"];
        self.yrel = [decoder decodeObjectForKey:@"yrel"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.face forKey:@"face"];
    [encoder encodeObject:self.isSign forKey:@"isSign"];
    [encoder encodeObject:self.telNumber forKey:@"telNumber"];
    [encoder encodeObject:self.markName forKey:@"markName"];
    [encoder encodeInt64:self.isF forKey:@"isF"];
    [encoder encodeObject:self.num forKey:@"num"];
    [encoder encodeObject:self.birthday forKey:@"birthday"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.signature forKey:@"signature"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.address forKey:@"address"];

    [encoder encodeObject:self.userNum forKey:@"userNum"];
    [encoder encodeObject:self.cityId forKey:@"cityId"];
    [encoder encodeObject:self.communityId forKey:@"communityId"];
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.communityName forKey:@"communityName"];
    [encoder encodeObject:self.imagePath forKey:@"imagePath"];
    
    [encoder encodeObject:self.norel forKey:@"norel"];
    [encoder encodeObject:self.yrel forKey:@"yrel"];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"id= %lu , username=%@ , nickname=%@ , face=%@ , isF = %ld ,isSign = %@ , telNumber =%@, markName =%@", (long)self.uid, self.username, self.nickname, self.face, (long)self.isF, self.isSign, self.telNumber, self.markName];
}

+ (User*)JsonParse:(NSDictionary*)arr
{
    User* user = [[User alloc] init];
    if (arr != nil) {
        NSDictionary* dic = [arr objectForKey:@"user"];
        if (dic == nil) {
            dic = arr;
        }

        NSInteger uid = ([dic objectForKey:@"uid"] != [NSNull null]) && ([dic objectForKey:@"uid"] != nil) ? [[dic objectForKey:@"uid"] integerValue] : 0;
        NSInteger userId = ([dic objectForKey:@"userId"] != [NSNull null]) && ([dic objectForKey:@"userId"] != nil) ? [[dic objectForKey:@"userId"] integerValue] : 0;
        if (uid != 0) {
            user.uid = uid;
        }
        else if (userId != 0) {
            user.uid = userId;
        }

        user.username = ([dic objectForKey:@"username"] != [NSNull null]) && ([dic objectForKey:@"username"] != nil) ? [dic objectForKey:@"username"] : @"";
        user.nickname = ([dic objectForKey:@"nickname"] != [NSNull null]) && ([dic objectForKey:@"nickname"] != nil) ? [dic objectForKey:@"nickname"] : @"";
        user.face = ([dic objectForKey:@"face"] != [NSNull null]) && ([dic objectForKey:@"face"] != nil) ? [dic objectForKey:@"face"] : @"";
        user.isSign = ([dic objectForKey:@"isSign"] != [NSNull null]) && ([dic objectForKey:@"isSign"] != nil) ? [dic objectForKey:@"isSign"] : @"";
        user.telNumber = ([dic objectForKey:@"telNumber"] != [NSNull null]) && ([dic objectForKey:@"telNumber"] != nil) ? [dic objectForKey:@"telNumber"] : @"";
        user.markName = ([dic objectForKey:@"markName"] != [NSNull null]) && ([dic objectForKey:@"markName"] != nil) ? [dic objectForKey:@"markName"] : @"";

        user.num = ([dic objectForKey:@"num"] != [NSNull null]) && ([dic objectForKey:@"num"] != nil) ? [dic objectForKey:@"num"] : @"";
        NSDictionary* bir = ([dic objectForKey:@"birthday"] != [NSNull null]) && ([dic objectForKey:@"birthday"] != nil) ? [dic objectForKey:@"birthday"] : @"";
        if (![bir isEqual:@""]) {
            user.birthday = ([bir objectForKey:@"time"] != [NSNull null]) && ([bir objectForKey:@"time"] != nil) ? [bir objectForKey:@"time"] : @"";
        }

        user.token = ([dic objectForKey:@"token"] != [NSNull null]) && ([dic objectForKey:@"token"] != nil) ? [dic objectForKey:@"token"] : @"";
        user.signature = ([dic objectForKey:@"signature"] != [NSNull null]) && ([dic objectForKey:@"signature"] != nil) ? [dic objectForKey:@"signature"] : @"";
        user.sex = ([dic objectForKey:@"sex"] != [NSNull null]) && ([dic objectForKey:@"sex"] != nil) ? [dic objectForKey:@"sex"] : @"";
        user.address = ([dic objectForKey:@"address"] != [NSNull null]) && ([dic objectForKey:@"address"] != nil) ? [dic objectForKey:@"address"] : @"";

        user.userNum = ([dic objectForKey:@"userNum"] != [NSNull null]) && ([dic objectForKey:@"userNum"] != nil) ? [dic objectForKey:@"userNum"] : @"";
        user.cityId = ([dic objectForKey:@"cityId"] != [NSNull null]) && ([dic objectForKey:@"cityId"] != nil) ? [dic objectForKey:@"cityId"] : @"";
        user.communityId = ([dic objectForKey:@"communityId"] != [NSNull null]) && ([dic objectForKey:@"communityId"] != nil) ? [dic objectForKey:@"communityId"] : @"";
        user.cityName = ([dic objectForKey:@"cityName"] != [NSNull null]) && ([dic objectForKey:@"cityName"] != nil) ? [dic objectForKey:@"cityName"] : @"";
        user.communityName = ([dic objectForKey:@"communityName"] != [NSNull null]) && ([dic objectForKey:@"communityName"] != nil) ? [dic objectForKey:@"communityName"] : @"";
        
                user.norel = ([dic objectForKey:@"norel"] != [NSNull null]) && ([dic objectForKey:@"norel"] != nil) ? [dic objectForKey:@"norel"] : @"";
                user.yrel = ([dic objectForKey:@"yrel"] != [NSNull null]) && ([dic objectForKey:@"yrel"] != nil) ? [dic objectForKey:@"yrel"] : @"";

        user.isF = ([arr objectForKey:@"isFav"] != [NSNull null]) && ([arr objectForKey:@"isFav"] != nil) ? [[arr objectForKey:@"isFav"] integerValue] : 0;
    }
    return user;
}

@end
