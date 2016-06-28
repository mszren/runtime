//
//  MyYaoyouModel.m
//  Common
//
//  Created by Owen on 15/7/29.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyYaoyouModel.h"

@implementation MyYaoyouModel

- (id)copyWithZone:(NSZone*)zone
{
    MyYaoyouModel* copy = [[[self class] allocWithZone:zone] init];
    copy.oneFriendNumber = self.oneFriendNumber;
    copy.twoFriendNumber = self.twoFriendNumber;
    copy.threeFriendNumber = self.threeFriendNumber;
    return copy;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeInteger:self.oneFriendNumber forKey:@"oneFriendNumber"];
    [aCoder encodeInteger:self.twoFriendNumber forKey:@"twoFriendNumber"];
    [aCoder encodeInteger:self.threeFriendNumber forKey:@"threeFriendNumber"];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        self.oneFriendNumber = [aDecoder decodeIntegerForKey:@"oneFriendNumber"];
        self.twoFriendNumber = [aDecoder decodeIntegerForKey:@"twoFriendNumber"];
        self.threeFriendNumber = [aDecoder decodeIntegerForKey:@"threeFriendNumber"];
    }
    return self;
}

+ (MyYaoyouModel*)JsonParse:(NSDictionary*)dic
{
    MyYaoyouModel* myYaoyou = [[MyYaoyouModel alloc] init];

    myYaoyou.oneFriendNumber = ([dic objectForKey:@"oneFriendNumber"] != [NSNull null]) && ([dic objectForKey:@"oneFriendNumber"] != nil) ? [[dic objectForKey:@"oneFriendNumber"] integerValue] : 0;
    myYaoyou.twoFriendNumber = ([dic objectForKey:@"twoFriendNumber"] != [NSNull null]) && ([dic objectForKey:@"twoFriendNumber"] != nil) ? [[dic objectForKey:@"twoFriendNumber"] integerValue] : 0;
    myYaoyou.threeFriendNumber = ([dic objectForKey:@"threeFriendNumber"] != [NSNull null]) && ([dic objectForKey:@"threeFriendNumber"] != nil) ? [[dic objectForKey:@"threeFriendNumber"] integerValue] : 0;
    return myYaoyou;
}
@end
