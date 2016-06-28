//
//  MsgListModel.m
//  Common
//
//  Created by Owen on 15/5/27.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MsgListModel.h"
#import "MsgModel.h"

@implementation MsgListModel

- (id)copyWithZone:(NSZone *)zone
{
    MsgListModel *copy = [[[self class] allocWithZone:zone] init];
    copy.count = self.count;
    copy.name = [self.name copy];
    copy.lcdList = [self.lcdList copy];
    copy.payType = [self.payType copy];
    copy.mybanlance = self.mybanlance;
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.count forKey:@"count"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.lcdList forKey:@"lcdList"];
    [aCoder encodeObject:self.payType forKey:@"payType"];
    [aCoder encodeInt64:self.mybanlance forKey:@"mybanlance"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.count = [aDecoder decodeIntegerForKey:@"count"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.lcdList = [aDecoder decodeObjectForKey:@"lcdList"];
        self.payType = [aDecoder decodeObjectForKey:@"payType"];
        self.mybanlance = [aDecoder decodeIntegerForKey:@"mybanlance"];
    }
    return self;
}

+ (MsgListModel *)JsonParse:(NSDictionary *)dic{
    MsgListModel * msgList = [[MsgListModel alloc] init];
    
    msgList.count = ([dic objectForKey:@"count"] != [NSNull null])&&([dic objectForKey:@"count"] !=nil) ? [[dic objectForKey:@"count"] integerValue] : 0;
    msgList.name = ([dic objectForKey:@"name"] != [NSNull null])&&([dic objectForKey:@"name"] !=nil) ? [dic objectForKey:@"name"] : @"";
    msgList.mybanlance = ([dic objectForKey:@"mybanlance"] != [NSNull null])&&([dic objectForKey:@"mybanlance"] !=nil) ? [[dic objectForKey:@"mybanlance"] integerValue] : 0;
    msgList.payType = ([dic objectForKey:@"payType"] != [NSNull null])&&([dic objectForKey:@"payType"] !=nil) ? [dic objectForKey:@"payType"] : @"";

    NSArray *lcdList=[dic objectForKey:@"lcdList"];
    if (lcdList) {
        NSMutableArray *dataArray=[[NSMutableArray alloc]initWithCapacity:0];
        for (id data in lcdList) {
            [dataArray addObject:[MsgModel JsonParse:data]];
        }
        msgList.lcdList=dataArray;
    }
    return msgList;
}

@end
