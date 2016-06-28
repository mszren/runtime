//
//  InteractionCell.h
//  FamilysHelper
//
//  Created by Owen on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface InteractionCell : UITableViewCell
-(void) bindTopic:(TopicModel*)model;
@end
