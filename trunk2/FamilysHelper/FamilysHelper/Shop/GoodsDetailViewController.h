//
//  GoodsDetailViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/28.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "SegmentNaviViewController.h"
#import "GoodsModel.h"
#import "TribeModel.h"

@interface GoodsDetailViewController : SegmentNaviViewController<MessageRoutable>

- (id)initWithGoodsID:(NSInteger)goodsID shopName:(NSString *)shopName shopID:(NSInteger)shopId goodsName:(NSString *)goodsName;
@end
