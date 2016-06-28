//
//  interactionView.h
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/12.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface InteractCell : UITableViewCell <MessageRoutable>
@property (nonatomic, strong) EGOImageView* firstImage;
@property (nonatomic, strong) EGOImageView* secondImage;
@property (nonatomic, strong) EGOImageView* thirdImage;

- (void)bindTopic:(DataModel*)model;

@end
