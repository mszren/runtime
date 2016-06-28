//
//  ActivityDao.h
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BaseDao.h"

@class ActivityModel;

@interface ActivityDao : BaseDao


- (void)insertWithModel:(ActivityModel *)aModel;
- (NSMutableArray *) selectModel:(ActivityModel *) model;
- (BOOL)deleteModel:(NSString *)aSql;

@end

