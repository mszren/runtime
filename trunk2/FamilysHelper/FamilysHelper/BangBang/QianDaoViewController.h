//
//  QianDaoViewController.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableView.h"
@interface QianDaoViewController : BaseViewController
@property (nonatomic,assign) NSInteger tribeID;
@property (nonatomic,strong) EGOTableView *tableView;

@end
