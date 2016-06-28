//
//  SystemModel.m
//  Common
//
//  Created by 我 on 15/6/19.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SystemModel.h"

@implementation SystemModel

- (id)copyWithZone:(NSZone *)zone
{
    SystemModel *system = [[[self class] allocWithZone:zone] init];
    
    system.result = [self.result copy];
    
    return system;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.result forKey:@"result"];
 
 
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.result = [aDecoder decodeObjectForKey:@"result"];
 
    }
    return self;
}

+ (SystemModel *)JsonParse:(NSDictionary *)dic{
    SystemModel * system = [[SystemModel alloc] init];
    
    system.result = ([dic objectForKey:@"result"] != [NSNull null])&&([dic objectForKey:@"result"] !=nil) ? [dic objectForKey:@"result"]: @"";
//    index.tribeId = ([dic objectForKey:@"tribeId"] != [NSNull null])&&([dic objectForKey:@"tribeId"] !=nil) ? [[dic objectForKey:@"tribeId"] integerValue] :0;
 
 
    return system;
}

@end
