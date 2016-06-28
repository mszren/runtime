//
//  BaseDao.h
//  Core
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@class ASEntity;
@interface BaseDao : NSObject
{
    FMDatabase *db;
    NSString   *tableName;  //表名 
    NSString   *className; //对应实体的类名
}
@property (nonatomic, retain) FMDatabase *db;
@property (nonatomic, retain) NSString   *tableName;
@property (nonatomic, retain) NSString   *className;

/*
 @method      initWithTableName: ClassName:
 @abstract    实例化对象，参数为表名，对应实体类的类名.
 @result      id
 */
-(id) initWithTableName:(NSString*) aTableName ClassName:(NSString*)aClassName;

/*
 @method      setTable
 @abstract    根据参数设置要查询的表，返回查询的sql语句，.
 @result      NSString *
 */
-(NSString *)setSql:(NSString *)aSql;

/*
 @method      query: 
 @abstract    查询指定表,无参数查询（例如：select * from 表名），返回查询结果，
              查询结果包含表中所有记录，数组中每个元素是一条记录，记录是字典类型的，字典键是表的字段名
 @result      NSMutableArray *
 */
-(NSMutableArray *)query:(NSString*)aSql;

/*
 @method      query: andWhere:
 @abstract    查询指定表,有参数查询（例如：select * from 表名 where columnname = ?），返回查询结果，
              查询结果包含表中所有记录，数组中每个元素是一条记录，记录是字典类型的，字典键是表的字段名
 @result      NSMutableArray *
 */
-(NSMutableArray *)query:(NSString*)aSql andWhere:(NSArray*)aWhere;


/*
 @method      insertWithDictionary
 @abstract    向指定表插入数据
 @parameter   aDic字典里包含一条记录，键是字段名，值是要插入的值
 @result      void
 */
-(void)insertWithDictionary:(NSDictionary *)aDic;

/*
 @method      insertWithArray
 @abstract    向指定表插入数据
 @parameter   aArray数组里包含多条条记录，每一条记录是一个字典
 @result      void
 */
-(void)insertWithArray:(NSArray *)aArray;

/*
 @method      deleteWithDictionary: Dictionary:
 @abstract    删除指定表里的数据
 @parameter   aSql删除sql语句，要这样写：delete from tablename where columnname1 = :columnname1 and(or) ...
              aDic字典里是要删除条件，键是字段名;如果aDic为nil，则删除表里所有的数据
 @result      BOOL
 */
-(BOOL) deleteWithSql:(NSString*)aSql andDictionary:(NSDictionary *)aDic;

/*
 @method      updateWithSql: Dictionary:
 @abstract    更新指定表里的数据
 @parameter   aSql更新sql语句，要这样写：update tablename set columnname1=?,... where columnnamen = ? and(or) ...
              aArray数组存储的是和？对应数据
 @result      BOOL
 */
-(BOOL) updateWithSql:(NSString*)aSql andArray:(NSArray *)aArray;
@end
