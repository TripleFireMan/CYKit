//
//  YCDBModel
//  Youcai4iPhoneFramework
//
//  Created by chengyan on 2018/1/4.
//  Copyright © 2018年 Roy. All rights reserved.
//
/// 遵循此协议的模型可以实现数据库的持久化操作
/// 简化了一个对象持久化的数据库的难度，现在只需要实现YCDBModel协议，就可以将一个类以其类名创建数据库表，然后以其属性
/// 名称作为字段存储到数据库中。操作流程如下
/// 1.创建一个可持久化到数据库的类如YCDBVideo,并确认YCDBModel协议
/// 2.在.m文件中，YCDBMethods 执行此宏定义
///     2.1 @implementation YCDBVideo
///         YCDBMethods
///         @end
/// 3.基础能力 只需要实现attributeList方法，在此方法中定义需要持久化到数据库的字段名称和字段类型
///     3.1 + (NSDictionary <NSString *, NSNumber *> *)attributeList;
/// 4.进阶能力 如果要添加新的字段，但是项目已经发布了，这个时候怎么办？
///     4.1 + (BOOL)addColumnInDB:(FMDatabase *)db; 在此方法里面执行 YCDBAddNewColumn函数
///     4.2 + (NSDictionary <NSString *, NSNumber *> *)allAttributeList; 由于增加了新的字段，那么在数据初始化和保存的时候，需要将新增加的字段也加上。
///     4.3 + (BOOL)shouldPostDidSaveNotification; 监听数据库对象发生变化。
/// 4.其他根据自己的业务需求可以进行其他的扩展，DONE！

#import <Foundation/Foundation.h>
#import "YCFMDB.h"

/// 数据库保存成功发送通知
static NSString *const YCDBModelDidSaveNotification = @"YCDBModelDidSaveNotification";

typedef NS_ENUM(NSInteger, YCDBAttributeType){
    /// 数字
    YCDBAttributeType_NSInteger = 1,
    /// 长整型
    YCDBAttributeType_Double    = 2,
    /// 布尔类型
    YCDBAttributeType_BOOL      = 3,
    /// 短字符串
    YCDBAttributeType_NSString30 = 4,
    /// 长字符串
    YCDBAttributeType_NSString1024 = 5,
    /// 日期类型
    YCDBAttributeType_NSDate = 6,
    /// 二进制数据
    YCDBAttributeType_NSData = 7,
};

static inline NSString *YCDBAttributeString(YCDBAttributeType type){
    switch (type) {
        case YCDBAttributeType_NSInteger:
        case YCDBAttributeType_Double:
        case YCDBAttributeType_BOOL:
            return @"integer";
        case YCDBAttributeType_NSString1024:
            return @"varchar(1024)";
        case YCDBAttributeType_NSString30:
            return @"varchar(30)";
        case YCDBAttributeType_NSDate:
            return @"date";
        case YCDBAttributeType_NSData:
            return @"data";
        default:
            break;
    }
}

static inline BOOL YCDBAddNewColumn(NSString *column, YCDBAttributeType attType, FMDatabase *db, Class clazz){
    if (!column || attType <= 0 || !db) {
        return NO;
    }
    NSString *type = @"integer";
    switch (attType) {
        case YCDBAttributeType_NSDate:
            type = @"date";
            break;
        case YCDBAttributeType_NSString30:
            type = @"varchar(30)";
            break;
        case YCDBAttributeType_NSInteger:
        case YCDBAttributeType_BOOL:
        case YCDBAttributeType_Double:
            type = @"integer";
            break;
        case YCDBAttributeType_NSString1024:
            type = @"varchar(1024)";
            break;
        case YCDBAttributeType_NSData:
            type = @"data";
            break;
        default:
            break;
    }
    NSString *addColumnSql = [NSString stringWithFormat:@"alter table '%@' add column '%@' %@",NSStringFromClass(clazz),column,type];
    if (![db columnExists:column inTableWithName:NSStringFromClass(clazz)]) {
        BOOL addColumn = [db executeUpdate:addColumnSql];
        if (addColumn) {
            NSLog(@"添加列%@成功",column);
        }
        else{
            NSLog(@"添加列%@失败",column);
        }
        return addColumn;
    }
    else{
        return NO;
    }
}

@protocol YCDBModel <NSObject>

@required

/// 插入到数据库中唯一id,在数据库里面代表的是主键，由于id在oc是关键字，此处用sqlid代替
@property (nonatomic, strong) NSNumber *sqlid;
/// app的版本号
@property (nonatomic, copy  ) NSString *version;
/// 更新日期
@property (nonatomic, strong) NSDate *updateDate;
/// 创建日期
@property (nonatomic, strong) NSDate *createDate;

/// 采用数据库持久化的对象，必须执行此方法实例化对象
+ (id<YCDBModel>)entity;
/// 创建表，需要执行相应的建表语句
+ (BOOL)createTable;
/// 数据库表初始化的时候字段名称和类型，
/// 注意：此方法只有首次创建表时使用，如果后续有新增的字段，需要使用addColumnInDB：去扩展，不可在此方法中直接添加字段
+ (NSDictionary <NSString *, NSNumber *> *)attributeList;
/// 删除表
+ (void)dropTable;
/// 查询所有数据
+ (NSArray <id <YCDBModel>> *)findAll;
/// 保存操作
- (BOOL)save;
/// 删除数据操作
- (BOOL)remove;
/// 根据数据查询到的数据进行初始化，此方法作为辅助数据初始化，最外层业务方不需要调用，只在内部使用
- (id<YCDBModel>)initWithRs:(FMResultSet *)rs;

@optional
/// 实现此方法，可以添加一列字段，此方法在每次调用entity的时候都会触发，在此方法中可以执行YCDBAddNewColumn(),
/// 注意：使用此方法的条件是，初次创建数据库表之后，后续的版本有新需求需要增加新字段时使用，如果是首次创建的数据库表不需要使用此方法
+ (BOOL)addColumnInDB:(FMDatabase *)db;
/// 这个列表一定是attributeList列表的超集，里面包含了后续版本迭代的时候，新增的字段名称及类型
+ (NSDictionary <NSString *, NSNumber *> *)allAttributeList;
/// 是否要在保存成功之后发送通知,如果为YES，那么会以通知的形式发送此实例对象
+ (BOOL)shouldPostDidSaveNotification;
@end
