//
//  HomeModel.m
//  Common
//
//  Created by zhouwengang on 15/5/26.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "IndexModel.h"
#import "TribeModel.h"
#import "TopicModel.h"
#import "ModuleModel.h"

@implementation IndexModel

-(id)copyWithZone:(NSZone *)zone{
    IndexModel *index=[[IndexModel alloc]init];
    index.tribe=[self.tribe copy];
    index.interaction=[self.interaction copy];
    index.carouselDiagramList=[self.carouselDiagramList copy];
    return index;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.tribe forKey:@"tribe"];
    [aCoder encodeObject:self.interaction forKey:@"interaction"];
    [aCoder encodeObject:self.carouselDiagramList forKey:@"carouselDiagramList"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        self.tribe=[aDecoder decodeObjectForKey:@"tribe"];
        self.interaction=[aDecoder decodeObjectForKey:@"interaction"];
        self.carouselDiagramList=[aDecoder decodeObjectForKey:@"carouselDiagramList"];
    }
    return self;
}

+(IndexModel *)JsonParse:(NSDictionary *)dict{
    IndexModel *index=[[IndexModel alloc]init];
    if ([[dict objectForKey:@"tribe"] isKindOfClass:[NSArray class]]) {
        
        NSArray* tribe=[dict objectForKey:@"tribe"];
        NSMutableArray *dataArray=[[NSMutableArray alloc] initWithCapacity:0];
        for(id data in tribe){
            [dataArray addObject:[TribeModel JsonParse:data]];
        }
        index.tribe =dataArray;
        
    }

    if ([[dict objectForKey:@"interaction"]  isKindOfClass:[NSArray class]]) {
        
        NSArray *interaction=[dict objectForKey:@"interaction"];
        NSMutableArray *dataArry2=[[NSMutableArray alloc]initWithCapacity:0];
        for (id data in interaction) {
            [dataArry2 addObject:[TopicModel JsonParse:data]];
        }
        index.interaction=dataArry2;
        
    }
    
    if ([[dict objectForKey:@"carouselDiagramList"] isKindOfClass:[NSArray class]]) {
        NSArray *carouselDiagramList=[dict objectForKey:@"carouselDiagramList"];
        NSMutableArray *dataArry3=[[NSMutableArray alloc]initWithCapacity:0];
        for (id data3 in carouselDiagramList) {
            [dataArry3 addObject:[ModuleModel JsonParse:data3]];
        }
        index.carouselDiagramList=dataArry3;
    }
    

    
    return  index;
}

@end
