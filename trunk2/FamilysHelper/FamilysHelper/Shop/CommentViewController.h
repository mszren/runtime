//
//  CommentViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface CommentViewController : BaseViewController
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic,assign)NSInteger shopId;
@property (nonatomic,strong)NSString *shopName;
@property (nonatomic,strong)NSString *goodsName;
@end
