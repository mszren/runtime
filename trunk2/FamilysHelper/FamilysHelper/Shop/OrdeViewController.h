//
//  OrderSViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/2.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "OrderModel.h"
@interface OrdeViewController : BaseViewController<MessageRoutable>
@property (nonatomic, strong) NSString* orderNum;
@property (nonatomic, assign) NSInteger goodsID;
@property (nonatomic,assign)NSInteger bangBi;
@property (nonatomic, strong) GoodsModel* goods;
@property (nonatomic,strong)NSString *shopName;
@property (nonatomic,strong)NSString *goodsName;
@property (nonatomic,strong)OrderModel *ordelModel;

@property (nonatomic, assign) SEL result;
//-(void)paymentResult:(NSString *)result;

-(id)initWithOrdelModel:(OrderModel *)model;

@end
