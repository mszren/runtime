//
//  SelectTagsViewController.h
//  FamilysHelper
//
//  Created by 我 on 15/7/28.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOTag.h"
#import "TagView.h"
#import "TagModel.h"

typedef void(^Block) (NSInteger);
@interface SelectTagsViewController : BaseViewController<AOTagDelegate,TagViewDelegate>
@property (nonatomic,copy)Block tagsBlock;


@end
