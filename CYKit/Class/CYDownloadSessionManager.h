//
//  CYDownloadSessionManager.h
//  AFNetworking
//
//  Created by 成焱 on 2019/10/15.
//

#import <Foundation/Foundation.h>
#import "CYDownloadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CYDownloadSessionManager : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic, copy) CYDownloadProgessBlock progressBlock;
@property (nonatomic, copy) CYDownloadStateBlock   stateBlock;
@property (nonatomic, copy) NSString *backgroundConfig;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSString *downloadDirectory;
@property (nonatomic, strong) NSMutableDictionary *downloadDic;
/// 单例
+ (instancetype) shareInstance;
/// 配置后台下载session
- (void) configBackgroundSession;
/// 根据url获取下载model
- (CYDownloadModel *) getDownloadModelWithDownloadUrl:(NSString *)url;
/// 获取后台下载任务
- (NSURLSessionDownloadTask *) getBackgroundDownloadTaskWithDownloadModel:(CYDownloadModel *)downloadModel;
/// 检测下是否下载完成
- (BOOL) isDownloadCompleteWithDownloadModel:(CYDownloadModel *)downloadModel;
/// 取消所有后台task
- (void) cancelAllBackgroundTasks;

/// 开始下载
- (CYDownloadModel *) startDownloadWithUrl:(NSString *)url
                       destinationFilePath:(NSString *)filePath
                                  progress:(CYDownloadProgessBlock)progress
                                     state:(CYDownloadStateBlock)state;

- (void) startDownload:(CYDownloadModel *)model;

- (void) startDownload:(CYDownloadModel *)model
              progress:(CYDownloadProgessBlock)progress
                 state:(CYDownloadStateBlock)state;
/// 暂停下载
- (void) pause:(CYDownloadModel *)model;
/// 恢复下载
- (void) resume:(CYDownloadModel *)model;
/// 取消下载
- (void) cancel:(CYDownloadModel *)model;
/// 删除下载
- (void) deleteModel:(CYDownloadModel *)model;
@end

NS_ASSUME_NONNULL_END
