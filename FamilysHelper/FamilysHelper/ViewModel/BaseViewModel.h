//
//  BaseViewModel.h
//  FamilysHelper
//
//  Created by 我 on 16/4/25.
//  Copyright © 2016年 shenbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

typedef void(^OnSuccess)(DataModel *dataModel);
@interface BaseViewModel : NSObject
@property (nonatomic, strong) UIViewController* viewContller;

@end
