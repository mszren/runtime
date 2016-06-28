//
//  TopicDetailController.h
//  FamilysHelper
//
//  Created by Owen on 15/6/8.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TopicModel.h"


@interface TopicDetailController : BaseViewController<MessageRoutable>
@property (nonatomic,assign) NSInteger publishID;
@property (nonatomic,assign) NSInteger tribeId;
 

@end
