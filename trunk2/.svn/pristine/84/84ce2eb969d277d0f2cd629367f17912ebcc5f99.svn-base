//
//  TribeListModel.m
//  Common
//
//  Created by Owen on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeListModel.h"
#import "TribeIndexModel.h"

@implementation TribeListModel
- (id)copyWithZone:(NSZone *)zone
{
    TribeListModel *copy = [[[self class] allocWithZone:zone] init];
    copy.count = self.count;
    copy.attentionTribelist = [self.attentionTribelist copy];
    copy.recommendTribelist = [self.recommendTribelist copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.count forKey:@"count"];
    [aCoder encodeObject:self.attentionTribelist forKey:@"attentionTribelist"];
    [aCoder encodeObject:self.recommendTribelist forKey:@"recommendTribelist"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.count = [aDecoder decodeIntegerForKey:@"count"];
        self.attentionTribelist = [aDecoder decodeObjectForKey:@"attentionTribelist"];
        self.recommendTribelist = [aDecoder decodeObjectForKey:@"recommendTribelist"];
    }
    return self;
}

+ (TribeListModel *)JsonParse:(NSDictionary *)dic{
    TribeListModel * list = [[TribeListModel alloc] init];
    
    list.count = ([dic objectForKey:@"count"] != [NSNull null])&&([dic objectForKey:@"count"] !=nil) ? [[dic objectForKey:@"count"] integerValue] : 0;
    
    NSArray *attentionTribelist=[dic objectForKey:@"attentionTribelist"];
    if (attentionTribelist) {
        NSMutableArray *dataArray=[[NSMutableArray alloc]initWithCapacity:0];
        for (id data in attentionTribelist) {
            [dataArray addObject:[TribeIndexModel JsonParse:data]];
        }
        list.attentionTribelist=dataArray;
    }
    
    NSArray *recommendTribelist=[dic objectForKey:@"recommendTribelist"];
    if (recommendTribelist) {
        NSMutableArray *dataArray=[[NSMutableArray alloc]initWithCapacity:0];
        for (id data in recommendTribelist) {
            [dataArray addObject:[TribeIndexModel JsonParse:data]];
        }
        list.recommendTribelist=dataArray;
    }

    return list;
}

@end
