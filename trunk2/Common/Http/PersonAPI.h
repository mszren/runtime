//
//  APISDK+Person.h
//  Common
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "NetConnection.h"

@interface PersonAPI : NetConnection

+ (ASIHTTPRequest*)getTribeInterActionByUserId:(NSInteger)userId typeId:(NSInteger)typeId
                                         title:(NSString*)title
                                    nextCursor:(NSInteger)nextCursor
                                      callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)addRecommendBrokerNew:(NSInteger)userId brokerName:(NSString*)brokerName brokerPhone:(NSString*)brokerName cardId:(NSString*)cardId
                                callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getRecommendBrokerdatailNew:(NSInteger)userId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getMyOrderList:(NSInteger)userId payStatus:(NSString*)payStatus nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)getMyCollectList:(NSString*)title type:(NSInteger)type nextCursor:(NSInteger)nextCursor userId:(NSInteger)userId callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getNewMyGetRedPacket:(NSInteger)userId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getNewMyFaSongRedPacket:(NSInteger)userId nextCursor:(NSInteger)nextCursor callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getMyYaoyou:(NSInteger)userId callback:(NetConnBlock)callback;

+ (ASIHTTPRequest*)deleteMyOrder:(NSString *)orderNum  callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)deleteMyCollect:(NSString *)collectId  callback:(NetConnBlock)callback;
+ (ASIHTTPRequest*)getRefundInfoByMobile:(NSString *)orderId  callback:(NetConnBlock)callback;
@end
