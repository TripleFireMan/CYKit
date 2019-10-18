//
//  CYDownloadSessionManager.m
//  AFNetworking
//
//  Created by 成焱 on 2019/10/15.
//

#import "CYDownloadSessionManager.h"
#import "AFNetworking.h"

static CYDownloadSessionManager *manager = nil;
@interface CYDownloadSessionManager ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@end
@implementation CYDownloadSessionManager
+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CYDownloadSessionManager alloc] init];
    });
    return manager;
}

- (id) init
{
    self = [super init];
    if (self) {
        self.backgroundConfig = @"CYDownloadSessionManager.backgroundConfig";
        self.downloadDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (CYDownloadModel *)getDownloadModelWithDownloadUrl:(NSString *)url
{
    return [self.downloadDic objectForKey:url];
}

- (void) configBackgroundSession
{
    //不支持后台下载
    if (!self.backgroundConfig) {
        return;
    }
    [self session];
}

//  下载session配置
- (NSURLSession *) session
{
    if (!_session) {
//        if (self.backgroundConfig) {
//            if (@available(iOS 8.0, *)) {
//                _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:self.backgroundConfig] delegate:self delegateQueue:self.queue];
//            } else {
//                // Fallback on earlier versions
//            }
//        }
//        else{
//
//        }
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:self.queue];
    }
    return _session;
}

#pragma mark - LOGIC

- (void) startDownload:(CYDownloadModel *)model
{
    NSLog(@"downloadmodel:%@",model);
    NSAssert(model, @"不存在下载模型");
    // 如果是等待状态，进行回调
    if (model.state == CYDownload_Wait) {
        [self downloadModel:model changeState:CYDownload_Wait filePath:nil error:nil];
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.downloadUrl]];
    [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:model.destinationFilePath] error:nil];
    model.task = [self.session downloadTaskWithRequest:request];
    model.task.taskDescription = model.downloadUrl;
    model.downloadDate = [NSDate date];
    [model.task resume];
    model.state = CYDownload_Downloading;
    //存起来，否则会释放掉
    [self.downloadDic setObject:model forKey:model.downloadUrl];
    //模拟请求取消，
//    __block NSData *resumdata = nil;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [model.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//            resumdata = resumeData;
//        }];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            model.task = [self.session downloadTaskWithResumeData:resumdata];
//            model.task.taskDescription = model.downloadUrl;
//            [model.task resume];
//        });
//    });
    //进行下载
}

- (void) startDownload:(CYDownloadModel *)model progress:(CYDownloadProgessBlock)progress state:(CYDownloadStateBlock)state
{
    self.progressBlock = progress;
    self.stateBlock = state;
    [self startDownload:model];
}

- (void) pause:(CYDownloadModel *)model
{
    [model.task suspend];
    model.state = CYDownload_Pause;
}

- (void) resume:(CYDownloadModel *)model
{
    [model.task resume];
    model.state = CYDownload_Downloading;
}

- (void) cancel:(CYDownloadModel *)model
{
    [model.task cancel];
    model.state = CYDownload_Cancel;
}

- (void) deleteModel:(CYDownloadModel *)model
{
    [model.task cancel];
    model.state = CYDownload_Cancel;
    //文件删除
    [self.downloadDic removeObjectForKey:model.downloadUrl];
    [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:model.downloadUrl] error:nil];
}

#pragma mark - HELP

- (void) downloadModel:(CYDownloadModel *)model changeState:(CYDownloadStatus)state filePath:(NSString *)filePath error:(NSError *)error
{
    if (self.stateBlock) {
        self.stateBlock(state, filePath, error);
    }
    if (model.stateBlock) {
        model.stateBlock(state, filePath, error);
    }
}

- (BOOL) moveFrom:(NSURL *)sourceUrl toDestinationUrl:(NSURL *)desUrl
{
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] moveItemAtURL:sourceUrl toURL:desUrl error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return success;
}

#pragma mark - Lazy

- (NSOperationQueue *) queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}

- (NSString *) downloadDirectory
{
    if (!_downloadDirectory) {
        _downloadDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CYDownlaodCache"];
        [self createDirectory:_downloadDirectory];
    }
    return _downloadDirectory;
}

- (void) createDirectory:(NSString *)directory
{
    //不存在文件夹，创建文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (AFURLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    }
    return _sessionManager;
}

#pragma mark - NSURLSessionDownloadDelegate
/// 下载完成
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"location:%@",location);
    CYDownloadModel *downloadModel = [self getDownloadModelWithDownloadUrl:downloadTask.taskDescription];
    if (downloadModel) {
        // 创建文件夹
        [self createDirectory:downloadModel.downloadDirectory];
        // 移动文件
        BOOL sucees = [self moveFrom:location toDestinationUrl:[NSURL fileURLWithPath:downloadModel.destinationFilePath]];
        if (sucees) {
            NSLog(@"移动成功");
        }
        else{
            NSLog(@"移动失败");
        }
    }
}

/// 进度回调
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 获取当前下载模型
    // 校验是否下载模型有效
    // 给当前下载模型的进度对象赋值
    CYDownloadModel *downloadModel = [self getDownloadModelWithDownloadUrl:downloadTask.taskDescription];
    
    if (!downloadModel) {
        return;
    }
    downloadModel.progrss.totalBytesWritten = totalBytesWritten;
    downloadModel.progrss.totalBytesExpectWritten = totalBytesExpectedToWrite;
    downloadModel.progrss.bytesWritten = bytesWritten;
    
    // 计算speed
    NSTimeInterval hasDownloadTime = -([downloadModel.downloadDate timeIntervalSinceNow]);
    int64_t hasDownloadBytes = (downloadModel.progrss.totalBytesWritten - downloadModel.progrss.resumeBytesWritten);
    float speed = hasDownloadBytes / hasDownloadTime;
    downloadModel.progrss.speed = speed;
    
    // 计算进度
    downloadModel.progrss.progress = (double) downloadModel.progrss.totalBytesWritten / downloadModel.progrss.totalBytesExpectWritten;
    // 计算剩余时间
    int64_t hasLeftBytes = totalBytesExpectedToWrite - totalBytesWritten;
    downloadModel.progrss.remainingTime = hasLeftBytes / speed;
    NSLog(@"%@",downloadModel.progrss);
    // 进行回调
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressBlock?self.progressBlock(downloadModel.progrss):nil;
    });
}

/// 断点续传
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"fileOffset:%@,总大小：%@",@(fileOffset),@(expectedTotalBytes));
    CYDownloadModel *downloadmodel = [self getDownloadModelWithDownloadUrl:downloadTask.taskDescription];
    if (!downloadmodel) {
        return;
    }
    downloadmodel.progrss.resumeBytesWritten = fileOffset;
}

/// 下载出错了
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    NSLog(@"error:%@",error);
    CYDownloadModel *downloadModel = [self getDownloadModelWithDownloadUrl:task.taskDescription];
    if (!error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            downloadModel.state = CYDownload_Downloaded;
            self.stateBlock?self.stateBlock(CYDownload_Downloaded,downloadModel.destinationFilePath,error):nil;
        });
    }
}

@end
