//
//  YCDataBaseManager.m
//  Youcai4iPhoneFramework
//
//  Created by chengyan on 2017/12/26.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "YCDataBaseManager.h"
#import "YCFMDB.h"
#import "YCDBVideo.h"


@implementation YCDataBaseManager
{
    FMDatabase *_dataBase;
    FMDatabaseQueue *_dataQueue;
    BOOL _canlog;
}

+ (instancetype)shareInstance
{
    static YCDataBaseManager *_db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _db = [[YCDataBaseManager alloc]init];
        [_db openLog:YES];
    });
    return _db;
}

- (FMDatabase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [FMDatabase databaseWithPath:YCFM_SQLITE_FILE_PATH];
    }
    return _dataBase;
}

- (FMDatabaseQueue *)dataQueue
{
    if (_dataQueue == nil) {
        _dataQueue = [FMDatabaseQueue databaseQueueWithPath:YCFM_SQLITE_FILE_PATH];
        YCDBLog(@"%@",YCFM_SQLITE_FILE_PATH);
    }
    return _dataQueue;
}

- (void)openLog:(BOOL)open
{
    _canlog = open;
}

- (BOOL)canLog
{
    return _canlog;
}

- (void)test
{
    for (int i = 0; i < 10; i++) {
        YCDBVideo *video = [YCDBVideo entity];
        video.videoName = @(i).stringValue;
        [video save];
    }
}
@end
