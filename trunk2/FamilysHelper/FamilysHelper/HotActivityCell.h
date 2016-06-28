//
//  HotActivityCell.h
//  FamilysHelper
//
//  Created by xujie on 15/7/15.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
@interface HotActivityCell : UITableViewCell <MessageRoutable>

- (void)bindActivity:(DataModel*)model;
@end
