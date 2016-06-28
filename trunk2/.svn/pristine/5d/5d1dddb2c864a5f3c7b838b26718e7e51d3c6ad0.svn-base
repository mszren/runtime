//
//  ActivityDao.m
//  Common
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "ActivityDao.h"
#import "ActivityModel.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation ActivityDao

#pragma mark -
#pragma mark Initialization and teardown
- (id) init{
    return [self initWithTableName:@"Activity" ClassName:@"ActivityModel"];
}

- (NSMutableArray *) selectModel:(ActivityModel *) model{
    NSString * newSql = [NSString stringWithFormat:@"Select * from Book where bookId = %ld",model.activityId];
    NSMutableArray * resultArr = [self query:newSql];
    return resultArr;
}


- (BOOL)deleteModel:(NSString *)aSql{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"Delete from Book where bookId in (%@)",aSql];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

//insert
- (void)insertWithModel:(ActivityModel *)aModel{
    NSDictionary * values = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithLong:aModel.activityId],@"activityId",
                             [NSNumber numberWithBool:aModel.isHot],@"isHot",
                             nil];
    [self insertWithDictionary:values];
}

@end
