//
//  ShareModel.m
//  Common
//
//  Created by zhouwengang on 15/5/26.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel
-(id)copyWithZone:(NSZone *)zone{
    ShareModel *share=[[ShareModel alloc]init];
    share.courrentNum=self.courrentNum;
    share.endTimeStr=[self.endTimeStr copy];
    share.hasMoney=self.hasMoney;
    share.logoImg=[self.logoImg copy];
    share.makeMoney=self.makeMoney;
    share.maxMoney=self.maxMoney;
    share.mid=self.mid;
    share.money=self.money;
    share.myCent=self.myCent;
    share.myCentMoney=self.myCentMoney;
    share.name=[self.name copy];
    share.nickName=[self.nickName copy];
    share.oSmallImageUrl=[self.oSmallImageUrl copy];
    share.readerCent=self.readerCent;
    share.readerCentMoney=self.readerCentMoney;
    share.shareId=self.shareId;
    share.shareRuleid=self.shareRuleid;
    share.shengMoney=self.shengMoney;
    share.smallImageUrl=[self.smallImageUrl copy];
    share.startTimeStr=[self.startTimeStr copy];
    share.stauts=self.stauts;
    share.sumMoney=share.sumMoney;
    share.title=[self.title copy];
    share.userId=self.userId;
    share.username=[self.username copy];
    
    share.parentProfit = [self.parentProfit copy];
    share.myProfit = [self.myProfit copy];
    share.regUrl = [self.regUrl copy];
    return share;
    
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt64:self.courrentNum forKey:@"courrentNum"];
    
    [aCoder encodeInt64:self.hasMoney forKey:@"hasMoney"];
    [aCoder encodeInt64:self.makeMoney forKey:@"makeMoney"];
    [aCoder encodeInt64:self.maxMoney forKey:@"maxMoney"];
    [aCoder encodeInt64:self.mid forKey:@"mid"];
    [aCoder encodeInt64:self.money forKey:@"money"];
    [aCoder encodeInt64:self.myCent forKey:@"myCent"];
    [aCoder encodeInt64:self.myCentMoney forKey:@"myCentMoney"];
    [aCoder encodeInt64:self.readerCent forKey:@"readerCent"];
    [aCoder encodeInt64:self.readerCentMoney forKey:@"readerCentMoney"];    [aCoder encodeInt64:self.shareId forKey:@"shareId"];    [aCoder encodeInt64:self.shareRuleid forKey:@"shareRuleid"];
    [aCoder encodeInt64:self.shengMoney forKey:@"shengMoney"];
    [aCoder encodeInt64:self.stauts forKey:@"stauts"];
    [aCoder encodeInt64:self.sumMoney forKey:@"sumMoney"];        [aCoder encodeInt64:self.userId forKey:@"userId"];
    
    
    [aCoder encodeObject:self.endTimeStr  forKey:@"endTimeStr"];
    [aCoder encodeObject:self.logoImg forKey:@"logoImg"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.oSmallImageUrl forKey:@"oSmallImageUrl"];
    [aCoder encodeObject:self.smallImageUrl forKey:@"smallImageUrl"];
    [aCoder encodeObject:self.startTimeStr forKey:@"startTimeStr"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.title forKey:@"title"];
    
    [aCoder encodeObject:self.parentProfit forKey:@"parentProfit"];
    [aCoder encodeObject:self.myProfit forKey:@"myProfit"];
    [aCoder encodeObject:self.regUrl forKey:@"regUrl"];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        self.endTimeStr=[aDecoder decodeObjectForKey:@"endTimeStr"];
        self.logoImg=[aDecoder decodeObjectForKey:@"logoImg"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.nickName=[aDecoder decodeObjectForKey:@"nickName"];
        self.oSmallImageUrl=[aDecoder decodeObjectForKey:@"oSmallImageUrl"];
        self.smallImageUrl=[aDecoder decodeObjectForKey:@"smallImageUrl"];
        self.startTimeStr=[aDecoder decodeObjectForKey:@"startTimeStr"];
        self.title=[aDecoder decodeObjectForKey:@"title"];
        self.username=[aDecoder decodeObjectForKey:@"username"];
        
        
        self.courrentNum=[aDecoder decodeIntegerForKey:@"courrentNum"];
        self.hasMoney=[aDecoder decodeIntegerForKey:@"hasMoney"];
        self.makeMoney=[aDecoder decodeIntegerForKey:@"makeMoney"];
        self.mid=[aDecoder decodeIntegerForKey:@"mid"];
        self.money=[aDecoder decodeIntegerForKey:@"money"];
        self.myCent=[aDecoder decodeIntegerForKey:@"myCent"];
        self.myCentMoney=[aDecoder decodeIntegerForKey:@"myCentMoney"];
        self.readerCent=[aDecoder decodeIntegerForKey:@"readerCent"];
        self.readerCentMoney=[aDecoder decodeIntegerForKey:@"readerCentMoney"];
        self.shareId=[aDecoder decodeIntegerForKey:@"shareId"];
        self.shareRuleid=[aDecoder decodeIntegerForKey:@"shareRuleid"];
        self.shengMoney=[aDecoder decodeIntegerForKey:@"shengMoney"];
        ;
        self.stauts=[aDecoder decodeIntegerForKey:@"stauts"];
        ;
        self.sumMoney=[aDecoder decodeIntegerForKey:@"sumMoney"];
        ;
        self.userId=[aDecoder decodeIntegerForKey:@"userId"];
        
        
        self.parentProfit=[aDecoder decodeObjectForKey:@"parentProfit"];
        self.myProfit=[aDecoder decodeObjectForKey:@"myProfit"];
        self.regUrl=[aDecoder decodeObjectForKey:@"regUrl"];
    }
    
    
    return self;
    
}

+(ShareModel *)JsonParse:(NSDictionary *)dict{
    ShareModel *share=[[ShareModel alloc]init];
    
    share.endTimeStr=([dict objectForKey:@"endTimeStr"] !=[NSNull null]) &&([dict objectForKey:@"endTimeStr"] !=nil) ?[dict objectForKey:@"endTimeStr"]:@"";
    share.logoImg=([dict objectForKey:@"logoImg"] !=[NSNull null]) &&([dict objectForKey:@"logoImg"] !=nil) ?[dict objectForKey:@"logoImg"]:@"";
    share.name=([dict objectForKey:@"name"] !=[NSNull null]) &&([dict objectForKey:@"name"] !=nil) ?[dict objectForKey:@"projectName"]:@"";
    share.nickName=([dict objectForKey:@"nickName"] !=[NSNull null]) &&([dict objectForKey:@"nickName"] !=nil) ?[dict objectForKey:@"nickName"]:@"";
    share.oSmallImageUrl=([dict objectForKey:@"oSmallImageUrl"] !=[NSNull null]) &&([dict objectForKey:@"oSmallImageUrl"] !=nil) ?[dict objectForKey:@"oSmallImageUrl"]:@"";
    share.smallImageUrl=([dict objectForKey:@"smallImageUrl"] !=[NSNull null]) &&([dict objectForKey:@"smallImageUrl"] !=nil) ?[dict objectForKey:@"smallImageUrl"]:@"";
    share.startTimeStr=([dict objectForKey:@"startTimeStr"] !=[NSNull null]) &&([dict objectForKey:@"startTimeStr"] !=nil) ?[dict objectForKey:@"startTimeStr"]:@"";
    share.title=([dict objectForKey:@"title"] !=[NSNull null]) &&([dict objectForKey:@"title"] !=nil) ?[dict objectForKey:@"title"]:@"";
    share.username=([dict objectForKey:@"username"] !=[NSNull null]) &&([dict objectForKey:@"username"] !=nil) ?[dict objectForKey:@"username"]:@"";
    
    
    share.courrentNum=([dict objectForKey:@"courrentNum"] !=[NSNull null]) &&([dict objectForKey:@"courrentNum"] !=nil) ?[[dict objectForKey:@"courrentNum"] integerValue]:0;
    share.hasMoney=([dict objectForKey:@"hasMoney"] !=[NSNull null]) &&([dict objectForKey:@"hasMoney"] !=nil) ?[[dict objectForKey:@"hasMoney"] integerValue]:0;
    share.makeMoney=([dict objectForKey:@"makeMoney"] !=[NSNull null]) &&([dict objectForKey:@"makeMoney"] !=nil) ?[[dict objectForKey:@"makeMoney"] integerValue]:0;
    share.maxMoney=([dict objectForKey:@"maxMoney"] !=[NSNull null]) &&([dict objectForKey:@"maxMoney"] !=nil) ?[[dict objectForKey:@"maxMoney"] integerValue]:0;
    share.mid=([dict objectForKey:@"mid"] !=[NSNull null]) &&([dict objectForKey:@"mid"] !=nil) ?[[dict objectForKey:@"mid"] integerValue]:0;
    share.money=([dict objectForKey:@"money"] !=[NSNull null]) &&([dict objectForKey:@"money"] !=nil) ?[[dict objectForKey:@"money"] integerValue]:0;
    share.myCent=([dict objectForKey:@"myCent"] !=[NSNull null]) &&([dict objectForKey:@"myCent"] !=nil) ?[[dict objectForKey:@"myCent"] integerValue]:0;
    share.myCentMoney=([dict objectForKey:@"myCentMoney"] !=[NSNull null]) &&([dict objectForKey:@"myCentMoney"] !=nil) ?[[dict objectForKey:@"myCentMoney"] integerValue]:0;
    share.readerCent=([dict objectForKey:@"readerCent"] !=[NSNull null]) &&([dict objectForKey:@"readerCent"] !=nil) ?[[dict objectForKey:@"readerCent"] integerValue]:0;
    share.readerCentMoney=([dict objectForKey:@"readerCentMoney"] !=[NSNull null]) &&([dict objectForKey:@"readerCentMoney"] !=nil) ?[[dict objectForKey:@"readerCentMoney"] integerValue]:0;
    share.shareId=([dict objectForKey:@"shareId"] !=[NSNull null]) &&([dict objectForKey:@"shareId"] !=nil) ?[[dict objectForKey:@"shareId"] integerValue]:0;
    share.shareRuleid=([dict objectForKey:@"shareRuleid"] !=[NSNull null]) &&([dict objectForKey:@"shareRuleid"] !=nil) ?[[dict objectForKey:@"shareRuleid"] integerValue]:0;
    share.shengMoney=([dict objectForKey:@"shengMoney"] !=[NSNull null]) &&([dict objectForKey:@"shengMoney"] !=nil) ?[[dict objectForKey:@"shengMoney"] integerValue]:0;
    share.stauts=([dict objectForKey:@"stauts"] !=[NSNull null]) &&([dict objectForKey:@"stauts"] !=nil) ?[[dict objectForKey:@"stauts"] integerValue]:0;
    share.sumMoney=([dict objectForKey:@"sumMoney"] !=[NSNull null]) &&([dict objectForKey:@"sumMoney"] !=nil) ?[[dict objectForKey:@"sumMoney"] integerValue]:0;
    share.userId=([dict objectForKey:@"userId"] !=[NSNull null]) &&([dict objectForKey:@"userId"] !=nil) ?[[dict objectForKey:@"userId"] integerValue]:0;
    
    share.parentProfit=([dict objectForKey:@"parentProfit"] !=[NSNull null]) &&([dict objectForKey:@"parentProfit"] !=nil) ?[dict objectForKey:@"parentProfit"]:@"";
    share.myProfit=([dict objectForKey:@"myProfit"] !=[NSNull null]) &&([dict objectForKey:@"myProfit"] !=nil) ?[dict objectForKey:@"myProfit"]:@"";
    share.regUrl=([dict objectForKey:@"regUrl"] !=[NSNull null]) &&([dict objectForKey:@"regUrl"] !=nil) ?[dict objectForKey:@"regUrl"]:@"";
    
    return share;
}


@end
