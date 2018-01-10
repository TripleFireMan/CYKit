//
//  YCDataBaseManager.h
//  Youcai4iPhoneFramework
//
//  Created by chengyan on 2017/12/26.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

#define YCDBManager       [YCDataBaseManager shareInstance]
#define YCDataBase        [[YCDataBaseManager shareInstance] dataBase]
#define YCDataBaseQueue   [[YCDataBaseManager shareInstance] dataQueue]
#define YCDBLog(...)      if([[YCDataBaseManager shareInstance] canLog]){\
                            NSLog(__VA_ARGS__);\
                            }\
                            else{\
                                \
                            }
@interface YCDataBaseManager : NSObject

+ (instancetype)shareInstance;
/// FMDB的数据库，非线程安全，需要自己处理线程
- (FMDatabase *)dataBase;
/// FMDB的线程安全访问队列
- (FMDatabaseQueue *)dataQueue;
/// 打开调试开关
- (void)openLog:(BOOL)open;
- (BOOL)canLog;
- (void)test;
@end
