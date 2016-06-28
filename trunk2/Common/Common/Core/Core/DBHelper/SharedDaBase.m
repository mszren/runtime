//
//  SharedDaBase.m
//  Core
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "SharedDaBase.h"


static SharedDaBase * sharedDaBase;

@implementation SharedDaBase
@synthesize db;

#pragma mark -
#pragma mark Initialization and teardown
+ (id) sharedDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedDaBase = [[self alloc] init];
                  });
    return sharedDaBase;
}

- (id) init{
    self = [super init];
    if (self) {
        BOOL d = [self initDatabase];
        NSLog(@"%d",d);
    }
    return self;
}


#pragma mark -
#pragma mark app sqllite db initialize
- (BOOL)initDatabase{
    BOOL success;
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DBNAME];
    
    success = [fm fileExistsAtPath:writableDBPath];
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DBNAME];
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success){
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    if(success){
        self.db = [FMDatabase databaseWithPath:writableDBPath];
        if ([db open]){
            [db setShouldCacheStatements:YES];
        }else{
            NSLog(@"Failed to open database.");
            success = NO;
        }
    }
    return success;
}
- (void)closeDatabase{
    [self.db close];
}


@end
