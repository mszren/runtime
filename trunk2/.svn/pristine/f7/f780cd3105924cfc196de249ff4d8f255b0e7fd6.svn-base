//
//  QDModel.m
//  Common
//
//  Created by zhouwengang on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "QDModel.h"

@implementation QDModel
-(id)copyWithZone:(NSZone *)zone{
    QDModel *qdmodel=[[QDModel alloc]init];
    qdmodel.signMessage = [self.signMessage copy];
    qdmodel.flag = [self.flag copy];
    qdmodel.priceTotal = [self.priceTotal copy];
     qdmodel.signMoney = [self.signMoney copy];
    qdmodel.signPrice = self.signPrice;
    return  qdmodel;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.signMessage forKey:@"signMessage"];
    [aCoder encodeInt64:self.signPrice forKey:@"signPrice"];
     [aCoder encodeObject:self.flag forKey:@"flag"];
    [aCoder encodeObject:self.signMoney forKey:@"signMoney"];
     [aCoder encodeObject:self.signMessage forKey:@"priceTotal"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.signMessage = [aDecoder decodeObjectForKey:@"signMessage"];
        self.signPrice = [aDecoder decodeInt64ForKey:@"signPrice"];
        self.flag = [aDecoder decodeObjectForKey:@"flag"];
         self.signMoney = [aDecoder decodeObjectForKey:@"signMoney"];
        self.priceTotal = [aDecoder decodeObjectForKey:@"priceTotal"];
        
    }
    return self;
}

+(QDModel *)JsonParse:(NSDictionary *)dict{
    QDModel *qdmodel=[[QDModel alloc]init];
    qdmodel.priceTotal=([dict objectForKey:@"priceTotal"] !=[NSNull null])&&([dict objectForKey:@"priceTotal"] !=nil)?[dict objectForKey:@"priceTotal"]:@"";
    
     qdmodel.flag=([dict objectForKey:@"flag"] !=[NSNull null])&&([dict objectForKey:@"flag"] !=nil)?[dict objectForKey:@"flag"]:@"";
     qdmodel.signMoney=([dict objectForKey:@"signMoney"] !=[NSNull null])&&([dict objectForKey:@"signMoney"] !=nil)?[dict objectForKey:@"signMoney"]:@"";
    
     qdmodel.signMessage=([dict objectForKey:@"signMessage"] !=[NSNull null])&&([dict objectForKey:@"signMessage"] !=nil)?[dict objectForKey:@"signMessage"]:@"";
    
    qdmodel.signPrice=([dict objectForKey:@"signPrice"] !=[NSNull null])&&([dict objectForKey:@"signPrice"] !=nil)?[[dict objectForKey:@"signPrice"]integerValue] :0;
    
    
    return qdmodel;
}

@end
