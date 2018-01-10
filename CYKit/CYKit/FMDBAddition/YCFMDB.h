//
//  YCFMDB.h
//  Youcai4iPhoneFramework
//
//  Created by Roy on 2017/12/22.
//  Copyright © 2017年 Roy. All rights reserved.
//

#ifndef YCFMDB_h
#define YCFMDB_h

#import "FMDB.h"
#import "YCDataBaseManager.h"

#define YCFM_SHOULD_IMPLEMENTATION(_X) NSAssert([NSStringFromClass([self class]) isEqualToString:(_X)], @"subclass should implementation super class method");
#define YCFM_SQLITE_FILE_PATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"youcai.sqlite"]

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/// 创建实例
#ifndef YCDBModelCreateEntity
#define YCDBModelCreateEntity(clazz)    {[clazz createTable];\
id <YCDBModel> entity = [[clazz alloc]init];\
NSString *entityName = NSStringFromClass(clazz);\
[YCDataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {\
NSString *insertSql = [NSString stringWithFormat:@"insert into %@(updateDate,createDate,version) values(?,?,?)",entityName];\
BOOL success = [db executeUpdate:insertSql,[NSDate date],[NSDate date],APP_VERSION];\
entity.sqlid = @(db.lastInsertRowId);\
entity.version = APP_VERSION;\
entity.updateDate = [NSDate date];\
entity.createDate = [NSDate date];\
NSLog(@"sqlid = %@",entity.sqlid);\
if (success) {\
NSLog(@"插入数据 %@ 成功",entityName);\
}\
else{\
NSLog(@"插入数据 %@ 失败",entityName);\
}\
}];\
return entity;\
}
#endif
/// 删除表
#ifndef YCDBDropTable
#define YCDBDropTable(clazz)            {NSString *entityName = NSStringFromClass(clazz);\
NSString *deleteSql5 = [NSString stringWithFormat:@"drop table if exists %@",entityName];\
[YCDataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {\
BOOL success = NO;\
success = [db executeUpdate:deleteSql5];\
if (success) {\
NSString *msg = [NSString stringWithFormat:@"删除%@成功",entityName];\
NSLog(@"%@",msg);\
}\
else{\
NSString *msg = [NSString stringWithFormat:@"删除%@成功",entityName];\
NSLog(@"%@",msg);\
}\
}];\
}
#endif
/// 查询所有数据
#ifndef YCDBFindAll
#define YCDBFindAll(clazz)                  NSMutableArray *allEntity = [NSMutableArray array];\
[YCDataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {\
NSString *selectSql = [NSString stringWithFormat:@"select * from %@",NSStringFromClass(clazz)];;\
FMResultSet *rs = [db executeQuery:selectSql];\
while ([rs next]) {\
id <YCDBModel> entity = [[clazz alloc]initWithRs:rs];\
[allEntity addObject:entity];\
}\
}];\
return allEntity;

#endif

/// 删除数据
#ifndef YCDBRemove
#define YCDBRemove(clazz)                   __block BOOL success = NO;\
YCDBLog(@"将要删除下载%@",clazz);\
[YCDataBaseQueue inDatabase:^(FMDatabase *db) {\
NSString *sql = [NSString stringWithFormat:@"delete from %@ where sqlid = ?",NSStringFromClass([clazz class])];\
success = [db executeUpdate:sql,clazz.sqlid];\
if (success) {\
YCDBLog(@"%@删除成功",clazz.sqlid);\
}\
else{\
YCDBLog(@"%@删除失败",clazz.sqlid);\
}\
}];\
return success;
#endif

/// 保存
#ifndef YCDBSave
#define YCDBSave(clazz)                     NSAssert([[clazz class]respondsToSelector:@selector(attributeList)], @"数据库创建表必须实现attributeList:方法，用来定义数据库的表字段及类型");\
NSDictionary *attributeList = nil;\
if ([[clazz class]respondsToSelector:@selector(allAttributeList)]) {\
attributeList = [[clazz class]allAttributeList];\
}\
else {\
attributeList = [[clazz class]attributeList];\
}\
NSArray *allKeys = [attributeList allKeys];\
allKeys = [allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != 'sqlid'"]];\
NSInteger count = [allKeys count];\
NSMutableString *updateSql = [[NSMutableString alloc]initWithFormat:@"update %@ set ",NSStringFromClass([clazz class])];\
__block NSMutableArray *saveValues = [NSMutableArray array];\
[allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {\
BOOL isLast = (idx == count - 1);\
if (isLast) {\
[updateSql appendFormat:@"%@ = ?",obj];\
[saveValues addObject:[clazz valueForKey:obj]?:@""];\
}\
else{\
[updateSql appendFormat:@"%@ = ?,",obj];\
[saveValues addObject:[clazz valueForKey:obj]?:@""];\
}\
}];\
[updateSql appendFormat:@"where id = ?"];\
[saveValues addObject:[clazz valueForKey:@"sqlid"]?:@""];\
__block BOOL success = YES;\
[YCDataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {\
success = [db executeUpdate:updateSql withArgumentsInArray:saveValues];\
if (success) {\
if ([[clazz class] respondsToSelector:@selector(shouldPostDidSaveNotification)]) {\
if ([[clazz class] shouldPostDidSaveNotification]) {\
    [[NSNotificationCenter defaultCenter]postNotificationName:YCDBModelDidSaveNotification object:clazz];\
}\
}\
YCDBLog(@"更新 %@ success",NSStringFromClass([clazz class]));\
}\
else{\
YCDBLog(@"更新 %@ failed",NSStringFromClass([clazz class]));\
}\
}];\
return success;
#endif

/// 从数据库初始化
#ifndef YCDBInitWithRs
#define YCDBInitWithRs(clazz)               clazz = [super init];\
if (clazz) {\
NSAssert([[clazz class]respondsToSelector:@selector(attributeList)], @"数据库创建表必须实现attributeList:方法，用来定义数据库的表字段及类型");\
NSDictionary *attributeList = nil;\
if ([[clazz class]respondsToSelector:@selector(allAttributeList)]) {\
attributeList = [[clazz class]allAttributeList];\
}\
else {\
attributeList = [[clazz class]attributeList];\
}\
NSArray *allKeys = [attributeList allKeys];\
allKeys = [allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != 'sqlid'"]];\
[allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {\
YCDBAttributeType type = [attributeList[obj]integerValue];\
switch (type) {\
case YCDBAttributeType_BOOL:\
case YCDBAttributeType_Double:\
case YCDBAttributeType_NSInteger:\
{\
[clazz setValue:@([rs intForColumn:obj]) forKey:obj];\
}\
break;\
case YCDBAttributeType_NSString30:\
case YCDBAttributeType_NSString1024:\
{\
[clazz setValue:[rs stringForColumn:obj]?:@"" forKey:obj];\
}\
break;\
case YCDBAttributeType_NSDate:\
{\
[clazz setValue:[rs dateForColumn:obj]?:[NSDate date] forKey:obj];\
}\
break;\
default:\
break;\
}\
}];\
clazz.sqlid = @([rs intForColumn:@"id"]);\
}\
return clazz;
#endif

#ifndef YCDBCreateTabel
#define YCDBCreateTabel(clazz)              NSAssert([clazz respondsToSelector:@selector(attributeList)], @"数据库创建表必须实现attributeList:方法，用来定义数据库的表字段及类型");\
__block BOOL success = NO;\
NSMutableString *createSql = [[NSMutableString alloc]initWithFormat:@"create table if not exists '%@' ('id' integer primary key autoincrement not null,",NSStringFromClass(clazz)];\
NSDictionary *attributeList = [clazz attributeList];\
NSArray *allKeys = [attributeList allKeys];\
allKeys = [allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != 'sqlid'"]];\
NSInteger count = [allKeys count];\
[allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {\
BOOL isLast = (idx == count - 1);\
if (isLast) {\
[createSql appendFormat:@"'%@' %@)",obj,YCDBAttributeString([attributeList[obj]integerValue])];\
}\
else{\
[createSql appendFormat:@"'%@' %@,",obj,YCDBAttributeString([attributeList[obj]integerValue])];\
}\
}];\
YCDBLog(@"%@",createSql);\
[YCDataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {\
success = [db executeUpdate:createSql];\
if ([clazz respondsToSelector:@selector(addColumnInDB:)]) {\
[clazz addColumnInDB:db];\
}\
if(success == YES){\
YCDBLog(@"创建%@成功",NSStringFromClass(clazz));\
}\
else{\
YCDBLog(@"创建%@失败",NSStringFromClass(clazz));\
}\
}];\
return success;
#endif

/// 快捷式的实现获取实例、删除表、查询所有数据的方法定义
#ifndef YCDBMethos
#define YCDBMethods                         @synthesize updateDate;\
@synthesize createDate;\
@synthesize sqlid;\
@synthesize version;\
+ (BOOL)createTable {\
YCDBCreateTabel(self)\
}\
+ (id<YCDBModel>)entity{\
YCDBModelCreateEntity(self);\
}\
+ (void)dropTable{\
YCDBDropTable(self)\
}\
+ (NSArray <id <YCDBModel>> *)findAll{\
YCDBFindAll(self)\
}\
- (BOOL)remove{\
YCDBRemove(self)\
}\
- (BOOL)save{\
YCDBSave(self)\
}\
- (id<YCDBModel>)initWithRs:(FMResultSet *)rs{\
YCDBInitWithRs(self)\
}
#endif

#endif /* YCFMDB_h */
