//
//  ShopHeaderView.h
//  FamilysHelper
//
//  Created by Owen on 15/7/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TribeModel.h"

@interface ShopHeaderView : UITableViewHeaderFooterView <MessageRoutable>
- (void)bindTribeModel:(TribeModel*)model;
@end
