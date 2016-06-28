//
//  MemmberViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableView.h"

@interface MemmberViewController : BaseViewController

@property (nonatomic, assign) NSInteger tribeID;
@property (nonatomic, strong) UIView* segBarView;
@property (nonatomic, strong) EGOTableView* tableView;
@end
