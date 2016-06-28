//
//  MyRedPacketModel.m
//  Common
//
//  Created by xj on 15/7/24.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "MyRedPacketModel.h"

@implementation MyRedPacketModel

+(MyRedPacketModel *)JsonParse:(NSDictionary *)dict{
    
    MyRedPacketModel *model=[[MyRedPacketModel alloc]init];
    model.prize = ([dict objectForKey:@"prize"] != [NSNull null])&&([dict objectForKey:@"prize"] !=nil) ? [[dict objectForKey:@"prize"] doubleValue]: 0;
    model.totalPrize = ([dict objectForKey:@"totalPrize"] != [NSNull null])&&([dict objectForKey:@"totalPrize"] !=nil) ? [[dict objectForKey:@"totalPrize"] doubleValue]  : 0;
    model.redPacketId = ([dict objectForKey:@"redPacketId"] != [NSNull null])&&([dict objectForKey:@"redPacketId"] !=nil) ? [[dict objectForKey:@"redPacketId"] integerValue] : 0;
    model.objectType = ([dict objectForKey:@"objectType"] != [NSNull null])&&([dict objectForKey:@"objectType"] !=nil) ? [[dict objectForKey:@"objectType"] integerValue] : 0;

    
    NSDictionary* entryTime=([dict objectForKey:@"entryTime"] != [NSNull null])&&([dict objectForKey:@"entryTime"] !=nil) ? [dict objectForKey:@"entryTime"] : nil;
    if(entryTime&&entryTime.count>0){
        NSString* times=([entryTime objectForKey:@"time"] != [NSNull null])&&([entryTime objectForKey:@"time"] !=nil) ? [entryTime objectForKey:@"time"] : @"";
        if(times){
            NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[times floatValue]/1000];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:nd];
            model.entryTime=dateString;
        }
    }
    model.nickName=([dict objectForKey:@"nickName"] !=[NSNull null])&&([dict objectForKey:@"nickName"] !=nil)?[dict objectForKey:@"nickName"]:@"";
    return model;
}


@end
