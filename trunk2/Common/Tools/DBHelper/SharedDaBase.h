//
//  SharedDaBase.h
//  Core
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"

@interface SharedDaBase : NSObject{
    FMDatabase *db;//本机中使用的数据库
}
@property (nonatomic, strong) FMDatabase * db;

+ (id) sharedDataBase;

- (BOOL)initDatabase;
- (void)closeDatabase;
@end
