//
//  MoreActivityCell.h
//  FamilysHelper
//
//  Created by hubin on 15/7/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface MoreActivityCell : UITableViewCell<MessageRoutable>

- (void)bindMoreActivity:(ActivityModel*)model;
@end
