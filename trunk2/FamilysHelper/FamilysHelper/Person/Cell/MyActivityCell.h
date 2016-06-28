//
//  MyActivityCell.h
//  FamilysHelper
//
//  Created by hubin on 15/7/23.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionModel.h"

@interface MyActivityCell : UITableViewCell<MessageRoutable>
- (void)bindData:(MyCollectionModel*)model;

@end
