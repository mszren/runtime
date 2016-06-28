//
//  OrderListModel.h
//  Common
//
//  Created by zhouwengang on 15/5/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
/**
 *  订单
 */
@interface OrderModel : NSObject  <NSCoding>
@property (nonatomic,strong)NSString *consigneePhone;
@property (nonatomic,assign)NSInteger goodsId;
@property (nonatomic,assign)NSInteger originalPrice;
@property (nonatomic,assign)NSInteger goodsPrice;
@property (nonatomic,strong)NSString *imagename;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *shopname;
@property (nonatomic,assign)NSInteger shopId;
@property (nonatomic,strong)NSString *goodsname;
@property (nonatomic,strong)NSString *goodsTitle;
@property (nonatomic,assign)NSInteger createTime;
@property (nonatomic,assign)double buyBbTotal;
@property (nonatomic,assign)NSInteger payStatus;
@property (nonatomic,assign)NSInteger totalPrice;
@property (nonatomic,strong)NSString  *leaveWords;
@property (nonatomic,assign)NSInteger orderId;
@property (nonatomic,strong)NSString *orderNum;

@property (nonatomic,assign)NSInteger bangbi;
@property (nonatomic,strong)GoodsModel *goods;

@property (nonatomic,copy)NSString *customerNum;
@property (nonatomic,copy)NSString *goodsName;
@property (nonatomic,copy)NSString *notice;
@property (nonatomic,assign)NSInteger payType;
@property (nonatomic,copy)NSString *shopImage;
@property (nonatomic,copy)NSString *shopName;
@property (nonatomic,assign)NSInteger status;
 

+(OrderModel *)JsonParse:(NSDictionary *)dict;
@end
