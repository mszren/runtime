//
//  TribeIndexModel.m
//  Common
//
//  Created by Owen on 15/6/4.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeIndexModel.h"

@implementation TribeIndexModel

- (id)copyWithZone:(NSZone *)zone
{
    TribeIndexModel *copy = [[[self class] allocWithZone:zone] init];
    
     copy.content = [self.content copy];
    copy.tribeId =  self. tribeId;
    copy.publishId = self.publishId;
     copy.totalCount = self.totalCount;
     copy.shopName = [self.shopName copy];
     copy.shopImage = [self.shopImage copy];
     copy.typeId = self.typeId;
    
     copy.interactioncount = self.interactioncount;
     copy.activitycount = self.activitycount;
     copy.attentionNum = self.attentionNum;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeInt64:self.tribeId forKey:@"tribeId"];
    [aCoder encodeInt64:self.publishId forKey:@"publishId"];
    
    [aCoder encodeInt64:self.totalCount forKey:@"totalCount"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    [aCoder encodeObject:self.shopImage forKey:@"shopImage"];
    
    [aCoder encodeInt64:self.interactioncount forKey:@"interactioncount"];
    [aCoder encodeInt64:self.activitycount forKey:@"activitycount"];
    [aCoder encodeInt64:self.attentionNum forKey:@"attentionNum"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.tribeId =  [aDecoder decodeInt64ForKey:@"tribeId"];
        self.publishId = [aDecoder decodeInt64ForKey:@"publishId"];
        
        self.totalCount =[aDecoder decodeInt64ForKey:@"totalCount"];
        self.shopName = [aDecoder decodeObjectForKey:@"shopName"];
        self.shopImage = [aDecoder decodeObjectForKey:@"shopImage"];
        self.typeId = [aDecoder decodeInt64ForKey:@"typeId"];
        
        self.interactioncount = [aDecoder decodeInt64ForKey:@"interactioncount"];
        self.activitycount = [aDecoder decodeInt64ForKey:@"activitycount"];
        self.attentionNum = [aDecoder decodeInt64ForKey:@"attentionNum"];
    }
    return self;
}

+ (TribeIndexModel *)JsonParse:(NSDictionary *)dic{
    TribeIndexModel * index = [[TribeIndexModel alloc] init];
    
    index.content = ([dic objectForKey:@"content"] != [NSNull null])&&([dic objectForKey:@"content"] !=nil) ? [dic objectForKey:@"content"]: @"";
    index.tribeId = ([dic objectForKey:@"tribeId"] != [NSNull null])&&([dic objectForKey:@"tribeId"] !=nil) ? [[dic objectForKey:@"tribeId"] integerValue] :0;
    index.publishId = ([dic objectForKey:@"publishId"] != [NSNull null])&&([dic objectForKey:@"publishId"] !=nil) ? [[dic objectForKey:@"publishId"] integerValue] :0;
    
    index.totalCount = ([dic objectForKey:@"totalCount"] != [NSNull null])&&([dic objectForKey:@"totalCount"] !=nil) ? [[dic objectForKey:@"totalCount"] integerValue ]:0;
    
    index.shopName = ([dic objectForKey:@"shopName"] != [NSNull null])&&([dic objectForKey:@"shopName"] !=nil) ? [dic objectForKey:@"shopName"] : @"";
    
    index.shopImage = ([dic objectForKey:@"shopImage"] != [NSNull null])&&([dic objectForKey:@"shopImage"] !=nil) ? [dic objectForKey:@"shopImage"] : @"";
    
    index.typeId = ([dic objectForKey:@"typeId"] != [NSNull null])&&([dic objectForKey:@"typeId"] !=nil) ? [[dic objectForKey:@"typeId"] integerValue]: 0;
    
    index.interactioncount = ([dic objectForKey:@"interactioncount"] != [NSNull null])&&([dic objectForKey:@"interactioncount"] !=nil) ? [[dic objectForKey:@"interactioncount"] integerValue] : 0;
    
    index.activitycount = ([dic objectForKey:@"activitycount"] != [NSNull null])&&([dic objectForKey:@"activitycount"] !=nil) ? [[dic objectForKey:@"activitycount"] integerValue]: 0;
    
    index.attentionNum = ([dic objectForKey:@"attentionNum"] != [NSNull null])&&([dic objectForKey:@"attentionNum"] !=nil) ? [[dic objectForKey:@"attentionNum"] integerValue] : 0;
    return index;
}

@end
