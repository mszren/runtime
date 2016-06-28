//
//  MyOrderViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableView.h"
#import "UserService.h"

@interface MyOrderViewController : BaseViewController
@property (nonatomic, strong) EGOTableView* tableView;

@property (nonatomic, strong) DataModel* dataModel;

@end
