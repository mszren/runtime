//
//  ActivityMemberCell.h
//  FamilysHelper
//
//  Created by 我 on 15/7/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"

@interface ActivityMemberCell : UITableViewCell

-(void) bindModel:(ActivityListModel *)model;

@end
