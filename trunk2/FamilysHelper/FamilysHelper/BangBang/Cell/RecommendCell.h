//
//  RecommendCell.h
//  FamilysHelper
//
//  Created by Owen on 15/6/3.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeIndexModel.h"

@interface RecommendCell : UITableViewCell<MessageRoutable>
-(void) bindTribel:(TribeIndexModel*)model;
@end