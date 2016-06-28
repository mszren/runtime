//
//  BangPublishController.h
//  FamilysHelper
//
//  Created by Owen on 15/6/16.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
#import "TagModel.h"

typedef void (^PublishRfresh)(void);

@interface BangPublishController : BaseViewController
@property (nonatomic,strong) TribeModel *tribeModel;
@property (nonatomic,copy)PublishRfresh publishRefresh;


@end
