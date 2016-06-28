//
//  GoodsDetailService.h
//  Common
//
//  Created by zhouwengang on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "BaseService.h"

@interface ShopsService : BaseService
//商品详情
- (ASIHTTPRequest*)getGoodsInfoV2:(NSInteger)goodId userId:(NSInteger)userId
                        OnSuccess:(onSuccess)onSuccess;

//附近的商家
- (ASIHTTPRequest*)getNearTribeGoodsList:(NSString*)shopName shoptypes:(NSString *)types nextCursor:(NSInteger)nextCursor mapX:(NSString*)mapX mapY:(NSString*)mapY OnSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getRecommendTribeGoodsList:(NSString*)shopName shoptypes:(NSString *)types nextCursor:(NSInteger)nextCursor mapX:(NSString*)mapX mapY:(NSString*)mapY OnSuccess:(onSuccess)onSuccess;

//商家首页
- (ASIHTTPRequest*)getTribeGoodsList:(NSString*)shopName shoptypes:(NSString *)types nextCursor:(NSInteger)nextCursor mapX:(NSString*)mapX mapY:(NSString*)mapY OnSuccess:(onSuccess)onSuccess;

//添加评论
- (ASIHTTPRequest*)addOneCommentInfoV2:(NSInteger)objectId type:(NSInteger)type content:(NSString*)content userId:(NSInteger)userId starNum:(NSInteger)starNum parentId:(NSInteger)parentId imageUrls:(NSString*)imageUrls shopId:(NSInteger)shopId orderId:(NSInteger)orderId OnSuccess:(onSuccess)onSuccess;

//评论列表
- (ASIHTTPRequest*)getCommentInfoListV2:(NSInteger)objectId type:(NSInteger)type nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

//商家分类
- (ASIHTTPRequest*)getTribeCategory:(onSuccess)onSuccess;

//获取可使用帮币数
- (ASIHTTPRequest*)getCouldUseBangBiCountV2:(NSInteger)goodsId userId:(NSInteger)userId onSuccess:(onSuccess)onSuccess;

//

- (ASIHTTPRequest*)checkBangBiCountV2:(NSInteger)count userId:(NSInteger)userId nextCursor:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)saveGoodsOrderFormInfo:(NSInteger)userId goodsId:(NSInteger)goodsId shopId:(NSInteger)shopId onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)payGoodsOrderForm:(NSInteger)userId orderNum:(NSString*)orderNum isBb:(NSInteger)isBb payMoney:(NSInteger)paymoney leaveWords:(NSString*)leaveWords buyBbTotal:(NSInteger)buyBbTotal onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)writePayInfoIntoMySql:(NSString*)orderNum resultCode:(NSInteger)resultCode sellerId:(NSString*)sellerId partner:(NSString*)partner totalfee:(NSString *)totalfee payflag:(NSString *)payflag onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)canclePay:(NSInteger)orderNum onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)getMoreGoodsFrontPageV2:(NSInteger)nextCursor onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)objectAddLikeV2:(NSInteger)userId objectId:(NSInteger)objectId type:(NSInteger)type onSuccess:(onSuccess)onSuccess;

- (ASIHTTPRequest*)cancleOrderV2:(NSString*)orderNum onSuccess:(onSuccess)onSuccess;

+ (instancetype)shareInstance;
@end
