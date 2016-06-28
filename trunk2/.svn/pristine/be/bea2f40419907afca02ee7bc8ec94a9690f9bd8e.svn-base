//
//  UserTagModel.m
//  Common
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "UserTagModel.h"
#import "TagModel.h"

@implementation UserTagModel


- (id)copyWithZone:(NSZone *)zone
{
    UserTagModel *copy = [[[self class] allocWithZone:zone] init];
    copy.noAttentionList = [self.noAttentionList copy];
    copy.attentionList = [self.attentionList copy];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.noAttentionList forKey:@"noAttentionList"];
    [aCoder encodeObject:self.attentionList forKey:@"attentionList"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.noAttentionList = [aDecoder decodeObjectForKey:@"noAttentionList"];
        self.attentionList = [aDecoder decodeObjectForKey:@"attentionList"];
    }
    return self;
}

+ (UserTagModel *)JsonParse:(NSDictionary *)dic{
    UserTagModel * userTag = [[UserTagModel alloc] init];
    
    NSArray *noAttentionArr=[dic objectForKey:@"noAttentionList"];
    NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    if (noAttentionArr) {
        for(id data in noAttentionArr){
            [dataArray addObject:[TagModel JsonParse:data]];
        }
            userTag.noAttentionList=dataArray;
    }
    [dataArray removeAllObjects];
    NSArray * attentionArr=[dic objectForKey:@"attentionList"];
    
    if (attentionArr) {
        for(id data in attentionArr){
            [dataArray addObject:[TagModel JsonParse:data]];
        }
        userTag.attentionList=dataArray;
    }
    return userTag;
   }
@end
