//
//  RecommendModel.m
//  Common
//
//  Created by zhouwengang on 15/6/18.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel 

-(id)copyWithZone:(NSZone *)zone{
    RecommendModel *recommend=[[RecommendModel alloc]init];
    recommend.imageUrl = [self.imageUrl copy];
    recommend.projectAddress = [self.projectAddress copy];
    recommend.projectDesc = [self.projectDesc copy];
    recommend.projectId = [self.projectId copy];
    recommend.projectName = [self.projectName copy];
    recommend.retateMoney = [self.retateMoney copy];
    return  recommend;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.projectAddress forKey:@"projectAddress"];
    [aCoder encodeObject:self.projectDesc forKey:@"projectDesc"];
    [aCoder encodeObject:self.projectId forKey:@"projectId"];
    [aCoder encodeObject:self.projectName forKey:@"projectName"];
    [aCoder encodeObject:self.retateMoney forKey:@"retateMoney"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.projectAddress = [aDecoder decodeObjectForKey:@"projectAddress"];
        self.projectDesc = [aDecoder decodeObjectForKey:@"projectDesc"];
        self.projectId = [aDecoder decodeObjectForKey:@"projectId"];
        self.projectName = [aDecoder decodeObjectForKey:@"projectName"];
        self.retateMoney=[aDecoder decodeObjectForKey:@"retateMoney"];
        
    }
    return self;
}


+(RecommendModel *)JsonParse:(NSDictionary *)dict{
    RecommendModel *recommend=[[RecommendModel alloc]init];
    recommend.imageUrl=([dict objectForKey:@"imageUrl"] !=[NSNull null])&&([dict objectForKey:@"imageUrl"] !=nil)?[dict objectForKey:@"imageUrl"]:@"";
    recommend.projectAddress=([dict objectForKey:@"projectAddress"] !=[NSNull null])&&([dict objectForKey:@"projectAddress"] !=nil)?[dict objectForKey:@"projectAddress"]:@"";
    recommend.projectDesc=([dict objectForKey:@"projectDesc"] !=[NSNull null])&&([dict objectForKey:@"projectDesc"] !=nil)?[dict objectForKey:@"projectDesc"]:@"";
    recommend.projectId=([dict objectForKey:@"projectId"] !=[NSNull null])&&([dict objectForKey:@"projectId"] !=nil)?[dict objectForKey:@"projectId"]:@"";
    recommend.projectName=([dict objectForKey:@"projectName"] !=[NSNull null])&&([dict objectForKey:@"projectName"] !=nil)?[dict objectForKey:@"projectName"]:@"";
    recommend.retateMoney=([dict objectForKey:@"retateMoney"] !=[NSNull null])&&([dict objectForKey:@"retateMoney"] !=nil)?[dict objectForKey:@"retateMoney"]:@"";
    
    
    return recommend;
}

@end
